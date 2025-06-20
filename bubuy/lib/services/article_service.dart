// services/article_service.dart
import 'package:flutter/material.dart';
import '../models/article.dart';

class ArticleService extends ChangeNotifier {
  final List<Article> _articles = [
    Article(
      id: '1',
      title: 'Sejarah burung pipit',
      category: 'Bird',
      imageUrl: 'https://via.placeholder.com/150x100?text=Bird+Image+1',
      content:
          'Burung pipit adalah salah satu burung kecil yang paling umum ditemukan di seluruh dunia. Mereka memiliki kemampuan adaptasi yang luar biasa, mampu hidup di berbagai habitat mulai dari perkotaan hingga pedesaan. Makanan utama mereka adalah biji-bijian, meskipun mereka juga memakan serangga. Pipit dikenal karena suaranya yang khas dan kebiasaannya berkumpul dalam kawanan besar, terutama saat mencari makan atau menjelang tidur. Sejarah evolusinya menunjukkan kemampuan adaptasi yang luar biasa terhadap perubahan lingkungan.',
      author: 'Admin',
      createdAt: DateTime.now().subtract(const Duration(hours: 2)),
      isFavorite: false,
    ),
    Article(
      id: '2',
      title: 'Cara merawat kucing',
      category: 'Cat',
      imageUrl: 'https://via.placeholder.com/150x100?text=Cat+Image+2',
      content:
          'Kucing adalah hewan peliharaan yang membutuhkan perawatan khusus. Mereka memerlukan makanan berkualitas dan lingkungan yang bersih. Memberikan vaksinasi rutin dan kunjungan ke dokter hewan adalah kunci untuk menjaga kesehatan mereka. Selain itu, interaksi sosial dan mainan juga penting untuk kebahagiaan kucing. Membersihkan kotak pasir secara teratur dan menyediakan tempat istirahat yang nyaman akan membuat kucing merasa nyaman di rumah Anda.',
      author: 'Dr. Hewan',
      createdAt: DateTime.now().subtract(const Duration(hours: 5)),
      isFavorite: false,
    ),
    Article(
      id: '3',
      title: 'Ikan hias air tawar',
      category: 'Fish',
      imageUrl: 'https://via.placeholder.com/150x100?text=Fish+Image+3',
      content:
          'Ikan hias air tawar menjadi pilihan populer untuk aquarium rumah karena perawatannya yang relatif mudah. Beberapa jenis populer antara lain ikan cupang, guppy, dan neon tetra. Penting untuk memastikan kualitas air yang baik, suhu yang stabil, dan pakan yang sesuai. Ukuran akuarium juga harus memadai agar ikan memiliki ruang yang cukup untuk berenang. Menjaga kebersihan akuarium secara rutin akan mencegah penyakit dan membuat ikan tetap sehat dan aktif.',
      author: 'Aquarist',
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
      isFavorite: false,
    ),
    Article(
      id: '4',
      title: 'Melatih anjing pintar',
      category: 'Dog',
      imageUrl: 'https://via.placeholder.com/150x100?text=Dog+Image+4',
      content:
          'Melatih anjing memerlukan kesabaran dan konsistensi. Mulailah dengan perintah dasar seperti duduk dan datang. Gunakan metode penguatan positif dengan hadiah dan pujian. Sesi latihan yang singkat namun seringkali lebih efektif daripada sesi panjang. Sosialisasi dini sangat penting agar anjing terbiasa dengan berbagai situasi dan orang. Ingatlah bahwa setiap anjing belajar dengan kecepatan yang berbeda, jadi sabar adalah kuncinya.',
      author: 'Dog Trainer',
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
      isFavorite: false,
    ),
    Article(
      id: '5',
      title: 'Kelincahan kelinci',
      category: 'Rabbit',
      imageUrl: 'https://via.placeholder.com/150x100?text=Rabbit+Image+5',
      content:
          'Kelinci adalah hewan yang sangat aktif dan membutuhkan banyak ruang untuk bergerak. Mereka suka melompat dan berlari, menunjukkan kelincahan yang mengesankan. Makanan utama mereka adalah hay (rumput kering), dilengkapi dengan sayuran hijau dan sedikit pelet. Gigi kelinci tumbuh terus-menerus, sehingga mereka perlu mengunyah sesuatu yang keras untuk menjaga kesehatan gigi mereka. Memberikan lingkungan yang aman dan stimulatif akan membuat kelinci Anda bahagia dan sehat.',
      author: 'Pet Lover',
      createdAt: DateTime.now().subtract(const Duration(days: 3)),
      isFavorite: false,
    ),
  ];

  List<Article> get articles => _articles;

  List<Article> get favoriteArticles =>
      _articles.where((article) => article.isFavorite).toList();

  Future<void> addArticle(Article article) async {
    await Future.delayed(
        const Duration(milliseconds: 500)); // Simulasi delay penyimpanan
    _articles.add(article);
    notifyListeners();
  }

  Future<void> toggleFavorite(String articleId) async {
    await Future.delayed(const Duration(milliseconds: 200)); // Simulasi delay
    final index = _articles.indexWhere((article) => article.id == articleId);
    if (index != -1) {
      _articles[index].isFavorite = !_articles[index].isFavorite;
      notifyListeners(); // Beri tahu pendengar bahwa daftar favorit mungkin berubah
    }
  }

  // Metode untuk menghapus artikel dari daftar favorit (jika diperlukan dari FavoriteScreen)
  Future<void> removeFavorite(String articleId) async {
    await Future.delayed(const Duration(milliseconds: 200)); // Simulasi delay
    final index = _articles.indexWhere((article) => article.id == articleId);
    if (index != -1) {
      _articles[index].isFavorite = false; // Set isFavorite ke false
      notifyListeners(); // Beri tahu pendengar
    }
  }
}
