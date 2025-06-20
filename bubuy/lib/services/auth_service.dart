// services/auth_service.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../models/user.dart';

class AuthService extends ChangeNotifier {
  User? _currentUser;

  User? get currentUser => _currentUser;

  // Inisialisasi: Coba muat pengguna dari penyimpanan lokal saat aplikasi dimulai
  Future<void> loadCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString('currentUser');
    if (userJson != null) {
      _currentUser = User.fromJson(jsonDecode(userJson));
      notifyListeners();
    }
  }

  Future<bool> register(String username, String email, String password) async {
    // Simulasi registrasi berhasil.
    // Tambahkan validasi sederhana di sini jika belum di UI
    if (username.isEmpty || email.isEmpty || password.isEmpty) return false;
    if (password.length < 6) return false;

    await Future.delayed(const Duration(seconds: 1)); // Simulasi delay jaringan

    // Untuk demo, kita anggap register langsung login
    _currentUser = User(username: username, email: email);
    await _saveCurrentUser(_currentUser!);
    notifyListeners();
    return true;
  }

  Future<bool> login(String username, String password) async {
    await Future.delayed(const Duration(seconds: 1)); // Simulasi delay jaringan

    // Contoh validasi sederhana (ganti dengan logika backend asli)
    if (username == "kaka" && password == "password123") {
      _currentUser = User(username: username, email: "kaka@gmail.com");
      await _saveCurrentUser(_currentUser!);
      notifyListeners();
      return true;
    } else if (username == _currentUser?.username && password == "test12345") {
      // Contoh login dengan akun yang baru diregister
      // Ini asumsi jika akun yang diregister disimulasikan sebagai _currentUser
      // Dalam nyata, ini harus divalidasi dari backend
      _currentUser = User(username: username, email: _currentUser!.email);
      await _saveCurrentUser(_currentUser!);
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  Future<void> logout() async {
    _currentUser = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('currentUser');
    notifyListeners();
  }

  Future<void> _saveCurrentUser(User user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('currentUser', jsonEncode(user.toJson()));
  }
}
