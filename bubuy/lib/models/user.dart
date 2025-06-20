// models/user.dart
import 'dart:convert';

class User {
  final String username;
  final String email;
  // Anda bisa menambahkan properti lain seperti id, profilePicture, dll.

  User({required this.username, required this.email});

  // Metode untuk mengonversi User ke Map (untuk shared_preferences)
  Map<String, dynamic> toJson() => {
        'username': username,
        'email': email,
      };

  // Metode untuk membuat User dari Map (dari shared_preferences)
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['username'] as String,
      email: json['email'] as String,
    );
  }
}
