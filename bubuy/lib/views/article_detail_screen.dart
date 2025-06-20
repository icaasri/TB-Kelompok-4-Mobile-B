// views/article_detail_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Import provider
import '../models/article.dart';
import '../services/article_service.dart'; // Import ArticleService

class ArticleDetailScreen extends StatelessWidget {
  final Article article;

  const ArticleDetailScreen({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    // Gunakan Consumer untuk mendengarkan perubahan status favorit artikel
    return Consumer<ArticleService>(
      builder: (context, articleService, child) {
        // Ambil artikel terbaru dari service untuk mendapatkan status isFavorite yang akurat
        final currentArticle =
            articleService.articles.firstWhere((a) => a.id == article.id);

        return Scaffold(
          appBar: AppBar(
            title: const Text('Article Detail'),
            backgroundColor: const Color(0xFF1565C0),
            foregroundColor: Colors.white,
            actions: [
              IconButton(
                // Tombol favorit
                icon: Icon(
                  currentArticle.isFavorite
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color: currentArticle.isFavorite ? Colors.red : Colors.white,
                ),
                onPressed: () {
                  articleService.toggleFavorite(currentArticle.id);
                },
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Article Image
                Container(
                  width: double.infinity,
                  height: 200,
                  color: Colors.grey[300],
                  child: currentArticle.imageUrl.isNotEmpty
                      ? Image.network(
                          currentArticle.imageUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.broken_image,
                                  size: 50,
                                  color: Colors
                                      .grey), // Ikon jika gambar gagal dimuat
                        )
                      : const Icon(Icons.image, size: 50, color: Colors.grey),
                ),

                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Category Badge
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1565C0).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Text(
                          currentArticle.category,
                          style: const TextStyle(
                            color: Color(0xFF1565C0),
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Title
                      Text(
                        currentArticle.title,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),

                      const SizedBox(height: 12),

                      // Author and Date
                      Row(
                        children: [
                          Text(
                            'By ${currentArticle.author}',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 14,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            '${currentArticle.createdAt.day}/${currentArticle.createdAt.month}/${currentArticle.createdAt.year}',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      // Content
                      Text(
                        currentArticle.content,
                        style: const TextStyle(
                          fontSize: 16,
                          height: 1.6,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
