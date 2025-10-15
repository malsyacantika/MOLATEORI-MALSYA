import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'friends_screen.dart';
import 'profile_screen.dart';

class DashboardScreen extends StatefulWidget {
  static const routeName = '/dashboard'; // Nama route untuk navigasi
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0; // Indeks tab yang sedang aktif

  // Daftar halaman yang akan ditampilkan di body sesuai tab
  final List<Widget> _pages = const [
    HomeScreen(),
    FriendsScreen(),
    ProfileScreen(),
  ];

  // Fungsi untuk mengambil username dari argument navigasi
  String _getUsernameFromArgs(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is Map && args.containsKey('username')) {
      final uname = args['username'] as String;
      return uname.isNotEmpty
          ? uname[0].toUpperCase() + uname.substring(1) // kapital huruf pertama
          : 'User';
    }
    return 'User'; // default jika tidak ada username
  }

  @override
  Widget build(BuildContext context) {
    final username = _getUsernameFromArgs(context); // ambil nama user dari route

    return Scaffold(
      backgroundColor: Colors.pink[50],

      // 🌸 HEADER (AppBar custom)
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100), // tinggi header
        child: Container(
          decoration: BoxDecoration(
            // Gradasi warna pink lembut
            gradient: const LinearGradient(
              colors: [Color(0xFFFFB6C1), Color(0xFFFFC0CB)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            // Efek bayangan lembut
            boxShadow: [
              BoxShadow(
                color: Colors.pinkAccent.withValues(alpha: 0.25),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
            // Lengkungan di bawah header
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Row(
                children: [
                  // 🧍 Avatar user (ikon profil bulat)
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.pinkAccent.withValues(alpha: 0.3),
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: const CircleAvatar(
                      radius: 26,
                      backgroundColor: Colors.white,
                      child: Icon(Icons.person,
                          color: Colors.pinkAccent, size: 30),
                    ),
                  ),

                  const SizedBox(width: 16),

                  // 🌷 Sapaan untuk user
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Welcome back,",
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          "Hi, $username ",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // ☁️ Tombol Upload (belum aktif)
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.pinkAccent.withValues(alpha: 0.9),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.pinkAccent.withValues(alpha: 0.25),
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.cloud_upload_rounded,
                          color: Color.fromARGB(255, 245, 197, 213), size: 26),
                      tooltip: 'Upload',
                      onPressed: () {
                        // Pesan saat tombol upload ditekan
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Fitur upload belum diaktifkan'),
                            duration: Duration(seconds: 2),
                            backgroundColor: Colors.pinkAccent,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),

      // 🌼 BODY menampilkan halaman sesuai tab aktif
      body: _pages[_selectedIndex],

      // 🌸 BOTTOM NAVIGATION BAR (navigasi bawah)
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(22),
          topRight: Radius.circular(22),
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.white,
          currentIndex: _selectedIndex, // tab yang sedang aktif
          selectedItemColor: Colors.pinkAccent,
          unselectedItemColor: Colors.grey,
          onTap: (i) => setState(() => _selectedIndex = i), // ganti halaman
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_rounded), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.people_alt_rounded), label: 'Friends'),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_rounded), label: 'Profile'),
          ],
        ),
      ),
    );
  }
}
