import 'package:flutter/material.dart';
import 'package:nasa_apod/view/apodview.dart';
import 'package:nasa_apod/view/about_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => Apodview(),
        '/about': (context) => AboutScreen(), // Add this route
      },
    );
  }
}
