import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'signup_screen.dart';
import 'welcome_screen.dart';
import 'home_screen.dart';
import 'about_screen.dart'; // Import all the screen

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QuizBuzz',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginScreen(),
        '/signup': (context) => SignupScreen(),
        '/welcome': (context) => WelcomeScreen(),
        '/home': (context) => HomeScreen(),
        '/about': (context) => AboutScreen(), // Add this line for about screen
      },
    );
  }
}
