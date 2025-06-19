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
}
