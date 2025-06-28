// lib/services/auth_service.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http; // Import package http

import 'package:bubuy_lovers/models/user.dart'; // Sesuaikan import

class AuthService extends ChangeNotifier {
  User? _currentUser;
  final String _baseUrl = 'http://45.149.187.204:3000/swagger/api/bubuy-lovers';

  User? get currentUser => _currentUser;

  Future<void> loadCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString('currentUser');
    if (userJson != null) {
      _currentUser = User.fromJson(jsonDecode(userJson));
      notifyListeners();
    }
  }

  Future<bool> register(String username, String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/register'), // Endpoint registrasi
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': username,
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Asumsi API mengembalikan data pengguna setelah registrasi
        final responseData = jsonDecode(response.body);
        _currentUser = User.fromJson(
            responseData['user']); // Sesuaikan jika struktur API berbeda
        await _saveCurrentUser(_currentUser!);
        notifyListeners();
        return true;
      } else {
        debugPrint('Registrasi gagal: ${response.body}');
        return false;
      }
    } catch (e) {
      debugPrint('Error registrasi: $e');
      return false;
    }
  }

  Future<bool> login(String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/login'), // Endpoint login
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': username,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        // Asumsi API mengembalikan { "token": "...", "user": { ... } }
        _currentUser = User.fromJson(
            responseData['user']); // Sesuaikan jika struktur API berbeda
        // Simpan token untuk otentikasi di request selanjutnya jika API menggunakan token
        // await prefs.setString('authToken', responseData['token']);
        await _saveCurrentUser(_currentUser!);
        notifyListeners();
        return true;
      } else {
        debugPrint('Login gagal: ${response.body}');
        return false;
      }
    } catch (e) {
      debugPrint('Error login: $e');
      return false;
    }
  }

  Future<void> logout() async {
    _currentUser = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('currentUser');
    // Jika ada token, hapus juga
    // await prefs.remove('authToken');
    notifyListeners();
  }

  Future<void> _saveCurrentUser(User user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('currentUser', jsonEncode(user.toJson()));
  }

  // Future<String?> _getAuthToken() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   return prefs.getString('authToken');
  // }
}
