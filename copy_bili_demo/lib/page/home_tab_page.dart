import 'package:copy_bili_demo/model/home_model.dart';
import 'package:flutter/material.dart';

class HomeTabPage extends StatefulWidget {
  final String? name;
  final List? bannerList;
  const HomeTabPage({super.key, this.name, this.bannerList});

  @override
  State<HomeTabPage> createState() => _HomeTabPageState();
}

class _HomeTabPageState extends State<HomeTabPage> {
  @override
  Widget build(BuildContext context) {
    return Text(widget.name!);
  }
}
