import 'package:copy_bili_demo/util/color.dart';
import 'package:copy_bili_demo/util/view_util.dart';
import 'package:flutter/material.dart';

class RankingPage extends StatefulWidget {
  const RankingPage({super.key});

  @override
  State<RankingPage> createState() => _RankingPageState();
}

class _RankingPageState extends State<RankingPage>
    with TickerProviderStateMixin {
  static const tabs = ["最热", "最新", "收藏"];
  TabController? _controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TabController(length: tabs.length, vsync: this);
  }

  _buildTabBar() {
    return Container(
      width: 200,
      child: TabBar(
          controller: _controller,
          labelColor: primaryColor,
          isScrollable: false,
          unselectedLabelColor: Colors.black,
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
          }).toList()),
    );
  }

  _buildTabView() {
    // 撑满所有的空间
    return Flexible(
        child: TabBarView(
            controller: _controller,
            children: tabs.map((e) {
              return Text("data");
            }).toList()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // 居中显示
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(top: 30),
            child: _buildTabBar(),
            decoration: bottomBoxShadow(),
          ),
          _buildTabView(),
        ],
      ),
    );
  }
}
