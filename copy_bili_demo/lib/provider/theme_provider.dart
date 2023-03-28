import 'package:copy_bili_demo/db/sk_cache.dart';
import 'package:copy_bili_demo/db/sk_constants.dart';
import 'package:copy_bili_demo/util/color.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// 扩展themeMode
extension ThemeModeExtension on ThemeMode {
  String get value => <String>["System", "Light", "Dart"][index];
}

class ThemeProvider extends ChangeNotifier {
  ThemeMode? _themeMode;
  // 判断当前是否是dark mode
  bool isDark() => _themeMode == ThemeMode.dark;
  // 获取mode的方式
  ThemeMode getThemeMode() {
    // 从本地缓存中读取设置过的主题
    String theme = SKCache.getInstance().get(SKConstants.theme) as String;
    switch (theme) {
      case "Dark":
        _themeMode = ThemeMode.dark;
        break;
      case "Light":
        _themeMode = ThemeMode.light;
        break;
      case "System":
        _themeMode = ThemeMode.system;
        break;
      default:
        _themeMode = ThemeMode.system;
        break;
    }
    return _themeMode = ThemeMode.dark;
  }

  // 设置主题 设置mode 的方式
  void setTheme(ThemeMode themeMode) {
    SKCache.getInstance().setString(SKConstants.theme, themeMode.value);
    // 通知所有的订阅者
    notifyListeners();
  }

  // 获取themedata
  ThemeData getTheme({bool isDarkMode = false}) {
    var themeData = ThemeData(
      brightness: isDarkMode ? Brightness.dark : Brightness.light,
      errorColor: isDarkMode ? SKColor.dark_red : SKColor.red,
      // 主色调
      primaryColor: isDarkMode ? SKColor.dark_bg : whiteColor,
      // 指示器的颜色
      indicatorColor: isDarkMode ? primaryColor[50] : whiteColor,
      // 页面背景色
      scaffoldBackgroundColor: isDarkMode ? SKColor.dark_bg : whiteColor,
    );
    return themeData;
  }
}
