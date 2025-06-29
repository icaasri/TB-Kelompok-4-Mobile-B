import 'package:flutter/material.dart';
import 'dart:async';
import 'package:bubuy_lovers/services/auth_service.dart';
import 'package:provider/provider.dart';

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
      final authService = Provider.of<AuthService>(context, listen: false);
      if (authService.currentUser != null) {
        Navigator.pushReplacementNamed(context, '/main');
      } else {
        Navigator.pushReplacementNamed(context, '/login');
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
              'assets/images/bubuy.png', // Pastikan path ini benar jika bubuy.png langsung di assets
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
