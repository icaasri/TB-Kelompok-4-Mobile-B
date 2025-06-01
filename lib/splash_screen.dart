import 'package:flutter/material.dart';
import 'dart:async';

// Ini adalah contoh layar utama (Home Screen) aplikasi Anda.
// Ganti widget ini dengan UI halaman utama aplikasi Anda yang sebenarnya
// setelah splash screen selesai.
class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Berita Burung Terbaru'),
        backgroundColor: const Color.fromARGB(255, 68, 143, 255),
      ),
      body: const Center(
        child: Text('Konten utama aplikasi Bubuy Lovers'),
      ),
    );
  }
}

// Widget SplashScreen Anda
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Gunakan Timer untuk menunda transisi ke MainScreen
    // Splash screen akan terlihat selama 3 detik sebelum beralih
    Timer(const Duration(seconds: 3), () {
      // Navigasi ke MainScreen dan menghapus SplashScreen dari stack navigasi
      // agar pengguna tidak bisa kembali ke splash screen dengan tombol 'back'
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Atur latar belakang menjadi hitam sesuai dengan desain logo kamu
      backgroundColor: Colors.black,
      body: Center(
        child: Image.asset(
          'assets/bubuy.png', // Path ke gambar logo bubuy.png
          width: 250, // Lebar gambar
          height: 250, // Tinggi gambar
          fit: BoxFit.contain, // Memastikan gambar pas dalam kotak tanpa terpotong
        ),
      ),
    );
  }
}