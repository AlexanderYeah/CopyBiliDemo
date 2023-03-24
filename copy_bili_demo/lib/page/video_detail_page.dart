import 'package:copy_bili_demo/model/home_model.dart';
import 'package:copy_bili_demo/widget/video_view.dart';
import 'package:flutter/material.dart';

class VideoDetailPage extends StatefulWidget {
  final VideoList? videoMo;
  const VideoDetailPage({this.videoMo});

  @override
  State<VideoDetailPage> createState() => _VideoDetailPageState();
}

class _VideoDetailPageState extends State<VideoDetailPage> {
  _videoView() {
    if (widget.videoMo != null) {
      print(widget.videoMo!.url);
      return VideoView(
          url: widget.videoMo!.url!, cover: widget.videoMo!.cover!);
    } else {
      Text("");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            widget.videoMo != null
                ? Text("${widget.videoMo!.cover}")
                : Text(""),
            _videoView()
          ],
        ));
  }
}
