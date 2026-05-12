import 'package:flutter/material.dart';

import '../models/user_model.dart';

import '../viewmodels/run_viewmodel.dart';
import '../viewmodels/user_viewmodel.dart';

import 'dashboard_page.dart';
import 'profile_page.dart';

class HomePage extends StatefulWidget {
  final UserModel user;

  const HomePage({
    super.key,
    required this.user,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  late RunViewModel runViewModel;
  late UserViewModel userViewModel;

  @override
  void initState() {
    super.initState();

    runViewModel = RunViewModel();

    userViewModel = UserViewModel(
      user: widget.user,
    );
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      DashboardPage(
        user: userViewModel.user,
      ),

      ProfilePage(
        userViewModel: userViewModel,
      ),
    ];

    return Scaffold(
      body: SafeArea(
        child: pages[selectedIndex],
      ),

      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 40,
          vertical: 15,
        ),

        decoration: const BoxDecoration(
          color: Color(0xFFF1F7F6),
        ),

        child: Container(
          height: 65,

          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),

            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),

          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              buildNavItem(
                0,
                Icons.grid_view_rounded,
                "Dashboard",
              ),

              buildNavItem(
                1,
                Icons.person_rounded,
                "Profile",
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildNavItem(
    int index,
    IconData icon,
    String label,
  ) {
    bool isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },

      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),

        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),

        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF14B8A6)
              : Colors.transparent,

          borderRadius: BorderRadius.circular(15),
        ),

        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected
                  ? Colors.white
                  : Colors.grey,
            ),

            if (isSelected)
              const SizedBox(width: 8),

            if (isSelected)
              Text(
                label,

                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
          ],
        ),
      ),
    );
  }
}