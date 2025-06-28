// lib/views/profile_screen.dart
import 'package:flutter/material.dart';
import 'package:bubuy_lovers/views/edit_profile_screen.dart'; // Perbaiki import
import 'package:bubuy_lovers/views/login_screen.dart'; // Untuk navigasi logout
import 'package:bubuy_lovers/services/auth_service.dart'; // Import AuthService
import 'package:provider/provider.dart'; // Import Provider

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Consumer untuk mendapatkan data pengguna dan memicu rebuild saat logout
    return Consumer<AuthService>(
      builder: (context, authService, child) {
        final user = authService.currentUser;
        final username = user?.username ?? 'Guest';
        final email = user?.email ?? 'N/A';

        return Scaffold(
          backgroundColor: Colors.grey[50],
          // AppBar sudah ditangani di MainNavigation
          body: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),

                // Profile Picture
                Center(
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundColor: Colors.purple[200],
                        child: const Icon(
                          Icons.person,
                          size: 60,
                          color: Colors.white,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: Color(0xFF1565C0),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                // Profile Information
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
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
                  child: Column(
                    children: [
                      _buildProfileItem(
                        icon: Icons.person,
                        title: 'Name',
                        value: username, // Tampilkan username dari AuthService
                      ),
                      const Divider(height: 1),
                      _buildProfileItem(
                        icon: Icons.email, // Ubah icon jika perlu
                        title: 'E-Mail',
                        value: email, // Tampilkan email dari AuthService
                      ),
                      const Divider(height: 1),
                      // Contoh item lain, jika ada di User model:
                      _buildProfileItem(
                        icon: Icons.phone,
                        title: 'Phone no.',
                        value: 'N/A', // Ganti dengan data asli jika ada
                      ),
                      const Divider(height: 1),
                      _buildProfileItem(
                        icon: Icons.business,
                        title: 'Department',
                        value: 'Mahasiswa', // Ganti dengan data asli jika ada
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                // Action Buttons
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      _buildActionButton(
                        icon: Icons.settings,
                        title: 'Settings',
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Settings coming soon')),
                          );
                        },
                      ),
                      const SizedBox(height: 12),
                      _buildActionButton(
                        icon: Icons.help_outline,
                        title: 'Help & Support',
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Help & Support coming soon')),
                          );
                        },
                      ),
                      const SizedBox(height: 12),
                      _buildActionButton(
                        icon: Icons.logout,
                        title: 'Logout',
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Logout'),
                                content: const Text(
                                    'Are you sure you want to logout?'),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      Navigator.of(context)
                                          .pop(); // Tutup dialog
                                      await authService
                                          .logout(); // Panggil logout dari AuthService
                                      // Setelah logout, navigasi ke LoginScreen dan hapus semua route sebelumnya
                                      Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const LoginScreen()),
                                        (route) => false,
                                      );
                                    },
                                    child: const Text('Logout'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        isDestructive: true,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildProfileItem({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Icon(icon, color: Colors.grey[600], size: 20),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool isDestructive = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
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
            Icon(
              icon,
              color: isDestructive ? Colors.red : Colors.grey[600],
              size: 20,
            ),
            const SizedBox(width: 16),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                color: isDestructive ? Colors.red : Colors.black87,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey[400],
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}
