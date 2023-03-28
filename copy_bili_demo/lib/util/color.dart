import 'package:flutter/material.dart';

// 如何定义 可以参考Colors.blue 系统是如何定义的
// 主色
const MaterialColor primaryColor = const MaterialColor(
    0xfffb7299, const <int, Color>{50: const Color(0xffff9db5)});

// 白色
const MaterialColor whiteColor = const MaterialColor(0xFFFFFFFF, <int, Color>{
  50: const Color(0xffffffff),
  100: const Color(0xffffffff),
  200: const Color(0xffffffff),
  300: const Color(0xffffffff),
  400: const Color(0xffffffff),
  500: const Color(0xffffffff),
  600: const Color(0xffffffff),
  700: const Color(0xffffffff),
  800: const Color(0xffffffff),
  900: const Color(0xffffffff)
});

class SKColor {
  static const Color red = Color(0xFFFF4759);
  static const Color dark_red = Color(0xFFE03E4E);
  static const Color dark_bg = Color(0xFF18191A);
}
