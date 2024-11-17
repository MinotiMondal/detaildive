import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/post_controller.dart';
import 'post_detail_view.dart';
import '../controllers/timer_controller.dart';
import 'package:visibility_detector/visibility_detector.dart';

class PostDetailView extends StatelessWidget {
  final int postId;

  PostDetailView({required this.postId, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PostController controller = Get.find<PostController>();
    final TimerController timerController =
        Get.find<TimerController>(tag: 'post_$postId');

    controller.fetchPostDetail(postId);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Post Details'),
      ),
      body: Obx(() {
        if (controller.isDetailLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final post = controller.postDetail.value;
        if (post == null) {
          return const Center(child: Text('Failed to load post details'));
        }

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(post.title,
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              Text(post.body),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Get.back();
                  timerController.resumeTimer(post.id);
                },
                child: const Text('Go Back'),
              ),
            ],
          ),
        );
      }),
    );
  }
}
