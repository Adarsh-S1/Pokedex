import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'home_page/welcome_page.dart';

void main() {
  Gemini.init(
    apiKey: 'AIzaSyDCClIJRsgqwoNvGYIOaqbPHrZZG-SzgSI',
    generationConfig: GenerationConfig(
      temperature: 0.6,
      maxOutputTokens: 150,
      topP: 0.8,
    ),
    enableDebugging: false,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      home: const WelcomePage(),
    );
  }
}
