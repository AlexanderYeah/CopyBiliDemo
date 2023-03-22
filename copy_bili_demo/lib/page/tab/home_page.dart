import 'package:copy_bili_demo/http/core/sk_error.dart';
import 'package:copy_bili_demo/http/dao/home_dao.dart';
import 'package:copy_bili_demo/model/home_model.dart';
import 'package:copy_bili_demo/model/video_model.dart';
import 'package:copy_bili_demo/navigator/sk_navigator.dart';
import 'package:copy_bili_demo/page/home_tab_page.dart';
import 'package:copy_bili_demo/util/color.dart';
import 'package:copy_bili_demo/widget/navigation_bar.dart';
import 'package:copy_bili_demo/widget/toast.dart';
import 'package:flutter/material.dart';
import '../../core/sk_state.dart';

class HomePage extends StatefulWidget {
  final ValueChanged<int>? onJumpTo;
  const HomePage({super.key, this.onJumpTo});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends SKState<HomePage> with TickerProviderStateMixin {
  var listener;
  var tabs = ["推荐", "热门", "追播", "影视", "搞笑", "日常", "综合", "手机游戏", "短片*手机*配音"];
  List _catrgoryList = [];
  List _bannerList = [];
  TabController? _controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _loadData();
  }

  // 加载数据
  _loadData() async {
    try {
      HomeModel h_model = await HomeDao.get("推荐");
      // 根据服务端返回的数据动态的创建列表
      if (h_model.catrgoryList != null) {
        // 实例化controller
        _controller =
            TabController(length: h_model.catrgoryList!.length, vsync: this);
        setState(() {
          _catrgoryList = h_model.catrgoryList!;
          _bannerList = h_model.bannerList!;
        });
      }
    } on NeedAuth catch (e) {
      // 需要登录
      showWarnningToast("需要登录");
    } catch (error) {
      print(error);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    // SKNavigator.getIntance().removeListener(this.listener);
    _controller!.dispose();
    super.dispose();
  }

  _tabbar() {
    return TabBar(
        controller: _controller!,
        isScrollable: true,
        unselectedLabelColor: Colors.black,
        labelColor: primaryColor,
        indicator: UnderlineTabIndicator(
            borderSide: BorderSide(color: primaryColor, width: 2),
            insets: EdgeInsets.only(left: 10, right: 10)),
        tabs: _catrgoryList.map((title) {
          return Tab(
            child: Text(
              title,
              style: TextStyle(fontSize: 16),
            ),
          );
        }).toList());
  }

  _appBar() {
    return Padding(
      padding: EdgeInsets.only(left: 15, right: 15),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              print("object");
              if (widget.onJumpTo != null) {
                widget.onJumpTo!(3);
              }
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(23),
              child: Image(
                height: 46,
                width: 46,
                image: AssetImage("images/avatar.png"),
              ),
            ),
          ),
          // 输入框除了左右两边填充所有的内容
          Expanded(
              child: Padding(
            padding: EdgeInsets.only(left: 15, right: 15),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Container(
                padding: EdgeInsets.only(left: 10),
                height: 32,
                alignment: Alignment.centerLeft,
                child: Icon(Icons.search, color: Colors.grey),
                decoration: BoxDecoration(color: Colors.grey[100]),
              ),
            ),
          )),
          Icon(
            Icons.explore_outlined,
            color: Colors.grey,
          ),
          Padding(
            padding: EdgeInsets.only(left: 12),
            child: Icon(
              Icons.mail_outline,
              color: Colors.grey,
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          MyNavigationBar(
            child: _appBar(),
            height: 50,
            color: Colors.white,
          ),
          Container(
            margin: EdgeInsets.only(top: 30),
            child: _tabbar(),
          ),
          // tabbarView 和 tabbar 配合使用
          // tabbarView 和 tabbar 之所以能够联动 是因为共同一个controller
          Flexible(
              child: TabBarView(
                  controller: _controller,
                  children: _catrgoryList.map((title) {
                    return HomeTabPage(
                      name: title,
                      bannerList: title == "推荐" ? _bannerList : null,
                    );
                  }).toList()))
        ],
      ),
    );
  }
}
