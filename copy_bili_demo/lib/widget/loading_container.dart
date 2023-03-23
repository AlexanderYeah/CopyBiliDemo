import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingContainer extends StatelessWidget {
  // 显示到哪个页面
  final Widget child;
  final bool isLoading;
  // 加载动画是否覆盖到原来的界面之上
  final bool cover;
  const LoadingContainer(
      {super.key,
      required this.isLoading,
      required this.child,
      this.cover = false});

  Widget _loadingView() {
    return Center(
      child: Lottie.asset('assets/loading.json'),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (cover) {
      return Stack(
        children: [child, isLoading ? _loadingView() : Container()],
      );
    } else {
      return isLoading ? _loadingView() : child;
    }
  }
}
