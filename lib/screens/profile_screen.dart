import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Menerima data (username dan email) dari halaman sebelumnya (misalnya Dashboard)
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    // Jika data tidak ada, gunakan nilai default
    final username = args?['username'] ?? 'User';
    final email = args?['email'] ?? 'user@email.com';

    return Scaffold(
      backgroundColor: Colors.pink[50],
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        elevation: 0,
        toolbarHeight: 0, // Sembunyikan AppBar agar tampilan lebih bersih
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
        child: Column(
          children: [
            // --- Bagian Foto Profil ---
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                // Foto profil berbentuk lingkaran dengan efek bayangan
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.pinkAccent.withOpacity(0.4),
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: const CircleAvatar(
                    radius: 65,
                    backgroundImage: AssetImage(
                      'assets/profile.jpg', // Ganti dengan path gambar profil kamu
                    ),
                  ),
                ),
                // Tombol kamera kecil di pojok bawah kanan (hanya dekorasi)
                Container(
                  decoration: BoxDecoration(
                    color: Colors.pinkAccent,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  padding: const EdgeInsets.all(6),
                  child: const Icon(
                    Icons.camera_alt,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // --- Nama & Email Pengguna ---
            Text(
              username,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.pinkAccent,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              email,
              style: const TextStyle(
                color: Colors.black54,
                fontSize: 15,
              ),
            ),

            const SizedBox(height: 35),

            // --- Menu Pilihan Pengguna (Settings) ---
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: Colors.pinkAccent.withOpacity(0.15),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Menu Edit Profile
                  _buildSettingItem(
                    icon: Icons.edit,
                    text: 'Edit Profile',
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Edit profile clicked 💖'),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                  ),
                  _divider(),

                  // Menu Friends List
                  _buildSettingItem(
                    icon: Icons.people,
                    text: 'Friends List',
                    onTap: () {
                      Navigator.pushNamed(context, '/friends');
                    },
                  ),
                  _divider(),

                  // Menu Settings
                  _buildSettingItem(
                    icon: Icons.settings,
                    text: 'Settings',
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Settings clicked ⚙️'),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                  ),
                  _divider(),

                  // Menu Logout
                  _buildSettingItem(
                    icon: Icons.logout,
                    text: 'Logout',
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Logged out successfully'),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                      // Kembali ke halaman pertama (misalnya login)
                      Navigator.popUntil(context, (route) => route.isFirst);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- Garis Pembatas antar item ---
  Widget _divider() {
    return Divider(
      height: 1,
      color: Colors.pinkAccent.withOpacity(0.15),
      indent: 16,
      endIndent: 16,
    );
  }

  // --- Widget untuk membentuk item menu setting ---
  Widget _buildSettingItem({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.pinkAccent),
      title: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 15,
        ),
      ),
      trailing: const Icon(
        Icons.chevron_right,
        color: Colors.pinkAccent,
      ),
      onTap: onTap,
    );
  }
}
