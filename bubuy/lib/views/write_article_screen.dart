// views/write_article_screen.dart
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // Import image_picker
import 'package:provider/provider.dart'; // Import provider
import 'dart:io'; // Untuk File

import '../models/article.dart';
import '../services/article_service.dart'; // Import ArticleService
import '../services/auth_service.dart'; // Import AuthService untuk nama penulis

class WriteArticleScreen extends StatefulWidget {
  const WriteArticleScreen({super.key});

  @override
  State<WriteArticleScreen> createState() => _WriteArticleScreenState();
}

class _WriteArticleScreenState extends State<WriteArticleScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  String _selectedCategory = 'Bird';
  File? _imageFile; // Menyimpan file gambar yang dipilih
  bool _isLoading = false; // State untuk indikator loading

  final List<String> categories = ['Bird', 'Cat', 'Fish', 'Dog', 'Rabbit'];

  // Fungsi untuk memilih gambar
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
        source: ImageSource.gallery); // Pilih dari galeri

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  // Fungsi untuk reset form
  void _resetForm() {
    _titleController.clear();
    _contentController.clear();
    setState(() {
      _selectedCategory = 'Bird';
      _imageFile = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Consumer untuk AuthService agar bisa mendapatkan nama penulis
    return Consumer<AuthService>(
      builder: (context, authService, child) {
        final currentUsername = authService.currentUser?.username ?? 'Guest';

        return Scaffold(
          backgroundColor: Colors.grey[50],
          appBar: AppBar(
            title: Row(
              children: [
                Text('Hi, $currentUsername 👋'), // Tampilkan username dinamis
              ],
            ),
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            elevation: 0,
            actions: [
              CircleAvatar(
                radius: 18,
                backgroundColor: Colors.purple[200],
                child: const Icon(Icons.person, color: Colors.white, size: 20),
              ),
              const SizedBox(width: 16),
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Explore The Animals',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      'Add Artikel',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      'JUDUL ARTIKEL',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _titleController,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.edit, color: Colors.grey),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Colors.grey)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Colors.grey)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide:
                                const BorderSide(color: Color(0xFF1565C0))),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Judul artikel tidak boleh kosong';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'KATEGORI',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<String>(
                      value: _selectedCategory,
                      decoration: InputDecoration(
                        prefixIcon:
                            const Icon(Icons.category, color: Colors.grey),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Colors.grey)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Colors.grey)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide:
                                const BorderSide(color: Color(0xFF1565C0))),
                      ),
                      items: categories.map((String category) {
                        return DropdownMenuItem<String>(
                          value: category,
                          child: Text(category),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedCategory = newValue!;
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'GAMBAR',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 8),
                    GestureDetector(
                      // Menggunakan GestureDetector agar seluruh area bisa diklik
                      onTap: _pickImage,
                      child: Container(
                        width: double.infinity,
                        height:
                            150, // Tinggi yang lebih besar untuk preview gambar
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.grey[200],
                        ),
                        child: _imageFile != null
                            ? Image.file(
                                _imageFile!,
                                fit: BoxFit.cover,
                              )
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.image,
                                      color: Colors.grey, size: 40),
                                  const SizedBox(height: 8),
                                  const Text(
                                    'Pilih gambar...',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ],
                              ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'ISI ARTIKEL',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _contentController,
                      maxLines: 8,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Colors.grey)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Colors.grey)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide:
                                const BorderSide(color: Color(0xFF1565C0))),
                        hintText: 'Tulis isi artikel di sini...',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Isi artikel tidak boleh kosong';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 30),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: _isLoading
                                ? null
                                : () async {
                                    // Menonaktifkan tombol saat loading
                                    if (_formKey.currentState!.validate()) {
                                      if (_imageFile == null) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                              content: Text(
                                                  'Harap pilih gambar untuk artikel')),
                                        );
                                        return;
                                      }

                                      setState(() {
                                        _isLoading = true; // Set loading true
                                      });

                                      // Simulasi ID unik untuk artikel baru
                                      final newArticleId = DateTime.now()
                                          .millisecondsSinceEpoch
                                          .toString();

                                      // Simulasi URL gambar (dalam aplikasi nyata, ini akan diupload ke server)
                                      final imageUrl =
                                          'https://via.placeholder.com/150x150?text=Article+${newArticleId}';

                                      final newArticle = Article(
                                        id: newArticleId,
                                        title: _titleController.text,
                                        category: _selectedCategory,
                                        imageUrl:
                                            imageUrl, // Menggunakan URL gambar simulasi
                                        content: _contentController.text,
                                        author:
                                            currentUsername, // Menggunakan username yang login sebagai penulis
                                        createdAt: DateTime.now(),
                                      );

                                      // Panggil ArticleService untuk menambahkan artikel
                                      await Provider.of<ArticleService>(context,
                                              listen: false)
                                          .addArticle(newArticle);

                                      setState(() {
                                        _isLoading = false; // Set loading false
                                      });

                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Text('Berhasil'),
                                            content: const Text(
                                                'Artikel berhasil disimpan!'),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                  _resetForm(); // Reset form setelah submit sukses
                                                },
                                                child: const Text('OK'),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    }
                                  },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(
                                  0xFF1565C0), // Ubah warna agar seragam
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                            ),
                            child: _isLoading
                                ? const CircularProgressIndicator(
                                    color: Colors
                                        .white) // Indikator loading di tombol
                                : const Text('SIMPAN'),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: OutlinedButton(
                            onPressed: _isLoading
                                ? null
                                : _resetForm, // Menonaktifkan tombol saat loading
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.grey[600],
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                            ),
                            child: const Text('BATAL'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }
}
