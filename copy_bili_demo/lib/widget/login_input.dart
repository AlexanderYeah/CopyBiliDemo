//自定义登录输入框
import 'package:copy_bili_demo/util/color.dart';
import 'package:flutter/material.dart';

class LoginInput extends StatefulWidget {
  final String title;
  final String hintText;
  // 输入内容回调
  final ValueChanged<String> onChanged;
  final ValueChanged<bool> focusChange;
  final bool obscureText;
  // 底下的线需不需要撑满一行
  final bool lineStretch;
  // 输入框的类型
  final TextInputType keyboardType;

  const LoginInput(
      {super.key,
      required this.title,
      required this.hintText,
      required this.onChanged,
      required this.focusChange,
      this.lineStretch = false,
      this.obscureText = false,
      required this.keyboardType});

  @override
  State<LoginInput> createState() => _LoginInputState();
}

class _LoginInputState extends State<LoginInput> {
  final _focusNode = FocusNode();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _focusNode.addListener(() {
      // 监听是否获取光标
      print("Has focus:${_focusNode.hasFocus}");
      if (widget.focusChange != null) {
        widget.focusChange(_focusNode.hasFocus);
      }
    });
  }

  // 页面销毁的时候 释放监听
  @override
  void dispose() {
    // TODO: implement dispose
    _focusNode.dispose();
    super.dispose();
  }

  /*****---UI-----***/
  _inputWidget() {
    return Expanded(
        child: TextField(
      focusNode: _focusNode,
      onChanged: widget.onChanged,
      obscureText: widget.obscureText,
      keyboardType: widget.keyboardType,
      autofocus: !widget.obscureText,
      style: TextStyle(
          fontSize: 16, color: Colors.black, fontWeight: FontWeight.w300),
      // 颜色设置成自己定义的主色
      cursorColor: primary,
      // 输入框的样式
      decoration: InputDecoration(
          // 左右的边距各20
          contentPadding: EdgeInsets.only(left: 20, right: 20),
          hintText: widget.hintText,
          hintStyle: TextStyle(fontSize: 15, color: Colors.grey)),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 15),
              child: Text(
                "${widget.title}",
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
            ),
            _inputWidget()
          ],
        )
      ],
    );
  }
}
