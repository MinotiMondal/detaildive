import 'dart:async';
import 'package:get/get.dart';

class TimerController extends GetxController {
  RxMap<int, int> remainingTimes =
      <int, int>{}.obs; // Remaining time for each post
  RxMap<int, Timer?> timers = <int, Timer?>{}.obs; // Timers for each post

  // Start the timer for a specific post
  void startTimer(int postId, int duration) {
    if (timers[postId] != null) return; // Timer already running

    int initialTime = remainingTimes[postId] ?? duration;
    remainingTimes[postId] = initialTime;

    timers[postId] = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingTimes[postId]! > 0) {
        remainingTimes[postId] = remainingTimes[postId]! - 1;
      } else {
        stopTimer(postId);
      }
    });
  }

  // Pause the timer for a specific post
  void pauseTimer(int postId) {
    timers[postId]?.cancel();
    timers[postId] = null;
  }

  // Resume the timer from where it was paused
  void resumeTimer(int postId) {
    if (remainingTimes[postId] != null && remainingTimes[postId]! > 0) {
      startTimer(postId, remainingTimes[postId]!);
    }
  }

  // Stop the timer for a specific post
  void stopTimer(int postId) {
    timers[postId]?.cancel();
    timers[postId] = null;
    remainingTimes[postId] = 0; // Optional: Reset time to 0
  }
}
