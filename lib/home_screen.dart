import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Welcome to Homework Tracker!' ,
          style: TextStyle(fontSize: 24, color: Colors.green, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}