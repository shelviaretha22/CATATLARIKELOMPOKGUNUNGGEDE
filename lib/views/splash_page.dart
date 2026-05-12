import 'dart:async';
import 'package:flutter/material.dart';
import 'landing_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    super.initState();

    Timer(
      const Duration(seconds: 3),
      () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const LandingPage(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Mengubah background menjadi mint sesuai Landing Page
      backgroundColor: const Color(0xFFE0F7F4), 

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Ikon lari dengan warna teal tua agar kontras
            const Icon(
              Icons.directions_run,
              size: 90,
              color: Color(0xFF00ACC1),
            ),

            const SizedBox(height: 20),

            // Teks judul dengan warna teal tua sesuai Landing Page
            const Text(
              "Catat Lari",
              style: TextStyle(
                color: Color(0xFF1E4D4A),
                fontSize: 34,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            // Slogan dengan warna yang lebih soft
            const Text(
              "Track Your Running Journey",
              style: TextStyle(
                color: Color(0xFF5A8B88),
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 40),

            // Loading indicator disesuaikan warnanya
            const CircularProgressIndicator(
              color: Color(0xFF00ACC1),
            ),
          ],
        ),
      ),
    );
  }
}