import 'package:copy_bili_demo/model/home_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
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
  _banner() {
    return Padding(
        padding: EdgeInsets.only(left: 8, right: 8),
        child: SKBanner(bannerList: widget.bannerList!));
  }

  List<Widget> _itemCardList() {
    return widget.videoList.map((item) {
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
    print(temp.length);
    return temp;
  }

  @override
  Widget build(BuildContext context) {
    // 移除ListView 默认的上方的边距
    return MediaQuery.removeViewPadding(
        removeTop: true,
        context: context,
        child: ListView(
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
        ));
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
