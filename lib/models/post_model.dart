import 'dart:math';

class Post {
  final int userId;
  final int id;
  final String title;
  final String body;
  bool isRead;
  int timerDuration; // Add this field

  Post({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
    this.isRead = false,
    required this.timerDuration, // Initialize with random value
  });

  // Updated factory method
  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      userId: json['userId'] ?? 0,
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      body: json['body'] ?? '',
      isRead: false, // Default value is false
      timerDuration: Random().nextInt(21) +
          10, // Random timer duration between 10-30 seconds
    );
  }
}
