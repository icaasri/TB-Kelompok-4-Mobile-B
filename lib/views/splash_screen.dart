// lib/splash_screen.dart

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:TB-Kelompok-4-Mobile-B/views/home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF003366),
      body: Center(
        child: Image.asset(
          'assets/images/bubuy_lovers_logo.png',
          width: 250,
          height: 250,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
