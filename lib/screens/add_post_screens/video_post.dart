import 'dart:io';
import 'package:video_player/video_player.dart';

import 'package:flutter/material.dart';

class VideoPost extends StatefulWidget {
  final File videoFile;
  final String videoPath;
  const VideoPost(
      {super.key, required this.videoFile, required this.videoPath});

  @override
  State<VideoPost> createState() => _VideoPostState();
}

class _VideoPostState extends State<VideoPost> {
  late VideoPlayerController controller;
  @override
  void initState() {
    super.initState();
    setState(() {
      controller = VideoPlayerController.file(widget.videoFile);
    });
    controller.initialize();
    controller.play();
    controller.setVolume(1);
    controller.setLooping(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            color: const Color.fromARGB(255, 255, 191, 0),
            width: 33,
            height: 55,
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: VideoPlayer(controller),
          )
        ]),
      ),
    );
  }
}
