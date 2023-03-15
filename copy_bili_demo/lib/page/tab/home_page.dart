import 'package:copy_bili_demo/model/video_model.dart';
import 'package:copy_bili_demo/navigator/sk_navigator.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var listener;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // SKNavigator.getIntance().addListener(this.listener = (current, pre) {
    //   // print("current:${current.page}");
    //   // print("previous:${pre.page}");
    //   if (widget == current.page || current.page is HomePage) {
    //     print("打开了首页");
    //   }
    // });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    // SKNavigator.getIntance().removeListener(this.listener);
    super.dispose();
  }

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
                onPressed: () {
                  SKNavigator.getIntance().onJumpTo(RouteStatus.detail);
                }),
          ],
        ),
      ),
    );
  }
}
