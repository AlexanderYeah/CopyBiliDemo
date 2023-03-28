import 'package:copy_bili_demo/provider/theme_provider.dart';
import 'package:copy_bili_demo/util/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbar_manager/flutter_statusbar_manager.dart';
import 'package:provider/provider.dart';

// 定义两个枚举 明亮模式 和 暗黑模式
enum StatusStyle { LIGHT_CONTENT, DARK_CONTENT }

class MyNavigationBar extends StatefulWidget {
  // 如果是dark 模式 调整style color
  StatusStyle style;
  final Color color;
  final double height;
  final Widget child;

  MyNavigationBar(
      {super.key,
      this.color = Colors.white,
      this.style = StatusStyle.LIGHT_CONTENT,
      required this.child,
      this.height = 46});

  @override
  State<MyNavigationBar> createState() => _MyNavigationBarState();
}

class _MyNavigationBarState extends State<MyNavigationBar> {
  var _color;
  var _statusStyle;

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = context.watch<ThemeProvider>();
    if (themeProvider.isDark()) {
      _color = SKColor.dark_bg;
      _statusStyle = StatusStyle.LIGHT_CONTENT;
    } else {
      _color = widget.color;
      _statusStyle = widget.style;
    }
    // 每一次build 修改状态栏的颜色
    _statusBarInit();
    // 顶部的状态栏的高度
    var top = MediaQuery.of(context).padding.top;
    return Container(
      // 屏幕的宽度
      width: MediaQuery.of(context).size.width,
      height: widget.height + top,
      // 传递过来的组件
      child: widget.child,
      padding: EdgeInsets.only(top: top),
      decoration: BoxDecoration(color: _color),
    );
  }

  void _statusBarInit() {
    // 沉浸式状态栏的设置
    FlutterStatusbarManager.setColor(_color, animated: false);
    FlutterStatusbarManager.setStyle(_statusStyle == StatusStyle.DARK_CONTENT
        ? StatusBarStyle.DARK_CONTENT
        : StatusBarStyle.LIGHT_CONTENT);
  }
}
