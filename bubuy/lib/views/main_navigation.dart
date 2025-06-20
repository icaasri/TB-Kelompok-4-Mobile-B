import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'favorites_screen.dart';
import 'profile_screen.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    FavoritesScreen(),
    ProfileScreen(),
    // Add WriteArticleScreen here if it's part of the main navigation
    // Or it can be accessed via a FloatingActionButton
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFF1565C0), // Your primary blue color
        onTap: _onItemTapped,
      ),
      floatingActionButton: _selectedIndex == 0 // Only show FAB on Home screen
          ? FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(
                    context, '/writeArticle'); // Use named route
              },
              backgroundColor: const Color(0xFF1565C0),
              child: const Icon(Icons.add, color: Colors.white),
            )
          : null,
    );
  }
}
