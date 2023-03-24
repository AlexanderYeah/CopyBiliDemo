import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

class VideoView extends StatefulWidget {
  final String url;
  final String cover;
  final bool autoPlay;
  // 是否循环播放
  final bool looping;
  // 尺寸比例
  final double aspectRatio;

  const VideoView(
      {super.key,
      required this.url,
      required this.cover,
      this.autoPlay = false,
      this.looping = false,
      this.aspectRatio = 16 / 9});

  @override
  State<VideoView> createState() => _VideoViewState();
}

class _VideoViewState extends State<VideoView> {
  // 两个controller
  VideoPlayerController? _videoPlayController;
  ChewieController? _chewieController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // 初始化播放器
    _videoPlayController =
        VideoPlayerController.asset("assets/big_buck_bunny.mp4");
    //设置视频播放参数
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayController!,
      autoPlay: false,
      looping: widget.looping,
      aspectRatio: widget.aspectRatio,
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _videoPlayController!.dispose();
    _chewieController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 获取屏幕的宽度
    var screenWidth = MediaQuery.of(context).size.width;
    var playerHeight = screenWidth / widget.aspectRatio;
    return Container(
      height: playerHeight,
      width: screenWidth,
      color: Colors.grey,
      child: Chewie(controller: _chewieController!),
    );
  }
}
