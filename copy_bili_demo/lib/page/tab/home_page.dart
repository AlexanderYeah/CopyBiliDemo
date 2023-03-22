import 'package:copy_bili_demo/model/video_model.dart';
import 'package:copy_bili_demo/navigator/sk_navigator.dart';
import 'package:copy_bili_demo/page/home_tab_page.dart';
import 'package:copy_bili_demo/util/color.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  var listener;
  var tabs = ["推荐", "热门", "追播", "影视", "搞笑", "日常", "综合", "手机游戏", "短片*手机*配音"];
  TabController? _controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // 实例化controller
    _controller = TabController(length: this.tabs.length, vsync: this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    // SKNavigator.getIntance().removeListener(this.listener);
    super.dispose();
  }

  _tabbar() {
    return TabBar(
        controller: _controller!,
        isScrollable: true,
        unselectedLabelColor: Colors.black,
        labelColor: primaryColor,
        indicator: UnderlineTabIndicator(
            borderSide: BorderSide(color: primaryColor, width: 2),
            insets: EdgeInsets.only(left: 10, right: 10)),
        tabs: tabs.map((title) {
          return Tab(
            child: Text(
              title,
              style: TextStyle(fontSize: 16),
            ),
          );
        }).toList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 30),
            child: _tabbar(),
          ),
          // tabbarView 和 tabbar 配合使用
          // tabbarView 和 tabbar 之所以能够联动 是因为共同一个controller
          Flexible(
              child: TabBarView(
                  controller: _controller,
                  children: tabs.map((tab) {
                    return HomeTabPage(
                      name: tab,
                    );
                  }).toList()))
        ],
      ),
    );
  }
}
