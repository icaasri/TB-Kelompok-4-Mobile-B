// lib/splash_screen.dart

import 'package:flutter/material.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

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
        MaterialPageRoute(builder: (context) => const MainScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold( // ← const dihapus agar tidak error
      backgroundColor: Colors.black,
      body: Center(
        child: Image.asset(
          'images/bubuy.png',
          width: 250,
          height: 250,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Berita Burung Terbaru'),
        backgroundColor: Colors.blueAccent,
      ),
      body: const Center(
        child: Text(
          'Konten utama aplikasi Bubuy Lovers',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
