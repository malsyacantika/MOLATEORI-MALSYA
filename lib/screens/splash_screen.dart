import 'package:flutter/material.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = '/splash';
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Setelah 1,5 detik, navigasi otomatis ke halaman Login.
    Future.delayed(const Duration(milliseconds: 1500), () {
      // ignore: use_build_context_synchronously
      Navigator.pushReplacementNamed(context, LoginScreen.routeName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Gunakan gradien warna pink untuk latar belakang splash
      body: Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.pinkAccent, Colors.pink],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),

        // Tampilan utama di tengah layar
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Logo aplikasi (pastikan file ada di folder assets)
            Image.asset(
              'assets/logo.png',
              width: 100,
              height: 100,
            ),
            const SizedBox(height: 16),

            // Nama aplikasi
            const Text(
              'Lumi',
              style: TextStyle(
                fontSize: 28,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),

            const SizedBox(height: 8),

            // Tagline atau keterangan tambahan
            const Text(
              'Small social feed — made by Malsya',
              style: TextStyle(color: Colors.white70),
            ),
          ],
        ),
      ),
    );
  }
}
