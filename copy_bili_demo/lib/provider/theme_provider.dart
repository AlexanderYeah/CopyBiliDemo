import 'package:copy_bili_demo/db/sk_cache.dart';
import 'package:copy_bili_demo/db/sk_constants.dart';
import 'package:copy_bili_demo/util/color.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

// 扩展themeMode
extension ThemeModeExtension on ThemeMode {
  String get value => <String>["System", "Light", "Dark"][index];
}

class ThemeProvider extends ChangeNotifier {
  ThemeMode? _themeMode;

  var _platformBrightness = SchedulerBinding.instance.window.platformBrightness;

  // 监听系统的模式变化
  void darkModeChange() {
    if (_platformBrightness !=
        SchedulerBinding.instance.window.platformBrightness) {
      _platformBrightness = SchedulerBinding.instance.window.platformBrightness;
    }
  }

  // 判断当前是否是dark mode
  bool isDark() {
    if (_themeMode == ThemeMode.system) {
      // 获取系统的dark mode
      return SchedulerBinding.instance.window.platformBrightness ==
          Brightness.dark;
    }
    return _themeMode == ThemeMode.dark;
  }

  // 获取mode的方式
  ThemeMode getThemeMode() {
    // 从本地缓存中读取设置过的主题
    String theme = SKCache.getInstance().get(SKConstants.theme) as String;
    switch (theme) {
      case "Dark":
        _themeMode = ThemeMode.dark;
        break;
      case "System":
        _themeMode = ThemeMode.system;
        break;
      default:
        _themeMode = ThemeMode.light;
        break;
    }
    return _themeMode!;
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
