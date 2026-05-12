import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/user_model.dart';
import '../viewmodels/run_viewmodel.dart';
import 'add_run_page.dart';

class DashboardPage extends StatelessWidget {
  final UserModel user;

  const DashboardPage({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {

    final runViewModel = Provider.of<RunViewModel>(context);

    final runs = runViewModel.runs;

    return Scaffold(
      backgroundColor: const Color(0xFFF1F7F6),

      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF14B8A6),
        elevation: 4,

        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),

        onPressed: () async {

          final result = await Navigator.push(
            context,

            MaterialPageRoute(
              builder: (_) => const AddRunPage(),
            ),
          );

          if (result != null) {
            runViewModel.addRun(result);
          }
        },
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            const SizedBox(height: 60),

            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,

              children: [

                Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: [

                    Text(
                      "Hai, ${user.username}! 👋",

                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0F172A),
                      ),
                    ),

                    const Text(
                      "Siap untuk lari hari ini?",

                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),

                const CircleAvatar(
                  backgroundColor:
                      Color(0xFF14B8A6),

                  child: Icon(
                    Icons.directions_run,
                    color: Colors.white,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            const Text(
              "Ringkasan Lari",

              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            Row(
              children: [

                _buildSummaryCard(
                  "Rata-rata Jarak",

                  "${runViewModel.averageDistance.toStringAsFixed(1)} km",

                  Icons.straighten,

                  const Color(0xFF14B8A6),
                ),

                const SizedBox(width: 15),

                _buildSummaryCard(
                  "Rata-rata Waktu",

                  "${runViewModel.averageDuration.toStringAsFixed(0)} menit",

                  Icons.timer_outlined,

                  const Color(0xFF6366F1),
                ),
              ],
            ),

            const SizedBox(height: 30),

            const Text(
              "Riwayat Lari",

              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            Expanded(
              child: ListView.builder(

                padding: EdgeInsets.zero,

                itemCount: runs.length,

                itemBuilder: (context, index) {

                  final run = runs[index];

                  return Container(
                    margin:
                        const EdgeInsets.only(bottom: 12),

                    decoration: BoxDecoration(
                      color: Colors.white,

                      borderRadius:
                          BorderRadius.circular(15),
                    ),

                    child: ListTile(
                      contentPadding:
                          const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 5,
                      ),

                      leading: Container(
                        padding: const EdgeInsets.all(8),

                        decoration: BoxDecoration(
                          color:
                              const Color(0xFFE0F2F1),

                          borderRadius:
                              BorderRadius.circular(10),
                        ),

                        child: const Icon(
                          Icons.directions_run,
                          color: Color(0xFF14B8A6),
                        ),
                      ),

                      title: Text(
                        run.date,

                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      subtitle: Text(
                        "${run.duration}m • ${run.startTime}",
                      ),

                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,

                        children: [

                          Text(
                            "${run.distance} km",

                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF14B8A6),
                              fontSize: 16,
                            ),
                          ),

                          PopupMenuButton(

                            icon: const Icon(
                              Icons.more_vert,
                              size: 20,
                            ),

                            onSelected: (value) async {

                              if (value == "delete") {

                                runViewModel.deleteRun(index);
                              }

                              if (value == "edit") {

                                final editedRun =
                                    await Navigator.push(
                                  context,

                                  MaterialPageRoute(
                                    builder: (_) =>
                                        AddRunPage(
                                      run: run,
                                    ),
                                  ),
                                );

                                if (editedRun != null) {

                                  runViewModel.updateRun(
                                    index,
                                    editedRun,
                                  );
                                }
                              }
                            },

                            itemBuilder: (context) => [

                              const PopupMenuItem(
                                value: "edit",
                                child: Text("Edit"),
                              ),

                              const PopupMenuItem(
                                value: "delete",
                                child: Text("Hapus"),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {

    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(15),

        decoration: BoxDecoration(
          color: Colors.white,

          borderRadius:
              BorderRadius.circular(20),
        ),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            Container(
              padding: const EdgeInsets.all(6),

              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),

                borderRadius:
                    BorderRadius.circular(8),
              ),

              child: Icon(
                icon,
                color: color,
                size: 20,
              ),
            ),

            const SizedBox(height: 12),

            Text(
              value,

              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            Text(
              title,

              style: const TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}