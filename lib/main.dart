import 'package:flutter/material.dart';
import 'views/splash_screen.dart';
import 'views/login_screen.dart'; // Import LoginScreen
import 'views/register_screen.dart'; // Import RegisterScreen
import 'views/main_navigation.dart'; // Import MainNavigation
import 'views/write_article_screen.dart'; // Import WriteArticleScreen

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bubuy Lovers',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Roboto'),
      initialRoute: '/', // Set initial route
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/main': (context) =>
            const MainNavigation(), // Main navigation after login
        '/writeArticle': (context) =>
            const WriteArticleScreen(), // Route for writing articles
        // You might want to add routes for ArticleDetailScreen, EditProfileScreen, etc.
        // For simplicity, ArticleDetailScreen and EditProfileScreen can still be pushed
        // using MaterialPageRoute directly if they receive arguments.
      },
    );
  }
}
