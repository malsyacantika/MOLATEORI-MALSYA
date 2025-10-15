import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/dashboard_screen.dart';

// Fungsi utama yang pertama kali dijalankan saat aplikasi dibuka
void main() {
  runApp(const LocketPlusApp()); // Menjalankan aplikasi utama bernama LocketPlusApp
}

// Widget utama aplikasi
class LocketPlusApp extends StatelessWidget {
  const LocketPlusApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Judul aplikasi (akan muncul di task manager atau device info)
      title: 'Lumi',

      // Menghilangkan banner debug di pojok kanan atas
      debugShowCheckedModeBanner: false,

      // Tema utama aplikasi (menggunakan warna dasar pink)
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pinkAccent),
        useMaterial3: true, // Menggunakan desain Material 3 (modern)
        fontFamily: 'Poppins', // Font utama aplikasi
      ),

      // Halaman pertama yang akan muncul ketika aplikasi dijalankan
      initialRoute: SplashScreen.routeName,

      // Daftar rute halaman yang dapat dinavigasikan di aplikasi
      routes: {
        SplashScreen.routeName: (ctx) => const SplashScreen(), // Halaman splash
        LoginScreen.routeName: (ctx) => const LoginScreen(),   // Halaman login
        SignUpScreen.routeName: (ctx) => const SignUpScreen(), // Halaman daftar akun
        DashboardScreen.routeName: (ctx) => const DashboardScreen(), // Halaman utama setelah login
      },
    );
  }
}
