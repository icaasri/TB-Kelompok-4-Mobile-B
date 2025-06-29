// lib/models/user.dart
import 'dart:convert';

class User {
  final String username;
  final String email;
  final String? address; // Tambahkan properti opsional
  final String? phone; // Tambahkan properti opsional
  final String? department; // Tambahkan properti opsional

  User({
    required this.username,
    required this.email,
    this.address, // Tambahkan ke konstruktor
    this.phone, // Tambahkan ke konstruktor
    this.department, // Tambahkan ke konstruktor
  });

  Map<String, dynamic> toJson() => {
        'username': username,
        'email': email,
        'address': address, // Tambahkan ke toJson
        'phone': phone, // Tambahkan ke toJson
        'department': department, // Tambahkan ke toJson
      };

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['username'] as String,
      email: json['email'] as String,
      address: json['address'] as String?, // Ambil sebagai nullable
      phone: json['phone'] as String?, // Ambil sebagai nullable
      department: json['department'] as String?, // Ambil sebagai nullable
    );
  }

  // Tambahkan metode copyWith untuk memudahkan update sebagian properti
  User copyWith({
    String? username,
    String? email,
    String? address,
    String? phone,
    String? department,
  }) {
    return User(
      username: username ?? this.username,
      email: email ?? this.email,
      address: address ?? this.address,
      phone: phone ?? this.phone,
      department: department ?? this.department,
    );
  }
}
