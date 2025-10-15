import 'package:flutter/material.dart';

final List<Map<String, String>> posts = [
  {
    'name': 'Lian',
    'image': 'https://picsum.photos/400/300',
    'caption': 'Hari ini seru banget',
  },
  {
    'name': 'Aatipah',
    'image': 'https://picsum.photos/id/1003/400/300',
    'caption': 'vibes all day',
  },
  {
    'name': 'Malsya',
    'image': 'https://picsum.photos/id/237/400/300',
    'caption': 'Mood booster',
  },
];

// Halaman Home (feed utama)
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.pink[50],
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 12),
        itemCount: posts.length, // jumlah postingan
        itemBuilder: (ctx, i) {
          final p = posts[i];
          final TextEditingController commentC = TextEditingController();

          return Card(
            color: Colors.white,
            margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Bagian foto postingan
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                  child: Image.network(
                    p['image']!,
                    height: 220,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),

                // Header postingan (avatar, nama, waktu, dan tombol love)
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      // Foto profil kecil
                      CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage(p['image']!),
                      ),
                      const SizedBox(width: 10),

                      // Nama dan status (teman)
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              p['name']!,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Now • Friends',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Tombol love (like)
                      IconButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content:
                                  Text('Liked ${p['name']}\'s post 💖'),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.favorite_border,
                          color: Colors.pinkAccent,
                        ),
                      ),
                    ],
                  ),
                ),

                // Caption postingan
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: Text(p['caption']!),
                ),

                // Kolom komentar di bawah postingan
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Row(
                    children: [
                      // Input komentar
                      Expanded(
                        child: TextField(
                          controller: commentC,
                          decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 12),
                            hintText: 'Tulis komentar...',
                            filled: true,
                            fillColor: Colors.pink[50],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),

                      // Tombol kirim komentar
                      IconButton(
                        onPressed: () {
                          if (commentC.text.trim().isEmpty) return;

                          // Tampilkan snackbar saat komentar dikirim
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Komentar: "${commentC.text}" terkirim 🩷',
                              ),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                          commentC.clear(); // kosongkan input setelah kirim
                        },
                        icon: const Icon(
                          Icons.send,
                          color: Colors.pinkAccent,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 10),
              ],
            ),
          );
        },
      ),
    );
  }
}