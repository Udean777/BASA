import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:translate_app/components/splash_screen.dart';
import 'package:translate_app/screens/home_screen.dart';
import 'package:translate_app/screens/prompt_screen.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      routes: {
        "/home": (context) => const HomeScreen(),
        "/prompt": (context) => const PromptScreen(),
      },
    );
  }
}
