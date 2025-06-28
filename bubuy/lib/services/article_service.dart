import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:bubuy_lovers/models/article.dart';
import 'package:bubuy_lovers/services/auth_service.dart';

class ArticleService extends ChangeNotifier {
  List<Article> _articles = [];
  final String _baseUrl = 'https://api.yourapps.com';

  ArticleService() {
    fetchArticles();
  }

  List<Article> get articles => _articles;

  List<Article> get favoriteArticles =>
      _articles.where((article) => article.isFavorite).toList();

  Future<void> fetchArticles() async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/articles'),
      );

      if (response.statusCode == 200) {
        List<dynamic> articlesJson = jsonDecode(response.body);
        _articles = articlesJson.map((json) => Article.fromJson(json)).toList();
        notifyListeners();
      } else {
        debugPrint(
            'Failed to load articles: ${response.statusCode} ${response.body}');
      }
    } catch (e) {
      debugPrint('Error fetching articles: $e');
    }
  }

  Future<void> addArticle(Article article) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/articles'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(article.toJson()),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final newArticleData = jsonDecode(response.body);
        _articles.add(Article.fromJson(newArticleData));
        notifyListeners();
      } else {
        debugPrint(
            'Failed to add article: ${response.statusCode} ${response.body}');
      }
    } catch (e) {
      debugPrint('Error adding article: $e');
    }
  }

  Future<void> toggleFavorite(String articleId) async {
    final index = _articles.indexWhere((article) => article.id == articleId);
    if (index != -1) {
      bool newFavoriteStatus = !_articles[index].isFavorite;
      _articles[index].isFavorite = newFavoriteStatus;

      try {
        final response = await http.patch(
          Uri.parse('$_baseUrl/articles/$articleId/favorite'),
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode({'isFavorite': newFavoriteStatus}),
        );

        if (response.statusCode == 200) {
          notifyListeners();
        } else {
          _articles[index].isFavorite = !newFavoriteStatus;
          debugPrint('Failed to toggle favorite: ${response.body}');
          notifyListeners();
        }
      } catch (e) {
        _articles[index].isFavorite = !newFavoriteStatus;
        debugPrint('Error toggling favorite: $e');
        notifyListeners();
      }
    }
  }

  Future<void> removeFavorite(String articleId) async {
    final index = _articles.indexWhere((article) => article.id == articleId);
    if (index != -1) {
      _articles[index].isFavorite = false;
      notifyListeners();
    }
  }
}
