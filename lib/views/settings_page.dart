import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool notification = true;
  bool darkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F7F6),
      appBar: AppBar(
        title: const Text(
          "Pengaturan",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Switch Notifikasi
            _buildSettingCard(
              child: SwitchListTile(
                activeTrackColor: const Color(0xFF14B8A6), // Mengatasi deprecated activeColor
                title: const Text(
                  "Notifikasi", 
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: const Text("Aktifkan pengingat lari"),
                value: notification,
                onChanged: (value) {
                  setState(() {
                    notification = value;
                  });
                },
              ),
            ),

            const SizedBox(height: 15),

            // Switch Dark Mode
            _buildSettingCard(
              child: SwitchListTile(
                activeTrackColor: const Color(0xFF14B8A6),
                title: const Text(
                  "Dark Mode",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: const Text("Mode gelap aplikasi"),
                value: darkMode,
                onChanged: (value) {
                  setState(() {
                    darkMode = value;
                  });
                },
              ),
            ),

            const SizedBox(height: 15),

            // Info Versi
            _buildSettingCard(
              child: ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE0F2F1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.info_outline, color: Color(0xFF14B8A6)),
                ),
                title: const Text(
                  "Versi Aplikasi",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: const Text("Catat Lari v1.0"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingCard({required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: child,
    );
  }
}