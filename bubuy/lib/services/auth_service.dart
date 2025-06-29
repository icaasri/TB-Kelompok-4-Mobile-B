// lib/services/auth_service.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
// import 'package:http/http.dart' as http; // HAPUS INI

import 'package:bubuy_lovers/models/user.dart';

class AuthService extends ChangeNotifier {
  User? _currentUser;
  // final String _baseUrl = 'http://45.149.187.204:3000'; // HAPUS INI

  // Data pengguna yang diregistrasi secara lokal (untuk simulasi)
  final Map<String, User> _registeredUsers = {};

  User? get currentUser => _currentUser;

  Future<void> loadCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString('currentUser');
    if (userJson != null) {
      _currentUser = User.fromJson(jsonDecode(userJson));
      // Untuk simulasi, tambahkan juga ke _registeredUsers jika belum ada
      if (_currentUser != null &&
          !_registeredUsers.containsKey(_currentUser!.username)) {
        _registeredUsers[_currentUser!.username] = _currentUser!;
      }
      notifyListeners();
      debugPrint(
          'User loaded from SharedPreferences: ${_currentUser!.username}');
    }
  }

  // Metode Register (Simulasi)
  Future<bool> register(String username, String email, String password) async {
    await Future.delayed(const Duration(seconds: 1)); // Simulasi delay

    // Simulasi validasi sederhana
    if (username.isEmpty || email.isEmpty || password.isEmpty) {
      debugPrint('Registrasi gagal: Data tidak boleh kosong.');
      return false;
    }
    if (password.length < 6) {
      debugPrint('Registrasi gagal: Password minimal 6 karakter.');
      return false;
    }
    if (_registeredUsers.containsKey(username)) {
      debugPrint('Registrasi gagal: Username sudah terdaftar.');
      return false; // Username sudah terdaftar
    }
    if (_registeredUsers.values.any((user) => user.email == email)) {
      debugPrint('Registrasi gagal: Email sudah terdaftar.');
      return false; // Email sudah terdaftar
    }

    // Jika semua validasi lokal lolos, simpan pengguna
    final newUser = User(username: username, email: email);
    _registeredUsers[username] = newUser;
    _currentUser = newUser; // Anggap langsung login setelah register
    await _saveCurrentUser(_currentUser!);
    notifyListeners();
    debugPrint('Registrasi berhasil (simulasi): $username');
    return true;
  }

  // Metode Login (Simulasi)
  Future<bool> login(String username, String password) async {
    await Future.delayed(const Duration(seconds: 1)); // Simulasi delay

    // Logika login simulasi
    if (_registeredUsers.containsKey(username)) {
      // Untuk demo, kita abaikan password, atau bisa tambahkan password hardcoded
      // Realistisnya: Anda akan membandingkan password dengan hash yang disimpan
      // if (username == "test" && password == "password123") {
      //   _currentUser = User(username: username, email: "test@example.com");
      // } else {
      //   return false;
      // }
      _currentUser =
          _registeredUsers[username]; // Ambil user dari daftar yang diregister
      await _saveCurrentUser(_currentUser!);
      notifyListeners();
      debugPrint('Login berhasil (simulasi): $username');
      return true;
    } else if (username == "kaka" && password == "password123") {
      // Contoh akun hardcoded untuk demo
      _currentUser = User(username: "kaka", email: "kaka@gmail.com");
      await _saveCurrentUser(_currentUser!);
      notifyListeners();
      debugPrint('Login berhasil (hardcoded): kaka');
      return true;
    }
    debugPrint(
        'Login gagal (simulasi): Username tidak ditemukan atau password salah.');
    return false; // Username tidak ditemukan
  }

  Future<void> logout() async {
    _currentUser = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('currentUser');
    notifyListeners();
    debugPrint('User logged out (simulasi)');
  }

  Future<void> _saveCurrentUser(User user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('currentUser', jsonEncode(user.toJson()));
    debugPrint('User saved to SharedPreferences (simulasi): ${user.username}');
  }
}
