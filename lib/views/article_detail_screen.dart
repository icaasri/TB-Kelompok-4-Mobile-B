// import 'package:flutter/material.dart';
// import '../models/article.dart';

// class ArticleDetailScreen extends StatelessWidget {
//   final Article article;

//   const ArticleDetailScreen({super.key, required this.article});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Article Detail'),
//         backgroundColor: const Color(0xFF1565C0),
//         foregroundColor: Colors.white,
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Article Image
//             Container(
//               width: double.infinity,
//               height: 200,
//               color: Colors.grey[300],
//               child: const Icon(Icons.image, size: 50, color: Colors.grey),
//             ),

//             Padding(
//               padding: const EdgeInsets.all(20),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Category Badge
//                   Container(
//                     padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                     decoration: BoxDecoration(
//                       color: const Color(0xFF1565C0).withOpacity(0.1),
//                       borderRadius: BorderRadius.circular(15),
//                     ),
//                     child: Text(
//                       article.category,
//                       style: const TextStyle(
//                         color: Color(0xFF1565C0),
//                         fontWeight: FontWeight.bold,
//                         fontSize: 12,
//                       ),
//                     ),
//                   ),

//                   const SizedBox(height: 16),

//                   // Title
//                   Text(
//                     article.title,
//                     style: const TextStyle(
//                       fontSize: 24,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black87,
//                     ),
//                   ),

//                   const SizedBox(height: 12),

//                   // Author and Date
//                   Row(
//                     children: [
//                       Text(
//                         'By ${article.author}',
//                         style: TextStyle(
//                           color: Colors.grey[600],
//                           fontSize: 14,
//                         ),
//                       ),
//                       const Spacer(),
//                       Text(
//                         '${article.createdAt.day}/${article.createdAt.month}/${article.createdAt.year}',
//                         style: TextStyle(
//                           color: Colors.grey[600],
//                           fontSize: 14,
//                         ),
//                       ),
//                     ],
//                   ),

//                   const SizedBox(height: 20),

//                   // Content
//                   Text(
//                     article.content,
//                     style: const TextStyle(
//                       fontSize: 16,
//                       height: 1.6,
//                       color: Colors.black87,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import '../models/article.dart';

class ArticleDetailScreen extends StatelessWidget {
  final Article article;

  const ArticleDetailScreen({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Article Detail'),
        backgroundColor: const Color(0xFF1565C0),
        foregroundColor: Colors.white,
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
              child: article.imageUrl.isNotEmpty
                  ? Image.asset(
                      article.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.image, size: 50, color: Colors.grey),
                    )
                  : const Icon(Icons.image, size: 50, color: Colors.grey),
            ),

            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Category Badge
                  //nikib gnay ayra
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1565C0).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                      article.category,
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
                    article.title,
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
                        'By ${article.author}',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        '${article.createdAt.day}/${article.createdAt.month}/${article.createdAt.year}',
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
                    article.content,
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
  }
}
