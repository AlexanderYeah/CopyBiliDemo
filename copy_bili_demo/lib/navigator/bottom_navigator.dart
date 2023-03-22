import 'package:copy_bili_demo/page/tab/favorite_page.dart';
import 'package:copy_bili_demo/page/tab/home_page.dart';
import 'package:copy_bili_demo/page/tab/profile_page.dart';
import 'package:copy_bili_demo/page/tab/ranking_page.dart';
import 'package:copy_bili_demo/util/color.dart';
import 'package:flutter/material.dart';

class BottomNavigator extends StatefulWidget {
  const BottomNavigator({super.key});

  @override
  State<BottomNavigator> createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> {
  final _defaultColor = Colors.grey;
  final _activeColor = primaryColor;
  int _currentIdx = 0;
  List<Widget> _pages = [];
  final PageController _controller = PageController(initialPage: 0);

  _bottomItem(String title, IconData icon, int index) {
    return BottomNavigationBarItem(icon: Icon(icon), label: title);
  }

  @override
  Widget build(BuildContext context) {
    _pages = [
      HomePage(
        onJumpTo: (idx) {
          setState(() {
            _currentIdx = idx;
            _controller.jumpToPage(idx);
          });
        },
      ),
      RankingPage(),
      FavoritePage(),
      ProfilePage()
    ];
    return Scaffold(
      body: PageView(
        onPageChanged: (value) {
          // 监听页面索引变化
          setState(() {
            _currentIdx = value;
          });
        },
        // 这个设置可以禁止pageview 进行滚动
        physics: NeverScrollableScrollPhysics(),
        controller: _controller,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (idx) {
          // pageView 展示对应的tab
          _controller.jumpToPage(idx);
          setState(() {
            _currentIdx = idx;
          });
          print(idx);
        },
        currentIndex: _currentIdx,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: _activeColor,
        items: [
          _bottomItem("首页", Icons.home, 0),
          _bottomItem("排行", Icons.local_fire_department, 1),
          _bottomItem("收藏", Icons.favorite, 2),
          _bottomItem("我的", Icons.live_tv, 3),
        ],
      ),
    );
  }
}
