import 'package:flutter/material.dart';
import 'trivia_questions.dart'; // Import your trivia screen
import 'science_questions.dart'; // Import your science screen
import 'technology_questions.dart'; // Import your technology screen
import 'history_questions.dart'; // Import your history screen
import 'login_screen.dart'; // Import your login screen

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Background music code removed
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      'android/assets/home_screen.png'), // Correct the asset path
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          // Column for AppBar and content
          Column(
            children: [
              // Title and back button row
              Padding(
                padding:
                    const EdgeInsets.only(top: 40.0, left: 16.0, right: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Back button
                    IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                    // Title text
                    Text(
                      'Select Category',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // Settings button
                    IconButton(
                      icon: Icon(Icons.settings, color: Colors.white),
                      onPressed: () => _showSettingsDialog(context),
                    ),
                  ],
                ),
              ),
              // Subtitle text
              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                child: Text(
                  'Let’s Play Quiz!',
                  style: TextStyle(
                    fontFamily: 'Coiny',
                    fontSize: 35,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // Main content below AppBar
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20.0,
                    mainAxisSpacing: 25.0,
                    children: [
                      _buildCategoryBox(context, 'Trivia', '10 questions',
                          'android/assets/Trivia.png'),
                      _buildCategoryBox(context, 'Science', '10 questions',
                          'android/assets/Science.png'),
                      _buildCategoryBox(context, 'Technology', '10 questions',
                          'android/assets/Technology.png'),
                      _buildCategoryBox(context, 'History', '10 questions',
                          'android/assets/History.png'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showSettingsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Settings'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Sound settings are not available.'),
              // Removed volume control slider
            ],
          ),
          actions: [
            TextButton(
              child: Text('Exit the game'),
              onPressed: () {
                _showExitConfirmationDialog(context);
              },
            ),
            TextButton(
              child: Text('Close'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }

  void _showExitConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Exit'),
          content: Text(
              'Do you want to exit the game and log in to another account?'),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
              child: Text('Exit'),
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                  (route) => false,
                ); // Navigate to login screen
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildCategoryBox(BuildContext context, String category,
      String questionCount, String imagePath) {
    return GestureDetector(
      onTap: () {
        // Navigate to the appropriate screen based on the category
        if (category == 'Trivia') {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => TriviaScreen()));
        } else if (category == 'Science') {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ScienceScreen()));
        } else if (category == 'Technology') {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => TechnologyScreen()));
        } else if (category == 'History') {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => HistoryScreen()));
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blueAccent.withOpacity(0.8),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 4.0,
              offset: Offset(0, 2),
            ),
          ],
        ),
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              imagePath,
              height: 50,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 8),
            Text(
              category,
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              questionCount,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
