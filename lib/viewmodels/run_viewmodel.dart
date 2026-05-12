import 'package:flutter/material.dart';
import '../models/run_model.dart';

class RunViewModel extends ChangeNotifier {

  List<RunModel> runs = [

    RunModel(
      date: "7/5/2026",
      startTime: "7:00 AM",
      endTime: "7:35 AM",
      duration: 35,
      distance: 5,
    ),
  ];

  void addRun(RunModel run) {
    runs.add(run);
    notifyListeners();
  }

  void deleteRun(int index) {
    runs.removeAt(index);
    notifyListeners();
  }

  void updateRun(int index, RunModel run) {
    runs[index] = run;
    notifyListeners();
  }

  double get averageDistance {

    if (runs.isEmpty) return 0;

    double total = 0;

    for (var run in runs) {
      total += run.distance;
    }

    return total / runs.length;
  }

  double get averageDuration {

    if (runs.isEmpty) return 0;

    double total = 0;

    for (var run in runs) {
      total += run.duration;
    }

    return total / runs.length;
  }
}