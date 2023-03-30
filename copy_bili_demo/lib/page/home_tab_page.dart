import 'package:copy_bili_demo/http/dao/home_dao.dart';
import 'package:copy_bili_demo/model/home_model.dart';
import 'package:copy_bili_demo/util/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:sk_net/core/sk_error.dart';
import '../../widget/sk_banner.dart';
import '../widget/video_card.dart';

class HomeTabPage extends StatefulWidget {
  final String? name;
  final List? bannerList;
  final List videoList;
  const HomeTabPage(
      {super.key, this.name, required this.videoList, this.bannerList});

  @override
  State<HomeTabPage> createState() => _HomeTabPageState();
}

class _HomeTabPageState extends State<HomeTabPage>
    with AutomaticKeepAliveClientMixin {
  List _videoList = [];
  // 构建一个scrollController 监听列表的滚动 从而实现上拉加载更多
  // 记得把controller 绑定到列表上去
  ScrollController _scrollController = ScrollController();
  // 设置一个标记位 当正在加载的时候 下拉的时候不再请求数据
  bool _isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _videoList = widget.videoList;
    // 监听列表的滚动
    _scrollController.addListener(() {
      // 最大滚动的距离 减去当前滚动的距离 就是差底部还有多远的距离
      var distance = _scrollController.position.maxScrollExtent -
          _scrollController.position.pixels;
      // 当底部不足200的时候去加载更多
      if (distance < 200 && !_isLoading) {
        _loadData(isLoadMore: true);
      }
    });
  }

  Future<void> _loadData({bool isLoadMore = false}) async {
    _isLoading = true;
    try {
      // 这里参数是写死的 不用传递
      HomeModel homeModel = await HomeDao.get("categoryName");
      setState(() {
        if (isLoadMore) {
          // 上拉加载
          _videoList = [..._videoList, ...homeModel.videoList!];
        } else {
          // 下拉刷新
          _videoList = homeModel.videoList!;
        }
        // 因为数据渲染到页面有一个时间 所以延迟把标志位复位
        Future.delayed(Duration(milliseconds: 1000), () {
          _isLoading = false;
        });
      });
    } on NeedLogin catch (e) {
      _isLoading = false;
      print("请登录");
    } catch (error) {
      _isLoading = false;
      print(error);
    }
  }

  _banner() {
    return Padding(
        padding: EdgeInsets.only(left: 8, right: 8),
        child: SKBanner(bannerList: widget.bannerList!));
  }

  List<Widget> _itemCardList() {
    return _videoList.map((item) {
      return StaggeredGridTile.count(
        crossAxisCellCount: 1,
        mainAxisCellCount: 1,
        child: VideoCard(videoMo: item),
      );
    }).toList();
  }

  List<Widget> _combine() {
    List<Widget> temp = [
      // 第一个是banner
      StaggeredGridTile.count(
          crossAxisCellCount: 2,
          mainAxisCellCount: 1,
          child:
              Padding(padding: EdgeInsets.only(bottom: 8), child: _banner())),
    ];
    temp.addAll(_itemCardList());

    return temp;
  }

  @override
  Widget build(BuildContext context) {
    // 最外层包裹的是刷新的组件
    return RefreshIndicator(
        // 移除ListView 默认的上方的边距
        child: MediaQuery.removeViewPadding(
            removeTop: true,
            context: context,
            child: ListView(
              // 这个设置即使返回的数据只有一个item 也可以进行下拉刷新的 以防不能滚动 不能刷新
              physics: const AlwaysScrollableScrollPhysics(),
              controller: _scrollController,
              children: [
                StaggeredGrid.count(
                  // 滚动方向往下走的
                  axisDirection: AxisDirection.down,
                  crossAxisCount: 2,
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 4,
                  children: _combine(),
                )
              ],
            )),
        // 刷新指示器的颜色
        color: primaryColor,
        // 返回的future 的结果
        onRefresh: _loadData);
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
