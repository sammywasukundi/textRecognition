import 'package:flutter/material.dart';
import 'package:text_recognition/views/home_view.dart';

import 'theme/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashSreenState();
}

class _SplashSreenState extends State<SplashScreen> {

  @override
  void initState() {
    Future.delayed(const Duration( seconds: 3),(){
      // ignore: use_build_context_synchronously
      Navigator.push(context, MaterialPageRoute(builder: (context) => const MyHomePage()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: 40.0,
          width: 40.0,
          child: CircularProgressIndicator(
            color: blueColor,
          ),
        ),
      ),
    );
  }
}