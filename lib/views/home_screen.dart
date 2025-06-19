import 'package:flutter/material.dart';
import '../models/article.dart';
import 'article_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedCategory = 'All';
  final TextEditingController _searchController = TextEditingController();

  final List<String> categories = [
    'All',
    'Bird',
    'Cat',
    'Fish',
    'Dog',
    'Rabbit',
  ];

  final List<Article> articles = [
    Article(
      id: '1',
      title: 'Sejarah burung pipit',
      category: 'Bird',
      imageUrl:
          'https://via.placeholder.com/150x100?text=Bird+Image', // Example placeholder URL
      content:
          'Burung pipit adalah salah satu burung kecil yang paling umum ditemukan di seluruh dunia. Mereka memiliki kemampuan adaptasi yang luar biasa.',
      author: 'Admin',
      createdAt: DateTime.now().subtract(const Duration(hours: 2)),
    ),
    Article(
      id: '2',
      title: 'Cara merawat kucing',
      category: 'Cat',
      imageUrl:
          'https://via.placeholder.com/150x100?text=Cat+Image', // Example placeholder URL
      content:
          'Kucing adalah hewan peliharaan yang membutuhkan perawatan khusus. Mereka memerlukan makanan berkualitas dan lingkungan yang bersih.',
      author: 'Dr. Hewan',
      createdAt: DateTime.now().subtract(const Duration(hours: 5)),
    ),
    Article(
      id: '3',
      title: 'Ikan hias air tawar',
      category: 'Fish',
      imageUrl:
          'https://via.placeholder.com/150x100?text=Fish+Image', // Example placeholder URL
      content:
          'Ikan hias air tawar menjadi pilihan populer untuk aquarium rumah karena perawatannya yang relatif mudah.',
      author: 'Aquarist',
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
  ];

  List<Article> get filteredArticles {
    List<Article> filtered =
        selectedCategory == 'All'
            ? articles
            : articles
                .where((article) => article.category == selectedCategory)
                .toList();

    if (_searchController.text.isNotEmpty) {
      filtered =
          filtered
              .where(
                (article) =>
                    article.title.toLowerCase().contains(
                      _searchController.text.toLowerCase(),
                    ) ||
                    article.content.toLowerCase().contains(
                      _searchController.text.toLowerCase(),
                    ),
              )
              .toList();
    }

    return filtered;
  }

  String _formatTimeAgo(DateTime dateTime) {
    final Duration diff = DateTime.now().difference(dateTime);
    if (diff.inDays > 0) {
      return '${diff.inDays}d ago';
    } else if (diff.inHours > 0) {
      return '${diff.inHours}h ago';
    } else if (diff.inMinutes > 0) {
      return '${diff.inMinutes}m ago';
    } else {
      return 'just now';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: Column(
          children: [
            // Header Section
            Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF1E88E5), Color(0xFF1565C0)],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Greeting
                  Row(
                    children: [
                      const Text(
                        'Hi, kaka 👋',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const Spacer(),
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.white.withOpacity(0.2),
                        child: const Icon(Icons.person, color: Colors.white),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Explore the Animals',
                    style: TextStyle(fontSize: 16, color: Colors.white70),
                  ),
                  const SizedBox(height: 20),

                  // Search Bar
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: _searchController,
                      onChanged: (value) => setState(() {}),
                      decoration: const InputDecoration(
                        hintText: 'Search news animals',
                        prefixIcon: Icon(Icons.search, color: Colors.grey),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Popular Animals Section
            Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Popular Animals',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Category Tabs
                  SizedBox(
                    height: 40,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        final category = categories[index];
                        final isSelected = selectedCategory == category;

                        return GestureDetector(
                          onTap:
                              () => setState(() => selectedCategory = category),
                          child: Container(
                            margin: const EdgeInsets.only(right: 12),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color:
                                  isSelected
                                      ? const Color(0xFF1565C0)
                                      : Colors.grey[200],
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              child: Text(
                                category,
                                style: TextStyle(
                                  color:
                                      isSelected
                                          ? Colors.white
                                          : Colors.grey[600],
                                  fontWeight:
                                      isSelected
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            // Articles List
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: filteredArticles.length,
                itemBuilder: (context, index) {
                  final article = filteredArticles[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) =>
                                  ArticleDetailScreen(article: article),
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          // Article Image
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(12),
                              bottomLeft: Radius.circular(12),
                            ),
                            child: Container(
                              width: 100,
                              height: 100,
                              color: Colors.grey[300],
                              child:
                                  article.imageUrl.isNotEmpty
                                      ? Image.network(
                                        article.imageUrl,
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) =>
                                                const Icon(
                                                  Icons.image,
                                                  color: Colors.grey,
                                                ),
                                      )
                                      : const Icon(
                                        Icons.image,
                                        color: Colors.grey,
                                      ),
                            ),
                          ),

                          // Article Content
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    article.title,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    article.content,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey[600],
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 2,
                                        ),
                                        decoration: BoxDecoration(
                                          color: const Color(
                                            0xFF1565C0,
                                          ).withOpacity(0.1),
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                        ),
                                        child: Text(
                                          article.category,
                                          style: const TextStyle(
                                            fontSize: 10,
                                            color: Color(0xFF1565C0),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      const Spacer(),
                                      Text(
                                        _formatTimeAgo(article.createdAt),
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.grey[500],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
