import 'package:flutter/material.dart';

class LoginEffect extends StatefulWidget {
  final bool protect;
  const LoginEffect(@required this.protect, {super.key});
  @override
  State<LoginEffect> createState() => _LoginEffectState();
}

class _LoginEffectState extends State<LoginEffect> {
  @override
  _image(isLeft) {
    var headerLeft = widget.protect
        ? "images/head_left_protect.png"
        : "images/head_left.png";
    var headerRight = widget.protect
        ? "images/head_right_protect.png"
        : "images/head_right.png";
    print(headerLeft);
    return Image.asset(
      isLeft ? headerLeft : headerRight,
      width: 100,
      height: 100,
      fit: BoxFit.fill,
    );
  }

  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        border: Border(bottom: BorderSide(color: Colors.grey)),
      ),
      // 放两张图片在两边
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _image(true),
          Image.asset("images/logo.png", width: 90, height: 90),
          _image(false)
        ],
      ),
    );
  }
}
