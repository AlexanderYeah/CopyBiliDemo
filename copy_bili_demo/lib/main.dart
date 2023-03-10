import 'dart:convert';

import 'package:copy_bili_demo/db/sk_cache.dart';
import 'package:flutter/gestures.dart';
import './util/color.dart';
import 'package:flutter/material.dart';
import './http/dao/login_dao.dart';
import './page/login/register.dart';
import './page/login/login.dart';
import './page/tab/home_page.dart';
import './model/video_model.dart';
import './page/video_detail_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  RouterDelegate _routerDelegate = BiliRouteDelegate();
  BiliRouteInfomationParser _routeInfomationParser =
      BiliRouteInfomationParser();
  @override
  Widget build(BuildContext context) {
    var widget = Router(
      routeInformationParser: _routeInfomationParser,
      routerDelegate: _routerDelegate,
      routeInformationProvider: PlatformRouteInformationProvider(
        //
        //初始化路由
        initialRouteInformation: RouteInformation(location: "/"),
      ),
    );
    return MaterialApp(
      home: widget,
    );
  }
}

pageWrap(Widget child) {
  return MaterialPage(key: ValueKey(child.hashCode), child: child);
}

class BiliRouteDelegate extends RouterDelegate<BiliRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  //为Navigator设置一个key，必要的时候可以通过navigatorKey.currentState来获取到NavigatorState对象
  late final GlobalKey<NavigatorState> navigatorKey;

  BiliRouteDelegate() : navigatorKey = GlobalKey<NavigatorState>();

  List<MaterialPage> pages = [];

  late BiliRoutePath path;
  @override
  Widget build(BuildContext context) {
    // 构建路由栈
    pages = [
      pageWrap(HomePage(
        jumpToDetail: (value) {
          print("跳转详情");
          // 更新
          notifyListeners();
        },
      )),
      pageWrap(VideoDetailPage()),
    ];

    // TODO: implement build
    return Navigator(
        key: navigatorKey,
        pages: pages,
        onPopPage: ((route, result) {
          // 在这里可以控制是否可以返回上一页
          if (!route.didPop(result)) {
            return false;
          }
          return true;
        }));
  }

  @override
  Future<void> setNewRoutePath(BiliRoutePath path) async {
    // TODO: implement setNewRoutePath
    this.path = path;
  }
}

// 解析我们定义的数据类
class BiliRouteInfomationParser extends RouteInformationParser<BiliRoutePath> {
  @override
  Future<BiliRoutePath> parseRouteInformation(
      RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location!);
    print("uri:$uri");
    if (uri.pathSegments.length == 0) {
      return BiliRoutePath.home();
    }
    return BiliRoutePath.detail();
  }
}

class BiliRoutePath {
  final String loaction;
  BiliRoutePath.home() : loaction = "/";
  BiliRoutePath.detail() : loaction = "/detail";
}
