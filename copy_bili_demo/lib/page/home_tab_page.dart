import 'package:copy_bili_demo/model/home_model.dart';
import 'package:flutter/material.dart';
import '../../widget/sk_banner.dart';

class HomeTabPage extends StatefulWidget {
  final String? name;
  final List? bannerList;
  const HomeTabPage({super.key, this.name, this.bannerList});

  @override
  State<HomeTabPage> createState() => _HomeTabPageState();
}

class _HomeTabPageState extends State<HomeTabPage> {
  _banner() {
    return Padding(
        padding: EdgeInsets.only(left: 8, right: 8),
        child: SKBanner(bannerList: widget.bannerList!));
  }

  @override
  Widget build(BuildContext context) {
    return ListView(children: [if (widget.bannerList != null) _banner()]);
  }
}
