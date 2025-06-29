// lib/services/auth_service.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'package:bubuy_lovers/models/user.dart'; // Pastikan import ini benar

class AuthService extends ChangeNotifier {
  User? _currentUser;
  // Ini akan menyimpan semua pengguna yang diregistrasi secara simulasi
  // Key: username, Value: User object
  final Map<String, User> _registeredUsers = {};

  User? get currentUser => _currentUser;

  // Constructor
  AuthService() {
    // Muat pengguna yang sudah ada dari SharedPreferences saat service diinisialisasi
    // Ini penting agar sesi login sebelumnya tetap terjaga
    _loadAllRegisteredUsers(); // Tambahan untuk memuat semua user terdaftar
    loadCurrentUser(); // Memuat user terakhir yang login
  }

  // Metode untuk memuat SEMUA pengguna yang terdaftar dari SharedPreferences (baru)
  // Ini penting agar kita bisa 'mencari' pengguna saat login/register simulasi
  Future<void> _loadAllRegisteredUsers() async {
    final prefs = await SharedPreferences.getInstance();
    final allUsersJson = prefs.getString('allRegisteredUsers');
    if (allUsersJson != null) {
      Map<String, dynamic> decodedData = jsonDecode(allUsersJson);
      _registeredUsers.clear(); // Bersihkan data sebelumnya
      decodedData.forEach((key, value) {
        _registeredUsers[key] = User.fromJson(value as Map<String, dynamic>);
      });
      debugPrint(
          'All registered users loaded from SharedPreferences: ${_registeredUsers.keys}');
    }
  }

  // Metode untuk menyimpan SEMUA pengguna yang terdaftar ke SharedPreferences (baru)
  Future<void> _saveAllRegisteredUsers() async {
    final prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> usersToSave = {};
    _registeredUsers.forEach((key, value) {
      usersToSave[key] = value.toJson();
    });
    await prefs.setString('allRegisteredUsers', jsonEncode(usersToSave));
    debugPrint('All registered users saved to SharedPreferences.');
  }

  // Metode untuk memuat pengguna yang sedang login dari SharedPreferences
  Future<void> loadCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString('currentUser');
    if (userJson != null) {
      _currentUser = User.fromJson(jsonDecode(userJson));
      // Tambahkan juga ke _registeredUsers jika belum ada (untuk konsistensi)
      if (_currentUser != null &&
          !_registeredUsers.containsKey(_currentUser!.username)) {
        _registeredUsers[_currentUser!.username] = _currentUser!;
        // Perlu disimpan kembali jika ada penambahan baru dari currentUser
        await _saveAllRegisteredUsers();
      }
      notifyListeners();
      debugPrint(
          'Current user loaded from SharedPreferences: ${_currentUser!.username}');
    } else {
      debugPrint('No current user found in SharedPreferences.');
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
      debugPrint('Registrasi gagal: Username "$username" sudah terdaftar.');
      return false; // Username sudah terdaftar
    }
    if (_registeredUsers.values.any((user) => user.email == email)) {
      debugPrint('Registrasi gagal: Email "$email" sudah terdaftar.');
      return false; // Email sudah terdaftar
    }

    // Jika semua validasi lokal lolos, simpan pengguna
    // Penting: Di sini kita tidak menyimpan password dalam objek User,
    // karena User model hanya untuk data profil. Untuk autentikasi simulasi,
    // Anda bisa membuat Map terpisah untuk menyimpan username/password.
    // Untuk menyederhanakan demo: kita asumsikan password valid jika user ada.
    final newUser = User(
      username: username,
      email: email,
      // Anda bisa tambahkan default address, phone, department di sini jika mau
      address: '',
      phone: '',
      department: '',
    );

    _registeredUsers[username] =
        newUser; // Simpan user ke daftar user terdaftar
    await _saveAllRegisteredUsers(); // Simpan daftar user terdaftar ke SharedPreferences

    _currentUser = newUser; // Anggap langsung login setelah register
    await _saveCurrentUser(
        _currentUser!); // Simpan current user ke SharedPreferences
    notifyListeners();
    debugPrint('Registrasi berhasil (simulasi): $username');
    return true;
  }

  // Metode Login (Simulasi)
  Future<bool> login(String username, String password) async {
    await Future.delayed(const Duration(seconds: 1)); // Simulasi delay

    // Logika login simulasi
    // Cek di antara user yang terdaftar
    if (_registeredUsers.containsKey(username)) {
      // Untuk demo ini, kita tidak menyimpan password di objek User.
      // Jadi, kita hanya memeriksa keberadaan username.
      // Jika ingin memeriksa password: Anda harus menyimpan password (atau hash-nya)
      // di _registeredUsers bersama dengan objek User.
      // Contoh jika Anda menyimpan password juga:
      // if (_registeredUsers[username]?.password == password) { ... }
      // Untuk tujuan demo, kita abaikan password untuk _registeredUsers.
      // Namun, tambahkan akun hardcoded 'kaka' dengan password tertentu.

      if (username == "kaka" && password == "password123") {
        _currentUser = User(
          username: "kaka",
          email: "kaka@gmail.com",
          address: "Jl. Contoh No. 1",
          phone: "08123456789",
          department: "IT",
        );
      } else {
        // Jika username ada di _registeredUsers tapi bukan 'kaka',
        // untuk demo ini kita asumsikan passwordnya valid.
        // Dalam aplikasi nyata, Anda HARUS memverifikasi password!
        _currentUser = _registeredUsers[username];
      }

      await _saveCurrentUser(_currentUser!);
      notifyListeners();
      debugPrint('Login berhasil (simulasi): $username');
      return true;
    }

    debugPrint('Login gagal (simulasi): Username tidak ditemukan.');
    return false; // Username tidak ditemukan
  }

  // Metode Logout
  Future<void> logout() async {
    _currentUser = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('currentUser'); // Hapus sesi login terakhir
    notifyListeners();
    debugPrint('User logged out (simulasi)');
  }

  // Metode untuk menyimpan pengguna yang sedang login ke SharedPreferences
  Future<void> _saveCurrentUser(User user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('currentUser', jsonEncode(user.toJson()));
    debugPrint(
        'Current user saved to SharedPreferences (simulasi): ${user.username}');
  }

  // =========================================================================
  // Tambahan: Metode untuk Update Profil Pengguna
  // =========================================================================
  Future<bool> updateUser({
    String? username,
    String? email,
    String? address,
    String? phone,
    String? department,
  }) async {
    if (_currentUser == null) {
      debugPrint('Error: Tidak ada user yang login untuk diupdate.');
      return false;
    }

    // Buat objek User baru dengan data yang diperbarui
    final updatedUser = _currentUser!.copyWith(
      username: username,
      email: email,
      address: address,
      phone: phone,
      department: department,
    );

    // Simulasi update ke backend (jika Anda punya API untuk update profile)
    await Future.delayed(const Duration(milliseconds: 500)); // Simulasi delay

    // Update _currentUser lokal
    _currentUser = updatedUser;
    // Update juga di _registeredUsers agar data tersimpan persisten untuk login berikutnya
    _registeredUsers[updatedUser.username] = updatedUser;

    await _saveCurrentUser(
        _currentUser!); // Simpan current user ke SharedPreferences
    await _saveAllRegisteredUsers(); // Simpan daftar semua user terdaftar yang sudah diupdate

    notifyListeners(); // Beritahu listener (misal ProfileScreen)
    debugPrint('User updated locally (simulasi): ${updatedUser.username}');
    return true;
  }
}
