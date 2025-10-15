import 'package:flutter/material.dart';

class FriendsScreen extends StatefulWidget {
  const FriendsScreen({super.key});

  @override
  State<FriendsScreen> createState() => _FriendsScreenState();
}

class _FriendsScreenState extends State<FriendsScreen> {
  // Daftar teman awal (dummy data)
  final List<String> friends = ['Lian', 'Aathifah', 'Zidan', 'Randi', 'Hafidz'];

  // Controller untuk input nama teman baru
  final TextEditingController _friendController = TextEditingController();

  // Fungsi untuk menampilkan pop-up tambah teman
  void _addFriend() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text(
            'Tambah Teman',
            style: TextStyle(
              color: Colors.pinkAccent,
              fontWeight: FontWeight.bold,
            ),
          ),

          // Input nama teman baru
          content: TextField(
            controller: _friendController,
            decoration: const InputDecoration(
              hintText: 'Masukkan nama teman...',
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.pinkAccent),
              ),
            ),
          ),

          // Tombol aksi (batal / tambah)
          actions: [
            // Tombol batal
            TextButton(
              onPressed: () {
                _friendController.clear();
                Navigator.pop(context);
              },
              child: const Text(
                'Batal',
                style: TextStyle(color: Colors.grey),
              ),
            ),

            // Tombol tambah teman baru
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pinkAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                final newName = _friendController.text.trim();

                // Validasi input agar tidak kosong
                if (newName.isNotEmpty) {
                  setState(() {
                    friends.add(newName); // tambahkan ke daftar
                  });
                  _friendController.clear();
                  Navigator.pop(context);

                  // Pesan notifikasi sukses
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('$newName berhasil ditambahkan'),
                      backgroundColor: Colors.pinkAccent,
                      duration: const Duration(seconds: 2),
                    ),
                  );
                }
              },
              child: const Text('Tambah'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],

      // Bagian atas halaman (judul)
      appBar: AppBar(
        automaticallyImplyLeading: false, // sembunyikan tombol back
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: const Text(
          "My Friends",
          style: TextStyle(
            color: Colors.pinkAccent,
            fontWeight: FontWeight.bold,
            fontSize: 24,
            letterSpacing: 0.5,
          ),
        ),
      ),

      // Bagian utama (daftar teman)
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),

        // Jika daftar teman kosong, tampilkan teks
        child: friends.isEmpty
            ? const Center(
                child: Text(
                  "Belum ada teman 😢\nTambah dulu yuk!",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                ),
              )

            // Jika ada teman, tampilkan list
            : ListView.builder(
                itemCount: friends.length,
                itemBuilder: (context, index) {
                  final name = friends[index];
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.pinkAccent.withValues(alpha: 0.1),
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),

                    // Tiap teman ditampilkan dalam ListTile
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),

                      // Avatar huruf pertama nama
                      leading: CircleAvatar(
                        radius: 26,
                        backgroundColor:
                            Colors.pinkAccent.withValues(alpha: 0.15),
                        child: Text(
                          name[0].toUpperCase(),
                          style: const TextStyle(
                            color: Colors.pinkAccent,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      // Nama dan subtitle
                      title: Text(
                        name,
                        style: const TextStyle(
                          color: Colors.pinkAccent,
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                      subtitle: const Text(
                        "Bestie vibes",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 13,
                        ),
                      ),

                      // Ikon love di kanan
                      trailing: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.pinkAccent.withValues(alpha: 0.15),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.favorite,
                          color: Colors.pinkAccent,
                          size: 22,
                        ),
                      ),

                      // Aksi ketika salah satu teman diklik
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Kamu klik $name'),
                            duration: const Duration(seconds: 1),
                            backgroundColor: Colors.pinkAccent,
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
      ),

      // Tombol tambah teman (FAB)
      floatingActionButton: FloatingActionButton(
        onPressed: _addFriend,
        backgroundColor: Colors.pinkAccent,
        child: const Icon(Icons.person_add_alt_1_rounded, size: 28),
      ),
    );
  }
}
