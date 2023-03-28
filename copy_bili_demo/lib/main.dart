import 'dart:convert';

import 'package:copy_bili_demo/db/sk_cache.dart';
import 'package:copy_bili_demo/model/home_model.dart';
import 'package:copy_bili_demo/navigator/sk_navigator.dart';
import 'package:copy_bili_demo/provider/theme_provider.dart';
import 'package:copy_bili_demo/widget/toast.dart';
import 'package:flutter/gestures.dart';
import './util/color.dart';
import 'package:flutter/material.dart';
import './http/dao/login_dao.dart';
import './page/login/register.dart';
import './page/login/login.dart';
import './page/tab/home_page.dart';
import './model/video_model.dart';
import './page/video_detail_page.dart';
import './navigator/bottom_navigator.dart';

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
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SKCache>(
      future: SKCache.preInit(),
      // initialData: InitialData,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        // 等待加载完成之后
        var widget = snapshot.connectionState == ConnectionState.done
            ? Router(
                // web 应用的话 要设置parser 和 provider
                // routeInformationParser: _routeInfomationParser,
                routerDelegate: _routerDelegate,
                // routeInformationProvider: PlatformRouteInformationProvider(
                //   //
                //   //初始化路由
                //   initialRouteInformation: RouteInformation(location: "/"),
                // )
              )
            : Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
        return MaterialApp(
          home: widget,
          theme: ThemeProvider().getTheme(),
          darkTheme: ThemeProvider().getTheme(isDarkMode: true),
          themeMode: ThemeProvider().getThemeMode(),
        );
      },
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

  BiliRouteDelegate() : navigatorKey = GlobalKey<NavigatorState>() {
    // 实现路由跳转逻辑
    SKNavigator.getIntance().registerRouteJump(
        RouteJumpListener(onJumpTo: (RouteStatus routeStatus, {Map? args}) {
      _routeStatus = routeStatus;
      if (routeStatus == RouteStatus.detail) {
        this.videoModel = args!['videoMo'];
      }
      notifyListeners();
    }));
  }

  List<MaterialPage> pages = [];
  VideoList? videoModel;
  // 默认设置成首页
  RouteStatus _routeStatus = RouteStatus.home;

  bool get hasLogin {
    return LoginDao.isUserLogin();
  }

  RouteStatus get routeStatus {
    // 拦截路由状态 进行判断
    // 当现在的路由状态不在注册页面并且没有登录的时候 去跳转登录页面
    if (_routeStatus != RouteStatus.register && !hasLogin) {
      print("未登录未登录未登录${hasLogin}");
      // 去登录
      _routeStatus = RouteStatus.login;
    } else if (videoModel != null) {
      return _routeStatus = RouteStatus.detail;
    } else {
      return _routeStatus;
    }
    return _routeStatus;
  }

  @override
  Widget build(BuildContext context) {
    // 管理路由堆栈
    // 首先获取打开的页面是否在路由堆栈里面
    int idx = getPageIndex(pages, _routeStatus);

    List<MaterialPage> tempPages = pages;
    if (idx != -1) {
      // 要打开的页面已经存在，则将该页面和它上面的所有页面都进行出栈
      // 栈中只允许有一个同样的页面实例,此处的操作是把当前的页面和之前的页面 全部出栈，后面在进行添加
      tempPages = tempPages.sublist(0, idx);
    }
    // 创建首页
    var page;
    // 跳转首页的时候 将栈其他页面进行出栈 因为首页不可以回退
    if (routeStatus == RouteStatus.home) {
      pages.clear();
      page = pageWrap(BottomNavigator());
    } else if (routeStatus == RouteStatus.detail) {
      page = pageWrap(VideoDetailPage(videoMo: videoModel));
    } else if (routeStatus == RouteStatus.register) {
      page = pageWrap(RegisterPage());
    } else if (routeStatus == RouteStatus.login) {
      page = pageWrap(LoginPage());
    }

    // 重新创建一个数组 否则pages 因为引用没有改变路由而不会生效
    // 复制tempPages 并且添加page
    tempPages = [...tempPages, page];
    // 赋值给真实的页面
    pages = tempPages;
    //1--- 这个是打开新页面的时候 通知路由发生变化
    //堆栈信息发生变化的时候 通知页面的变化
    SKNavigator.getIntance().notify(tempPages, pages);

    // TODO: implement build
    return Navigator(
        key: navigatorKey,
        pages: pages,
        onPopPage: ((route, result) {
          print("object");
          if ((route.settings as MaterialPage).child is LoginPage) {
            if (!hasLogin) {
              showWarnningToast("请先登录");
              return false;
            }
          }
          // 在这里可以控制是否可以返回上一页
          if (!route.didPop(result)) {
            return false;
          }
          //2--- 这个是返回的时候 通知路由发生变化
          // 返回上一页之后  移除最后一个
          var tempPages = [...pages];
          pages.removeLast();
          SKNavigator.getIntance().notify(tempPages, pages);
          return true;
        }));
  }

  @override
  Future<void> setNewRoutePath(BiliRoutePath configuration) {
    // TODO: implement setNewRoutePath
    throw UnimplementedError();
  }
}

// // 解析我们定义的数据类
// class BiliRouteInfomationParser extends RouteInformationParser<BiliRoutePath> {
//   @override
//   Future<BiliRoutePath> parseRouteInformation(
//       RouteInformation routeInformation) async {
//     final uri = Uri.parse(routeInformation.location!);
//     print("uri:$uri");
//     if (uri.pathSegments.length == 0) {
//       return BiliRoutePath.home();
//     }
//     return BiliRoutePath.detail();
//   }
// }

class BiliRoutePath {
  final String loaction;
  BiliRoutePath.home() : loaction = "/";
  BiliRoutePath.detail() : loaction = "/detail";
}
