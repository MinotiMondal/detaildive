import 'package:get/get.dart';
import '../controllers/post_controller.dart';
import '../controllers/timer_controller.dart';

class PostBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(PostController()); // Register PostController globally
    Get.put(TimerController()); // Register TimerController globally
  }
}
