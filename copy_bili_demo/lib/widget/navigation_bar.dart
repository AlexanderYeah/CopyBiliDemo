import 'package:flutter/material.dart';
import 'package:flutter_statusbar_manager/flutter_statusbar_manager.dart';

// 定义两个枚举 明亮模式 和 暗黑模式
enum StatusStyle { LIGHT_CONTENT, DARK_CONTENT }

class MyNavigationBar extends StatelessWidget {
  StatusStyle style;
  final Color color;
  final double height;
  final Widget child;
  MyNavigationBar(
      {super.key,
      this.color = Colors.white,
      this.style = StatusStyle.DARK_CONTENT,
      required this.child,
      this.height = 46});
  void _statusBarInit() {
    // 沉浸式状态栏的设置
    FlutterStatusbarManager.setColor(color, animated: false);
    FlutterStatusbarManager.setStyle(style == StatusStyle.DARK_CONTENT
        ? StatusBarStyle.DARK_CONTENT
        : StatusBarStyle.LIGHT_CONTENT);
  }

  @override
  Widget build(BuildContext context) {
    // 顶部的状态栏的高度
    var top = MediaQuery.of(context).padding.top;
    return Container(
      // 屏幕的宽度
      width: MediaQuery.of(context).size.width,
      height: height + top,
      // 传递过来的组件
      child: child,
      padding: EdgeInsets.only(top: top),
      decoration: BoxDecoration(color: color),
    );
  }
}
