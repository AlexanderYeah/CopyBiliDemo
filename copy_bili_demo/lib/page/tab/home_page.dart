import 'package:copy_bili_demo/model/video_model.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final ValueChanged<VideoModel> jumpToDetail;
  const HomePage({super.key, required this.jumpToDetail});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Column(
          children: [
            Text("首页"),
            MaterialButton(
                child: Text("详情"),
                onPressed: () => widget.jumpToDetail(VideoModel("111"))),
          ],
        ),
      ),
    );
  }
}
