import 'package:flutter/material.dart';

abstract class SKState<T extends StatefulWidget> extends State<T> {
  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    if (mounted) {
      super.setState(fn);
    } else {
      print("SKState:页面已经销毁,本次setState不执行:${toString()}");
    }
  }
}
