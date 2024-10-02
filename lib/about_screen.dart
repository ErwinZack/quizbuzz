import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Container(
            constraints:
                BoxConstraints.expand(), // Ensure it covers the whole screen
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'android/assets/about_screen.png', // Ensure this path matches your actual asset path
                ),
                fit:
                    BoxFit.cover, // Make sure the image covers the whole screen
              ),
            ),
          ),
          // Column to place title, back button, and educational text
          Column(
            children: [
              // Title and back button row
              Padding(
                padding:
                    const EdgeInsets.only(top: 40.0, left: 16.0, right: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Back arrow
                    IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () {
                        Navigator.pop(
                            context); // Navigate back to the previous screen
                      },
                    ),
                    // About text
                    Text(
                      'About',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // Empty widget to balance the row
                    SizedBox(width: 48), // Adjust width to match the icon size
                  ],
                ),
              ),
              // Spacer to push the main content down
              Spacer(),
              // Educational text centered, adjusted to be higher
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Adjust this SizedBox to move the text up or down
                      SizedBox(
                          height:
                              50), // Increase or decrease the height as needed
                      Text(
                        'The QuizBuzz Educational Game helps users learn by answering multiple-choice questions. The app shows questions, lets users pick answers, and tells them if they are right or wrong. It keeps track of their scores and progress, making learning fun and easy. This app is user-friendly and aims to enhance education by combining learning with an engaging quiz format. Built using Flutter, the app runs smoothly on mobile devices.',
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      // Add more space if needed below the text
                      SizedBox(
                          height: 400), // Adjust this value to your preference
                    ],
                  ),
                ),
              ),
              // Spacer to push the educational text up
              // Removed unnecessary Spacer here
            ],
          ),
        ],
      ),
    );
  }
}
