// lib/main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'views/splash_screen.dart';
import 'package:bubuy_lovers/views/article_detail_screen.dart'; // Tambahkan ini
import 'package:bubuy_lovers/models/article.dart'; // Tambahkan ini
import 'views/login_screen.dart';
import 'views/register_screen.dart';
import 'views/main_navigation.dart';
import 'views/write_article_screen.dart';
import 'services/auth_service.dart';
import 'services/article_service.dart'; // Import ArticleService

void main() {
  runApp(
    // Menggunakan MultiProvider untuk menyediakan beberapa ChangeNotifier
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthService()),
        ChangeNotifierProvider(
            create: (context) => ArticleService()), // Sediakan ArticleService
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    // Muat data pengguna saat aplikasi dimulai
    // Panggil loadCurrentUser di sini, agar sesi login sebelumnya bisa dimuat
    Provider.of<AuthService>(context, listen: false).loadCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    // Consumer untuk memastikan SplashScreen tetap di awal jika belum login
    return Consumer<AuthService>(
      builder: (context, authService, child) {
        return MaterialApp(
          title: 'Bubuy Lovers',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
            fontFamily: 'Roboto',
          ),
          // Penggunaan Navigator 2.0 atau GoRouter akan lebih ideal untuk routing kompleks
          // Tapi untuk demo ini, kita tetap pakai named routes dasar
          initialRoute: authService.currentUser != null
              ? '/main'
              : '/', // Cek status login
          routes: {
            '/': (context) => const SplashScreen(),
            '/login': (context) => const LoginScreen(),
            '/register': (context) => const RegisterScreen(),
            '/main': (context) => authService.currentUser != null
                ? const MainNavigation()
                : const LoginScreen(), // Lindungi rute utama
            '/writeArticle': (context) => const WriteArticleScreen(),
          },
          // OnGenerateRoute bisa digunakan untuk meneruskan argumen ke ArticleDetailScreen
          onGenerateRoute: (settings) {
            if (settings.name == '/articleDetail') {
              final args = settings.arguments as Article;
              return MaterialPageRoute(
                builder: (context) => ArticleDetailScreen(article: args),
              );
            }
            // Tangani rute lain atau kembalikan null untuk default
            return null;
          },
        );
      },
    );
  }
}
