// views/main_navigation.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Import provider
import 'package:bubuy_lovers/views/home_screen.dart'; // Perbaiki import
import 'package:bubuy_lovers/views/favorites_screen.dart'; // Perbaiki import
import 'package:bubuy_lovers/views/profile_screen.dart'; // Perbaiki import
import 'package:bubuy_lovers/views/edit_profile_screen.dart'; // Perbaiki import
import 'package:bubuy_lovers/services/auth_service.dart'; // Perbaiki import

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[
    const HomeScreen(), // Ini sekarang adalah halaman utama Anda
    const FavoritesScreen(),
    const ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthService>(
      builder: (context, authService, child) {
        return Scaffold(
          appBar: _selectedIndex == 0
              ? null // Tidak ada AppBar di HomeScreen karena sudah punya header kustom
              : AppBar(
                  title: Text(
                    _selectedIndex == 1 ? 'Favorites' : 'Profile',
                    style: const TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  backgroundColor: Colors.white,
                  elevation: 0,
                  centerTitle: true,
                  actions: [
                    if (_selectedIndex == 2) // Tombol Edit di Profile
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const EditProfileScreen()));
                        },
                        icon: const Icon(Icons.edit, color: Colors.black87),
                      ),
                    // Tombol logout di AppBar Main Navigation, hanya muncul jika di tab Home
                    // (sesuai contoh sebelumnya, meskipun di profile juga ada)
                    // if (_selectedIndex == 0) // ini bisa dihapus jika logout sudah ada di ProfileScreen
                    //   IconButton(
                    //     onPressed: () async {
                    //       await authService.logout();
                    //       Navigator.pushNamedAndRemoveUntil(
                    //           context, '/login', (route) => false);
                    //     },
                    //     icon:
                    //         const Icon(Icons.logout, color: Color(0xFF1565C0)),
                    //     tooltip: 'Logout',
                    //   ),
                  ],
                ),
          body: Center(
            child: _widgetOptions.elementAt(_selectedIndex),
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
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
            selectedItemColor: const Color(0xFF1565C0),
            unselectedItemColor: Colors.grey[600],
            onTap: _onItemTapped,
          ),
          floatingActionButton:
              _selectedIndex == 0 // Hanya tampilkan FAB di Home screen
                  ? FloatingActionButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/writeArticle');
                      },
                      backgroundColor: const Color(0xFF1565C0),
                      child: const Icon(Icons.add, color: Colors.white),
                    )
                  : null,
        );
      },
    );
  }
}
