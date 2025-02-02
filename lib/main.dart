import 'package:flutter/material.dart';
import 'package:text_recognition/views/splash_view.dart';
import 'package:text_recognition/views/theme/app_colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Text converter',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: blueColor),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}



