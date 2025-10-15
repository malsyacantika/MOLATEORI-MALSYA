import 'package:flutter/material.dart';
import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  static const routeName = '/signup';
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  // Key untuk validasi form input
  final _formKey = GlobalKey<FormState>();

  // Controller untuk setiap input field
  final _emailC = TextEditingController();
  final _passC = TextEditingController();
  final _nameC = TextEditingController();
  final _usernameC = TextEditingController();

  // Menandakan proses loading saat tombol ditekan
  bool _isLoading = false;

  /// Fungsi untuk memproses form Sign Up
  Future<void> _submit() async {
    // Validasi form, jika gagal maka hentikan eksekusi
    if (!(_formKey.currentState?.validate() ?? false)) return;

    // Tampilkan indikator loading
    setState(() => _isLoading = true);

    // Simulasi proses registrasi (delay 0.9 detik)
    await Future.delayed(const Duration(milliseconds: 900));

    if (mounted) {
      // Setelah sukses, kirim data ke halaman login
      Navigator.pushReplacementNamed(
        context,
        LoginScreen.routeName,
        arguments: {
          'username': _usernameC.text.trim(),
          'email': _emailC.text.trim(),
        },
      );
    }

    // Matikan indikator loading
    setState(() => _isLoading = false);
  }

  @override
  void dispose() {
    // Hapus semua controller untuk mencegah memory leak
    _emailC.dispose();
    _passC.dispose();
    _nameC.dispose();
    _usernameC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      appBar: AppBar(
        title: const Text('Sign Up'),
        backgroundColor: Colors.pinkAccent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Card(
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  // Input nama lengkap
                  _buildTextField(
                    controller: _nameC,
                    label: 'Full name',
                    validatorMsg: 'Isi nama lengkap',
                  ),
                  const SizedBox(height: 12),

                  // Input username
                  _buildTextField(
                    controller: _usernameC,
                    label: 'Username',
                    validatorMsg: 'Isi username',
                    extraValidation: (v) {
                      if (v.trim().length < 3) return 'Minimal 3 karakter';
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),

                  // Input email
                  _buildTextField(
                    controller: _emailC,
                    label: 'Email',
                    validatorMsg: 'Isi email',
                    extraValidation: (v) {
                      if (!v.contains('@')) return 'Email tidak valid';
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),

                  // Input password
                  _buildTextField(
                    controller: _passC,
                    label: 'Password',
                    validatorMsg: 'Isi password',
                    obscure: true,
                    extraValidation: (v) {
                      if (v.trim().length < 6) return 'Minimal 6 karakter';
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),

                  // Tombol "Create account"
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
                              child: Text("Create account"),
                            ),
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Navigasi ke halaman login jika sudah punya akun
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                        context,
                        LoginScreen.routeName,
                      );
                    },
                    child: const Text('Sudah punya akun? Login'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // 🔹 Widget helper untuk membuat TextFormField dengan validasi
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String validatorMsg,
    bool obscure = false,
    String? Function(String value)? extraValidation,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      decoration: InputDecoration(labelText: label),
      validator: (v) {
        // Validasi utama: field wajib diisi
        if (v == null || v.trim().isEmpty) return validatorMsg;

        // Validasi tambahan (jika ada)
        if (extraValidation != null) {
          return extraValidation(v);
        }
        return null;
      },
    );
  }
}