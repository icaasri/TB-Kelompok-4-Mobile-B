// lib/views/splash_screen.dart
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:bubuy_lovers/services/auth_service.dart'; // Import AuthService
import 'package:provider/provider.dart'; // Import Provider

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
      // Periksa status login setelah splash selesai
      final authService = Provider.of<AuthService>(context, listen: false);
      if (authService.currentUser != null) {
        Navigator.pushReplacementNamed(
            context, '/main'); // Jika sudah login, ke MainNavigation
      } else {
        Navigator.pushReplacementNamed(
            context, '/login'); // Jika belum, ke LoginScreen
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF003366), // Gradien biru gelap
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/bubuy.png', // Pastikan path ini benar jika bubuy.png langsung di assets
              // atau 'assets/images/bubuy.png' jika di subfolder images
              height: 200, // Sesuaikan ukuran
            ),
            const SizedBox(height: 16),
            const Text(
              'Bubuy Lovers News', // Tambahkan teks jika diinginkan
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),
            const CircularProgressIndicator(
              color: Colors.white,
            ),
            const SizedBox(height: 10),
            const Text(
              'Loading...',
              style: TextStyle(color: Colors.white70, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
