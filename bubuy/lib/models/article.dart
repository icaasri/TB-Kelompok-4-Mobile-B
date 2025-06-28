// lib/models/article.dart
class Article {
  final String id;
  final String title;
  final String category;
  final String imageUrl;
  final String content;
  final String author;
  final DateTime createdAt;
  bool isFavorite;

  Article({
    required this.id,
    required this.title,
    required this.category,
    required this.imageUrl,
    required this.content,
    required this.author,
    required this.createdAt,
    this.isFavorite = false,
  });

  // Factory constructor untuk membuat objek Article dari JSON
  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      id: json['id'] as String,
      title: json['title'] as String,
      category: json['category'] as String,
      imageUrl: json['imageUrl'] as String,
      content: json['content'] as String,
      author: json['author'] as String,
      // Penting: Pastikan format tanggal dari API bisa di-parse oleh DateTime.parse
      createdAt: DateTime.parse(json['createdAt'] as String),
      isFavorite: json['isFavorite'] as bool? ??
          false, // isFavorite mungkin opsional dari API
    );
  }

  // Metode untuk mengonversi Article ke Map (jika Anda ingin mengirim ke API)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'category': category,
      'imageUrl': imageUrl,
      'content': content,
      'author': author,
      'createdAt': createdAt.toIso8601String(), // Format ke ISO 8601 string
      'isFavorite': isFavorite,
    };
  }
}
