import 'package:flutter/material.dart';
import '../viewmodels/user_viewmodel.dart';
import 'landing_page.dart';
import 'settings_page.dart';
import 'edit_profile_page.dart';

class ProfilePage extends StatefulWidget {

  final UserViewModel userViewModel;

  const ProfilePage({
    super.key,
    required this.userViewModel,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  @override
  Widget build(BuildContext context) {

    final user = widget.userViewModel.user;

    return Scaffold(
      backgroundColor: const Color(0xFFF1F7F6),

      body: SingleChildScrollView(
        child: Column(
          children: [

            Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,

              children: [

                Container(
                  height: 180,
                  width: double.infinity,

                  decoration: const BoxDecoration(
                    color: Color(0xFF14B8A6),

                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),

                  child: Column(
                    children: [

                      const SizedBox(height: 60),

                      Text(
                        user.username,

                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),

                      Text(
                        user.email,

                        style: TextStyle(
                          color:
                              Colors.white.withValues(
                            alpha: 0.9,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Positioned(
                  bottom: -45,

                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,

                      border: Border.all(
                        color: Colors.white,
                        width: 4,
                      ),

                      boxShadow: [

                        BoxShadow(
                          color:
                              Colors.black.withValues(
                            alpha: 0.1,
                          ),

                          blurRadius: 10,

                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),

                    child: const CircleAvatar(
                      radius: 45,

                      backgroundColor:
                          Color(0xFFE0F2F1),

                      child: Icon(
                        Icons.person,
                        size: 50,
                        color: Color(0xFF14B8A6),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 60),

            Padding(
              padding:
                  const EdgeInsets.symmetric(
                horizontal: 20,
              ),

              child: Column(
                children: [

                  _buildMenuItem(
                    Icons.edit_outlined,

                    "Edit Profil",

                    "Ubah nama dan email",

                    () async {

                      final updatedUser =
                          await Navigator.push(
                        context,

                        MaterialPageRoute(
                          builder: (_) =>
                              EditProfilePage(
                            user: user,
                          ),
                        ),
                      );

                      if (updatedUser != null) {

                        setState(() {
                          widget.userViewModel
                              .updateUser(
                            updatedUser,
                          );
                        });
                      }
                    },
                  ),

                  _buildMenuItem(
                    Icons.settings_outlined,

                    "Pengaturan",

                    "Notifikasi, tema, dan preferensi",

                    () {

                      Navigator.push(
                        context,

                        MaterialPageRoute(
                          builder: (_) =>
                              const SettingsPage(),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 10),

                  _buildMenuItem(
                    Icons.logout_rounded,

                    "Keluar",

                    "Logout dari akun",

                    () {

                      Navigator.pushAndRemoveUntil(
                        context,

                        MaterialPageRoute(
                          builder: (_) =>
                              const LandingPage(),
                        ),

                        (route) => false,
                      );
                    },

                    isLogout: true,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(
    IconData icon,
    String title,
    String subtitle,
    VoidCallback onTap, {
    bool isLogout = false,
  }) {

    return Container(
      margin: const EdgeInsets.only(bottom: 12),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius:
            BorderRadius.circular(15),
      ),

      child: ListTile(
        onTap: onTap,

        leading: Container(
          padding: const EdgeInsets.all(10),

          decoration: BoxDecoration(
            color: isLogout
                ? const Color(0xFFFFEBEE)
                : const Color(0xFFE0F2F1),

            borderRadius:
                BorderRadius.circular(10),
          ),

          child: Icon(
            icon,

            color: isLogout
                ? Colors.red
                : const Color(0xFF14B8A6),

            size: 22,
          ),
        ),

        title: Text(
          title,

          style: TextStyle(
            fontWeight: FontWeight.bold,

            color: isLogout
                ? Colors.red
                : Colors.black87,
          ),
        ),

        subtitle: Text(
          subtitle,

          style: const TextStyle(
            fontSize: 12,
          ),
        ),

        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 14,
          color: Colors.grey,
        ),
      ),
    );
  }
}