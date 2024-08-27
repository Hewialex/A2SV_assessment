import 'package:flutter/material.dart';
import 'package:flutter_assessment/feature/groceries/presentation/pages/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),  // Start with the splash screen
      debugShowCheckedModeBanner: false,
    );
  }
}
