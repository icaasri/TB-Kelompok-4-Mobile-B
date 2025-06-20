// views/main_navigation.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Import provider
import 'home_screen.dart';
import 'favorites_screen.dart';
import 'profile_screen.dart';
import 'package:bubuy_lovers/views/edit_profile_screen.dart'; // Tambahkan ini
import '../services/auth_service.dart'; // Import AuthService

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[
    const HomeScreen(),
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
    // Consumer<AuthService> di sini akan menyebabkan MainNavigation rebuilt saat authService berubah,
    // yang penting saat logout.
    return Consumer<AuthService>(
      builder: (context, authService, child) {
        return Scaffold(
          appBar: _selectedIndex == 0
              ? null
              : AppBar(
                  // AppBar dinamis
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
                    if (_selectedIndex ==
                        0) // Tombol Logout di AppBar Home (opsional, sudah ada di profile)
                      IconButton(
                        onPressed: () async {
                          await authService
                              .logout(); // Panggil logout dari AuthService
                          Navigator.pushNamedAndRemoveUntil(
                              context, '/login', (route) => false);
                        },
                        icon:
                            const Icon(Icons.logout, color: Color(0xFF1565C0)),
                        tooltip: 'Logout',
                      ),
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
            unselectedItemColor:
                Colors.grey[600], // Menambah warna untuk yang tidak dipilih
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
