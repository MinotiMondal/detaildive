import 'package:get/get.dart';
import '../models/post_model.dart';
import '../services/post_service.dart';

// class PostController extends GetxController {
//   final PostService _postService = PostService();
//   var posts = <Post>[].obs;
//   var isLoading = false.obs;
//   var postDetail = Rxn<Post>();
//   var isDetailLoading = false.obs;
//   var readPosts = <int>{}.obs; // Track read posts

//   @override
//   void onInit() {
//     fetchPosts();
//     super.onInit();
//   }

//   void fetchPosts() async {
//     isLoading.value = true;
//     try {
//       posts.value =
//           await _postService.fetchPosts(); // Now this works with an instance
//     } catch (e) {
//       print("Error fetching posts: $e");
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   void fetchPostDetail(int postId) async {
//     isDetailLoading.value = true;
//     try {
//       postDetail.value =
//           await _postService.fetchPostDetail(postId); // Access instance method
//     } catch (e) {
//       print("Error fetching post detail: $e");
//     } finally {
//       isDetailLoading.value = false;
//     }
//   }

//   void markAsRead(int postId) {
//     final post = posts.firstWhere((post) => post.id == postId);
//     post.isRead = true; // Update the post's read status
//     posts.refresh(); // Refresh the list to reflect the color change
//   }
// }

class PostController extends GetxController {
  RxList<Post> posts = <Post>[].obs;
  RxBool isLoading = true.obs;
  RxBool isDetailLoading = true.obs;
  Rx<Post?> postDetail = Rx<Post?>(null);

  final PostService _postService =
      PostService(); // Create an instance of PostService

  @override
  void onInit() {
    fetchPosts();
    super.onInit();
  }

  Future<void> fetchPosts() async {
    isLoading(true);
    try {
      posts.value = await _postService.fetchPosts();
    } catch (e) {
      // Handle error
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchPostDetail(int postId) async {
    isDetailLoading(true);
    try {
      postDetail.value = await _postService.fetchPostDetail(postId);
    } catch (e) {
      // Handle error
    } finally {
      isDetailLoading(false);
    }
  }

  void markAsRead(int postId) {
    final post = posts.firstWhere((p) => p.id == postId);
    post.isRead = true;
    posts.refresh();
  }
}
