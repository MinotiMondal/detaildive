import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'bindings/post_binding.dart';
import 'views/post_list_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: PostBinding(),
      home: PostListView(),
      debugShowCheckedModeBanner: false,
    );
  }
}
