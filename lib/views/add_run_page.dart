import 'package:flutter/material.dart';
import '../models/run_model.dart';

class AddRunPage extends StatefulWidget {
  final RunModel? run;

  const AddRunPage({
    super.key,
    this.run,
  });

  @override
  State<AddRunPage> createState() => _AddRunPageState();
}

class _AddRunPageState extends State<AddRunPage> {
  final distanceController = TextEditingController();
  DateTime? selectedDate;
  TimeOfDay? startTime;
  TimeOfDay? endTime;
  int duration = 0;

  @override
  void initState() {
    super.initState();
    if (widget.run != null) {
      distanceController.text = widget.run!.distance.toString();
      duration = widget.run!.duration;
      // Catatan: Idealnya parsing date/time juga dilakukan di sini jika ingin edit full data
    }
  }

  void calculateDuration() {
    if (startTime != null && endTime != null) {
      final startMinutes = startTime!.hour * 60 + startTime!.minute;
      final endMinutes = endTime!.hour * 60 + endTime!.minute;
      setState(() {
        duration = endMinutes - startMinutes;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F7F6),
      appBar: AppBar(
        title: Text(
          widget.run == null ? "Tambah Lari" : "Edit Lari",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Pilih Tanggal
            _buildPickerButton(
              onPressed: () async {
                final pickedDate = await showDatePicker(
                  context: context,
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2030),
                  initialDate: DateTime.now(),
                );
                if (pickedDate != null) {
                  setState(() => selectedDate = pickedDate);
                }
              },
              icon: Icons.calendar_today_rounded,
              label: selectedDate == null
                  ? "Pilih Tanggal"
                  : "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}",
            ),

            const SizedBox(height: 15),

            // Row untuk Waktu Mulai & Selesai
            Row(
              children: [
                Expanded(
                  child: _buildPickerButton(
                    onPressed: () async {
                      final pickedStart = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (pickedStart != null) {
                        setState(() => startTime = pickedStart);
                        calculateDuration();
                      }
                    },
                    icon: Icons.access_time_rounded,
                    label: startTime == null ? "Mulai" : startTime!.format(context),
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: _buildPickerButton(
                    onPressed: () async {
                      final pickedEnd = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (pickedEnd != null) {
                        setState(() => endTime = pickedEnd);
                        calculateDuration();
                      }
                    },
                    icon: Icons.timer_off_outlined,
                    label: endTime == null ? "Selesai" : endTime!.format(context),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Display Durasi (Card Style)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Estimasi Durasi", style: TextStyle(color: Colors.grey)),
                  Text(
                    duration <= 0 ? "-" : "$duration Menit",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF14B8A6),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Input Jarak
            _buildDistanceInput(),

            const SizedBox(height: 40),

            // Tombol Simpan
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                  if (selectedDate == null ||
                      startTime == null ||
                      endTime == null ||
                      distanceController.text.isEmpty ||
                      duration <= 0) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Lengkapi semua data terlebih dahulu")),
                    );
                    return;
                  }

                  final run = RunModel(
                    date: "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}",
                    startTime: startTime!.format(context),
                    endTime: endTime!.format(context),
                    duration: duration,
                    distance: double.parse(distanceController.text),
                  );

                  Navigator.pop(context, run);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF14B8A6),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  elevation: 0,
                ),
                child: Text(
                  widget.run == null ? "Simpan Aktivitas" : "Update Aktivitas",
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper UI: Tombol Picker (Tanggal/Waktu)
  Widget _buildPickerButton({required VoidCallback onPressed, required IconData icon, required String label}) {
    return SizedBox(
      height: 60,
      child: OutlinedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, color: const Color(0xFF14B8A6), size: 20),
        label: Text(label, style: const TextStyle(color: Colors.black87)),
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.white,
          side: BorderSide.none,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        ),
      ),
    );
  }

  // Helper UI: Input Jarak
  Widget _buildDistanceInput() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        controller: distanceController,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: "Jarak Tempuh (KM)",
          prefixIcon: const Icon(Icons.speed_rounded, color: Color(0xFF14B8A6)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.all(20),
        ),
      ),
    );
  }
}