import 'package:flutter/material.dart';

class AddPostVideo extends StatefulWidget {
  const AddPostVideo({super.key});

  @override
  State<AddPostVideo> createState() => _AddPostVideoState();
}

class _AddPostVideoState extends State<AddPostVideo> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
          child: Text(
        "add video",
      )),
    );
  }
}
