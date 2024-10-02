import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'android/assets/welcome_background.png'), // Ensure this path is correct
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(height: 100),
            Container(
              width: MediaQuery.of(context).size.width *
                  0.6, // 60% of the screen width
              child: _buildGradientButton(
                context,
                'Play Quiz',
                () {
                  Navigator.pushNamed(
                      context, '/home'); // Navigate to HomeScreen
                },
              ),
            ),
            SizedBox(height: 26),
            Container(
              width: MediaQuery.of(context).size.width *
                  0.6, // 60% of the screen width
              child: _buildGradientButton(
                context,
                'About',
                () {
                  Navigator.pushNamed(
                      context, '/about'); // Navigate to AboutScreen
                },
              ),
            ),
            SizedBox(height: 150),
          ],
        ),
      ),
    );
  }

  Widget _buildGradientButton(
      BuildContext context, String text, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        padding: EdgeInsets.zero, // Remove padding to fit the gradient
        backgroundColor: Colors.transparent, // Make the button transparent
      ),
      child: Ink(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF7694FF),
              Color(0xFF1C2BAF),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          alignment: Alignment.center,
          width: double.infinity, // Make the button take the full width
          height: 60, // Fixed height
          child: Text(
            text,
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
