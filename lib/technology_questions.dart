import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter_application_3/home_screen.dart';

class TechnologyScreen extends StatefulWidget {
  @override
  _TechnologyScreenState createState() => _TechnologyScreenState();
}

class _TechnologyScreenState extends State<TechnologyScreen>
    with SingleTickerProviderStateMixin {
  double _timerValue = 1.0;
  late Timer _timer;
  int _remainingTime = 30;
  int _currentQuestionIndex = 0;
  int _score = 0;
  String? _selectedAnswer;
  String _feedback = '';

  late AnimationController _animationController;
  late Animation<double> _shakeAnimation;

  final List<Map<String, dynamic>> _questions = [
    {
      'question': 'What does HTTP stand for?',
      'answers': [
        'HyperText Transfer Protocol',
        'HighText Transfer Protocol',
        'HyperText Transport Protocol',
        'HighText Transport Protocol'
      ],
      'correctAnswer': 'HyperText Transfer Protocol',
    },
    {
      'question':
          'Which programming language is primarily used for Android development?',
      'answers': ['Java', 'Python', 'C#', 'JavaScript'],
      'correctAnswer': 'Java',
    },
    {
      'question': 'What does GPU stand for?',
      'answers': [
        'Graphics Processing Unit',
        'Graphics Programming Unit',
        'General Processing Unit',
        'General Programming Unit'
      ],
      'correctAnswer': 'Graphics Processing Unit',
    },
    {
      'question': 'Which company developed the iPhone?',
      'answers': ['Samsung', 'Nokia', 'Apple', 'Sony'],
      'correctAnswer': 'Apple',
    },
    {
      'question': 'What is the main function of an operating system?',
      'answers': [
        'Manage hardware and software',
        'Play games',
        'Edit documents',
        'Browse the internet'
      ],
      'correctAnswer': 'Manage hardware and software',
    },
    {
      'question':
          'What is the most widely used programming language in web development?',
      'answers': ['HTML', 'Python', 'JavaScript', 'C++'],
      'correctAnswer': 'JavaScript',
    },
    {
      'question': 'Which device is used to connect to the internet wirelessly?',
      'answers': ['Modem', 'Router', 'Switch', 'Hub'],
      'correctAnswer': 'Router',
    },
    {
      'question': 'What is the full form of Wi-Fi?',
      'answers': [
        'Wireless Fidelity',
        'Wireless Format',
        'Wireless Fidelity Network',
        'None of the above'
      ],
      'correctAnswer': 'Wireless Fidelity',
    },
    {
      'question': 'What does HTML stand for?',
      'answers': [
        'HyperText Markup Language',
        'HyperText Markup List',
        'HighText Markup Language',
        'HyperText MultiLanguage'
      ],
      'correctAnswer': 'HyperText Markup Language',
    },
    {
      'question':
          'Which technology is used to make phone calls over the internet?',
      'answers': ['VoIP', 'VoLTE', 'SMS', 'MMS'],
      'correctAnswer': 'VoIP',
    },
  ];

  @override
  void initState() {
    super.initState();
    _startTimer();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _shakeAnimation = Tween<double>(begin: 0.0, end: 15.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.elasticInOut),
    );
  }

  void _startTimer() {
    _remainingTime = 30; // Reset the remaining time
    _timerValue = 1.0; // Reset the timer value
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _remainingTime--;
        _timerValue = _remainingTime / 30;
        if (_remainingTime <= 0) {
          _timer.cancel();
          _showQuizEndDialog();
        }
      });
    });
  }

  void _resetQuiz() {
    setState(() {
      _currentQuestionIndex = 0;
      _score = 0;
      _selectedAnswer = null;
      _feedback = '';
      _startTimer(); // Restart the timer
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _animationController.dispose();
    super.dispose();
  }

  void _handleAnswerSelection(String answer) {
    setState(() {
      _selectedAnswer = answer;
      // Check if the answer is correct
      if (answer == _questions[_currentQuestionIndex]['correctAnswer']) {
        _score++;
        _feedback = 'Correct!';
      } else {
        _feedback =
            'Incorrect! Correct answer: ${_questions[_currentQuestionIndex]['correctAnswer']}';
      }
    });

    // Delay to show feedback before going to the next question
    Future.delayed(Duration(seconds: 1), _nextQuestion);
  }

  void _nextQuestion() {
    if (_currentQuestionIndex < _questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
        _selectedAnswer = null;
        _feedback = ''; // Clear feedback for the next question
      });
    } else {
      _showQuizEndDialog();
    }
  }

  void _showQuizEndDialog() {
    _timer.cancel(); // Stop the timer when showing the end dialog
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ResultScreen(
          score: _score,
          total: _questions.length,
          onRestart: _resetQuiz, // Pass the reset function
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            constraints: BoxConstraints.expand(),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('android/assets/about_screen.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Container(
              margin:
                  EdgeInsets.symmetric(horizontal: 20.0).copyWith(bottom: 35),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                borderRadius: BorderRadius.circular(20.0),
              ),
              padding: EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Text(
                        '$_remainingTime s',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      Expanded(
                        child: Container(
                          height: 15,
                          margin: EdgeInsets.only(left: 10),
                          decoration: BoxDecoration(
                            color: Colors.grey[800],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: FractionallySizedBox(
                            alignment: Alignment.centerLeft,
                            widthFactor: _timerValue,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Text(
                      'Question ${_currentQuestionIndex + 1}/${_questions.length}',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                  Text(
                    _questions[_currentQuestionIndex]['question'],
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10),
                  // Display the feedback message
                  if (_feedback.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Text(
                        _feedback,
                        style: TextStyle(
                          fontSize: 18,
                          color: _feedback.startsWith('Correct')
                              ? Colors.green
                              : Colors.red,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  SizedBox(height: 30),
                  Column(
                    children: _questions[_currentQuestionIndex]['answers']
                        .asMap()
                        .entries
                        .map<Widget>((entry) {
                      final index = entry.key;
                      final answer = entry.value;
                      Color buttonColor;

                      // Assign a color based on the answer index
                      switch (index) {
                        case 0:
                          buttonColor = Colors.purple;
                          break;
                        case 1:
                          buttonColor = Colors.blue;
                          break;
                        case 2:
                          buttonColor = const Color.fromARGB(255, 30, 118, 141);
                          break;
                        case 3:
                          buttonColor = Colors.orange;
                          break;
                        default:
                          buttonColor = Colors.grey; // Fallback color
                      }

                      return Column(
                        children: [
                          _buildAnswerButton(answer, buttonColor),
                          SizedBox(height: 15),
                        ],
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 40.0, left: 16.0, right: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
                Text(
                  'Technology Questions',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 48),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnswerButton(String text, Color color) {
    Color borderColor = Colors.transparent;

    if (_selectedAnswer == text) {
      borderColor =
          _selectedAnswer == _questions[_currentQuestionIndex]['correctAnswer']
              ? Colors.green
              : Colors.red;
    }

    return Container(
      width: double.infinity,
      child: AnimatedBuilder(
        animation: _shakeAnimation,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(
              _selectedAnswer == text && _animationController.isAnimating
                  ? _shakeAnimation.value
                  : 0.0,
              0.0,
            ),
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: borderColor, width: 2),
              ),
              child: ElevatedButton(
                onPressed: () => _handleAnswerSelection(text),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                ),
                child: Text(
                  text,
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class ResultScreen extends StatelessWidget {
  final int score;
  final int total;
  final VoidCallback onRestart;

  const ResultScreen({
    Key? key,
    required this.score,
    required this.total,
    required this.onRestart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('android/assets/home_screen.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'android/assets/congratulations.png',
                  width: 300,
                  height: 200,
                ),
                SizedBox(height: 20),
                Text(
                  'You finished the quiz! Well played!',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                SizedBox(height: 20),
                Text(
                  'Your Score: $score/$total',
                  style: TextStyle(fontSize: 24, color: Colors.white),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    onRestart();
                    Navigator.pop(context);
                  },
                  child: const Text('Back to Quiz',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
                SizedBox(height: 20),
                IconButton(
                  icon: Icon(Icons.exit_to_app, color: Colors.white),
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => HomeScreen()),
                      (route) => false,
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
