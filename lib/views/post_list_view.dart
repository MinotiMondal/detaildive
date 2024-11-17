import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/post_controller.dart';
import 'post_detail_view.dart';
import '../controllers/timer_controller.dart';
import 'package:visibility_detector/visibility_detector.dart';

class PostListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final PostController controller = Get.find<PostController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
          itemCount: controller.posts.length,
          itemBuilder: (context, index) {
            final post = controller.posts[index];

            // Create or find TimerController for each post
            final TimerController timerController =
                Get.put(TimerController(), tag: 'post_${post.id}');

            return VisibilityDetector(
              key: Key('post_${post.id}'),
              onVisibilityChanged: (info) {
                if (info.visibleFraction > 0) {
                  timerController.startTimer(post.id, 30);
                } else {
                  timerController.pauseTimer(post.id);
                }
              },
              child: GestureDetector(
                onTap: () {
                  timerController.pauseTimer(post.id); // Pause on tap
                  controller.markAsRead(post.id); // Mark post as read
                  Get.to(() => PostDetailView(postId: post.id));
                },
                child: Container(
                  color: post.isRead ? Colors.white : Colors.yellow[100],
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(post.title,
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 8),
                            Text(post.body),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.timer, color: Colors.orange),
                          const SizedBox(width: 8),
                          Obx(() {
                            final timerValue =
                                timerController.remainingTimes[post.id] ?? 30;
                            return Text('${timerValue}s',
                                style: const TextStyle(fontSize: 16));
                          }),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
