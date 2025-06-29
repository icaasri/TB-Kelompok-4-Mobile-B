import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Pastikan semua import menggunakan 'package:bubuy_lovers/'
import 'package:bubuy_lovers/views/splash_screen.dart';
import 'package:bubuy_lovers/views/login_screen.dart';
import 'package:bubuy_lovers/views/register_screen.dart';
import 'package:bubuy_lovers/views/main_navigation.dart';
import 'package:bubuy_lovers/views/write_article_screen.dart';
import 'package:bubuy_lovers/views/article_detail_screen.dart';
import 'package:bubuy_lovers/models/article.dart';

import 'package:bubuy_lovers/services/auth_service.dart';
import 'package:bubuy_lovers/services/article_service.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthService()),
        ChangeNotifierProvider(create: (context) => ArticleService()),
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AuthService>(context, listen: false).loadCurrentUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthService>(
      builder: (context, authService, child) {
        // isLoading biasanya datang dari AuthService jika ada proses loading.
        // Jika belum ada logika loading, kita bisa asumsikan selalu siap.
        // Untuk demo ini, kita langsung tentukan initialRoute berdasarkan currentUser.
        final initialRoute = authService.currentUser != null ? '/main' : '/';

        return MaterialApp(
          title: 'Bubuy Lovers',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
            fontFamily: 'Roboto',
            // Define input decoration theme globally if needed
            inputDecorationTheme: InputDecorationTheme(
              filled: true,
              fillColor: Colors.white.withOpacity(0.1),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.white30),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.white),
              ),
              hintStyle: const TextStyle(color: Colors.white70),
            ),
          ),
          initialRoute: initialRoute,
          routes: {
            '/': (context) => const SplashScreen(),
            '/login': (context) => const LoginScreen(),
            '/register': (context) => const RegisterScreen(),
            '/main': (context) => authService.currentUser != null
                ? const MainNavigation()
                : const LoginScreen(), // Lindungi rute utama
            '/writeArticle': (context) => const WriteArticleScreen(),
            // Tidak perlu '/home', '/favorites', '/profile' karena itu diatur di MainNavigation
          },
          onGenerateRoute: (settings) {
            if (settings.name == '/articleDetail') {
              final args = settings.arguments as Article;
              return MaterialPageRoute(
                builder: (context) => ArticleDetailScreen(article: args),
              );
            }
            return null; // Biarkan rute lain ditangani oleh `routes` map
          },
        );
      },
    );
  }
}
