import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showWarnningToast(String text) {
  // 显示底部
  Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      backgroundColor: Colors.redAccent,
      textColor: Colors.white);
}

void showToast(String text) {
  // 显示底部
  Fluttertoast.showToast(
      msg: text, toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.CENTER);
}
