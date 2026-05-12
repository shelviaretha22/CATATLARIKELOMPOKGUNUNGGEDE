import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_textfield.dart';
import 'home_page.dart';
import 'register_page.dart'; // Pastikan import ini ada

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

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
                "Selamat Datang\nKembali! 👋",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E4D4A),
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "Masuk untuk melanjutkan perjalanan larimu",
                style: TextStyle(color: Color(0xFF5A8B88), fontSize: 16),
              ),
              const SizedBox(height: 40),
              const Text("Username", style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1E4D4A))),
              const SizedBox(height: 8),
              CustomTextField(
                hint: "Masukkan username",
                icon: Icons.person,
                controller: emailController,
              ),
              const SizedBox(height: 20),
              const Text("Password", style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1E4D4A))),
              const SizedBox(height: 8),
              CustomTextField(
                hint: "Masukkan password",
                icon: Icons.lock_outline,
                obscure: true,
                controller: passwordController,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: const Text("Lupa Password?", style: TextStyle(color: Color(0xFF00ACC1), fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(height: 20),
              CustomButton(
                text: "Masuk",
                onPressed: () {
                  if (emailController.text.isEmpty || passwordController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Email dan password harus diisi")),
                    );
                    return;
                  }
                  final user = UserModel(
                    username: emailController.text,
                    email: "${emailController.text}@gmail.com",
                  );
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => HomePage(user: user)),
                  );
                },
              ),
              const SizedBox(height: 20),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Belum punya akun? ", style: TextStyle(color: Color(0xFF5A8B88))),
                    GestureDetector(
                      onTap: () => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const RegisterPage()),
                      ),
                      child: const Text("Daftar", style: TextStyle(color: Color(0xFF00ACC1), fontWeight: FontWeight.bold)),
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
}