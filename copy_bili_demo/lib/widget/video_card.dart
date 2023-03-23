import 'package:copy_bili_demo/model/home_model.dart';
import 'package:copy_bili_demo/model/video_model.dart';
import 'package:flutter/material.dart';

class VideoCard extends StatelessWidget {
  final VideoList videoMo;
  const VideoCard({super.key, required this.videoMo});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        child: Image.network(
      videoMo.cover!,
      fit: BoxFit.cover,
    ));
  }
}
