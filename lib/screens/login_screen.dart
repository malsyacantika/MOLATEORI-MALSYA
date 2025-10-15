import 'package:flutter/material.dart';
import 'signup_screen.dart';
import 'dashboard_screen.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Key untuk validasi form
  final _formKey = GlobalKey<FormState>();

  // Controller untuk input username/email dan password
  final TextEditingController _userOrEmailC = TextEditingController();
  final TextEditingController _passC = TextEditingController();

  // Variabel untuk menampilkan indikator loading
  bool _isLoading = false;

  // Fungsi untuk submit form login
  Future<void> _submit() async {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    // Tampilkan loading
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(milliseconds: 800));

    final input = _userOrEmailC.text.trim();

    // Jika input mengandung '@', maka dianggap email
    final username = input.contains('@') ? input.split('@')[0] : input;

    // Navigasi ke Dashboard dan kirim data username
    Navigator.pushReplacementNamed(
      // ignore: use_build_context_synchronously
      context,
      DashboardScreen.routeName,
      arguments: {'username': username},
    );

    // Hentikan loading setelah berpindah
    setState(() => _isLoading = false);
  }

  @override
  void dispose() {
    // Hapus controller ketika widget dihapus dari tree
    _userOrEmailC.dispose();
    _passC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Card(
            elevation: 6,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey, // Form untuk validasi input
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Judul dan subjudul halaman login
                    const Text(
                      'Welcome Back',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Login to continue to Lumi',
                      style: TextStyle(color: Colors.black54),
                    ),
                    const SizedBox(height: 20),

                    // Input Username atau Email
                    TextFormField(
                      controller: _userOrEmailC,
                      decoration: const InputDecoration(
                        labelText: 'Username or Email',
                        prefixIcon: Icon(Icons.person_outline),
                      ),
                      validator: (v) {
                        if (v == null || v.trim().isEmpty) {
                          return 'Username atau Email tidak boleh kosong';
                        }
                        if (!v.contains('@') && v.trim().length < 3) {
                          return 'Username minimal 3 karakter';
                        }
                        if (v.contains('@') && !v.contains('.')) {
                          return 'Format email tidak valid';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),

                    // Input Password
                    TextFormField(
                      controller: _passC,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        prefixIcon: Icon(Icons.lock_outline),
                      ),
                      validator: (v) {
                        if (v == null || v.trim().isEmpty) {
                          return 'Password tidak boleh kosong';
                        }
                        if (v.trim().length < 6) {
                          return 'Password minimal 6 karakter';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),

                    // Tombol Login
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _submit,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.pinkAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: _isLoading
                            ? const SizedBox(
                                height: 18,
                                width: 18,
                                child: CircularProgressIndicator(strokeWidth: 2),
                              )
                            : const Padding(
                                padding: EdgeInsets.symmetric(vertical: 12),
                                child: Text('Login'),
                              ),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Navigasi ke halaman Sign Up
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Belum punya akun?'),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              SignUpScreen.routeName,
                            );
                          },
                          child: const Text('Sign Up'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
