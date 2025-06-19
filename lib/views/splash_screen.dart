import 'package:flutter/material.dart';
import 'dart:async';
import 'login_screen.dart';

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
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1565C0), // Warna biru tua seperti login
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo
            SizedBox(
              width: 200,
              height: 200,
              child: Image.asset(
                'assets/bubuy.png', // Pastikan path ini sesuai (tanpa /images jika tidak ada folder itu)
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 20),
            // Text atau Loading
            const CircularProgressIndicator(
              color: Colors.white,
            ),
            const SizedBox(height: 20),
            const Text(
              'Memuat aplikasi...',
              style: TextStyle(color: Colors.white70, fontSize: 16),
            )
          ],
        ),
      ),
    );
  }
}
