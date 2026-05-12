import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'views/splash_page.dart';
import 'viewmodels/run_viewmodel.dart';

void main() {
  runApp(

    ChangeNotifierProvider(
      create: (_) => RunViewModel(),

      child: const CatatLariApp(),
    ),
  );
}

class CatatLariApp extends StatelessWidget {
  const CatatLariApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'Catat Lari',

      theme: ThemeData(
        fontFamily: 'Poppins',
        scaffoldBackgroundColor: const Color(0xFFF8FAFC),
      ),

      home: const SplashPage(),
    );
  }
}