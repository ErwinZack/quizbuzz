import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter_application_3/home_screen.dart';

class ScienceScreen extends StatefulWidget {
  @override
  _ScienceScreenState createState() => _ScienceScreenState();
}

class _ScienceScreenState extends State<ScienceScreen>
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
      'question': 'What is the chemical symbol for water?',
      'answers': ['H2O', 'O2', 'CO2', 'NaCl'],
      'correctAnswer': 'H2O',
    },
    {
      'question': 'What planet is known as the Red Planet?',
      'answers': ['Earth', 'Mars', 'Jupiter', 'Venus'],
      'correctAnswer': 'Mars',
    },
    {
      'question': 'What gas do plants absorb from the atmosphere?',
      'answers': ['Oxygen', 'Carbon Dioxide', 'Nitrogen', 'Hydrogen'],
      'correctAnswer': 'Carbon Dioxide',
    },
    {
      'question': 'What is the powerhouse of the cell?',
      'answers': ['Nucleus', 'Ribosome', 'Mitochondria', 'Chloroplast'],
      'correctAnswer': 'Mitochondria',
    },
    {
      'question': 'What is the most abundant gas in Earth\'s atmosphere?',
      'answers': ['Oxygen', 'Carbon Dioxide', 'Nitrogen', 'Hydrogen'],
      'correctAnswer': 'Nitrogen',
    },
    {
      'question': 'What is the main organ of the circulatory system?',
      'answers': ['Heart', 'Lungs', 'Brain', 'Kidneys'],
      'correctAnswer': 'Heart',
    },
    {
      'question': 'What is the speed of light?',
      'answers': [
        '300,000 km/s',
        '150,000 km/s',
        '400,000 km/s',
        '500,000 km/s'
      ],
      'correctAnswer': '300,000 km/s',
    },
    {
      'question': 'What element do diamonds consist of?',
      'answers': ['Carbon', 'Silicon', 'Oxygen', 'Nitrogen'],
      'correctAnswer': 'Carbon',
    },
    {
      'question': 'Which planet is closest to the sun?',
      'answers': ['Venus', 'Earth', 'Mars', 'Mercury'],
      'correctAnswer': 'Mercury',
    },
    {
      'question': 'What is the largest organ in the human body?',
      'answers': ['Heart', 'Skin', 'Liver', 'Brain'],
      'correctAnswer': 'Skin',
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
                          buttonColor = Colors.grey;
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
                  'Science Questions',
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
                borderRadius:
                    BorderRadius.circular(30), // Border Radius for Button
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
                image: AssetImage(
                    'android/assets/home_screen.png'), // Your background image
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo positioned above the congratulations text
                Image.asset(
                  'android/assets/congratulations.png', // Your logo image
                  width: 300, // Adjust width as needed
                  height: 200, // Adjust height as needed
                ),
                SizedBox(height: 20), // Space between logo and text
                Text(
                  'You finished the quiz! Well played! ',
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
                    onRestart(); // Reset quiz state
                    Navigator.pop(context); // Go back to the science screen
                  },
                  child: const Text('Back to Quiz',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
                SizedBox(height: 20),
                // Exit button to return to home page
                IconButton(
                  icon: Icon(Icons.exit_to_app, color: Colors.white),
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => HomeScreen()),
                      (route) => false, // Remove all previous routes
                    ); // Navigate to home
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
