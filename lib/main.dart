import 'package:flutter/material.dart';
import 'screens/home_page.dart';

void main() {
  runApp(const CatPediaApp());
}

class CatPediaApp extends StatelessWidget {
  const CatPediaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CatPedia',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
