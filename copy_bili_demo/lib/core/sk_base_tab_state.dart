import 'dart:ffi';
import 'dart:math';

import 'package:copy_bili_demo/core/sk_state.dart';
import 'package:copy_bili_demo/http/core/sk_error.dart';
import 'package:flutter/material.dart';

import '../util/color.dart';

// M 为 Dao 返回的数据模型 L为列表数据模型 T 为 具体的Widget
// 定义为抽象类 里面没有具体的业务
abstract class SKBaseTabState<M, L, T extends StatefulWidget> extends SKState<T>
    with AutomaticKeepAliveClientMixin {
  // 通用的数据模型
  List<L> dataList = [];
  int pageIndex = 1;
  // 设置一个标记位 当正在加载的时候 下拉的时候不再请求数据
  bool loading = false;
  ScrollController scrollController = ScrollController();
  // 获取对应页码的数据
  Future<M> getData(int pageIdx);
  // 从MO 中解析出list的数据
  List<L> parseList(M result);
  // 获取子类的widget
  get contentChild;

  @override
  void initState() {
    super.initState();
    loadData();
    // 监听列表的滚动
    scrollController.addListener(() {
      // 最大滚动的距离 减去当前滚动的距离 就是差底部还有多远的距离
      var distance = scrollController.position.maxScrollExtent -
          scrollController.position.pixels;
      // 当底部不足200的时候去加载更多
      if (distance < 200 && !loading) {
        loadData(loadMore: true);
      }
    });
  }

  Future<void> loadData({loadMore = false}) async {
    if (loading) {
      print("上次加载还没完成");
      return;
    }
    loading = true;
    if (!loadMore) {
      pageIndex = 1;
    }
    var currentPage = pageIndex + (loadMore ? 1 : 0);
    print("currentPage:$currentPage");
    try {
      var result = await getData(currentPage);
      setState(() {
        if (loadMore) {
          dataList = [...dataList, ...parseList(result)];
          if (parseList(result).length != 0) {
            pageIndex++;
          }
        } else {
          dataList = parseList(result);
        }
        loading = false;
      });
    } on NeedLogin catch (e) {
      print("需要登录");
      loading = false;
    } catch (error) {
      print(error);
      loading = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return RefreshIndicator(
        child: contentChild,
        color: primaryColor,
        // 返回的future 的结果
        onRefresh: loadData);
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
