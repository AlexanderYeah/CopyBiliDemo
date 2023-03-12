import 'package:copy_bili_demo/page/login/login.dart';
import 'package:copy_bili_demo/page/login/register.dart';
import 'package:copy_bili_demo/page/tab/home_page.dart';
import 'package:copy_bili_demo/page/video_detail_page.dart';
import 'package:flutter/material.dart';

pageWrap(Widget child) {
  return MaterialPage(key: ValueKey(child.hashCode), child: child);
}

// 定义路由的状态
enum RouteStatus {
  home,
  login,
  register,
  detail,
  unknown,
}

// 获取路由在堆栈中的位置
getPageIndex(List<MaterialPage> pages, RouteStatus status) {
  for (var i = 0; i < pages.length; i++) {
    MaterialPage page = pages[i];
    if (getStatus(page) == status) {
      return i;
    } else {
      return -1;
    }
  }
}

// 获取路由的状态

RouteStatus getStatus(MaterialPage page) {
  if (page.child is LoginPage) {
    return RouteStatus.login;
  } else if (page.child is RegisterPage) {
    return RouteStatus.register;
  } else if (page.child is HomePage) {
    return RouteStatus.home;
  } else if (page.child is VideoDetailPage) {
    return RouteStatus.detail;
  } else {
    return RouteStatus.unknown;
  }
}

class RouteStatusInfo {
  final RouteStatus routeStatus;
  final Widget page;
  RouteStatusInfo(this.routeStatus, this.page);
}

// 监听路由页面跳转 感知当前页面是否在压后台
class SKNavigator extends _RouteJumpListener {
  static SKNavigator? _instance;
  var _routeJump;
  static SKNavigator getIntance() {
    if (_instance == null) {
      _instance = SKNavigator();
    }
    return _instance!;
  }

  // 注册路由的跳转逻辑
  void registerRouteJump(RouteJumpListener routeJumpListener) {
    this._routeJump = routeJumpListener;
  }

  @override
  void onJumpTo(RouteStatus status, {Map? args}) {
    // TODO: implement onJumpTo
    _routeJump.onJumpTo(status, args: args);
  }
}

// 定义一个抽象类 用来跳转
abstract class _RouteJumpListener {
  // 跳转的方法
  void onJumpTo(RouteStatus status, {Map args});
}

// 定义一个类型
typedef OnJumpTo = void Function(RouteStatus status, {Map args});

class RouteJumpListener {
  final OnJumpTo onJumpTo;
  RouteJumpListener({required this.onJumpTo});
}
