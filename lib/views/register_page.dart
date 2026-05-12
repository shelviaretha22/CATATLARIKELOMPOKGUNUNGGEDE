import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_textfield.dart';
import 'login_page.dart'; // Pastikan import ini ada

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE0F7F4),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Color(0xFF00ACC1)),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                "Buat Akun\nBaru 🏃",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E4D4A),
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "Daftar dan mulai catat perjalanan larimu",
                style: TextStyle(color: Color(0xFF5A8B88), fontSize: 16),
              ),
              const SizedBox(height: 30),
              _buildLabel("Username"),
              CustomTextField(hint: "Masukkan username", icon: Icons.person_outline, controller: usernameController),
              const SizedBox(height: 15),
              _buildLabel("Email"),
              CustomTextField(hint: "contoh@email.com", icon: Icons.email_outlined, controller: emailController),
              const SizedBox(height: 15),
              _buildLabel("Password"),
              CustomTextField(hint: "Minimal 6 karakter", icon: Icons.lock_outline, obscure: true, controller: passwordController),
              const SizedBox(height: 15),
              _buildLabel("Konfirmasi Password"),
              CustomTextField(hint: "Ulangi password", icon: Icons.lock_reset, obscure: true, controller: confirmPasswordController),
              const SizedBox(height: 40),
              CustomButton(
                text: "Daftar",
                onPressed: () {
                  if (usernameController.text.isEmpty || emailController.text.isEmpty || passwordController.text.isEmpty || confirmPasswordController.text.isEmpty) {
                    _showSnack("Semua data harus diisi");
                    return;
                  }
                  if (passwordController.text != confirmPasswordController.text) {
                    _showSnack("Password tidak sama");
                    return;
                  }
                  _showSnack("Registrasi berhasil");
                  Navigator.pop(context);
                },
              ),
              const SizedBox(height: 20),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Sudah punya akun? ", style: TextStyle(color: Color(0xFF5A8B88))),
                    GestureDetector(
                      onTap: () => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const LoginPage()),
                      ),
                      child: const Text("Masuk", style: TextStyle(color: Color(0xFF00ACC1), fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1E4D4A))),
    );
  }

  void _showSnack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }
}