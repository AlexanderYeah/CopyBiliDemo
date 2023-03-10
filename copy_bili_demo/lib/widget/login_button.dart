import 'package:copy_bili_demo/util/color.dart';
import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  final String title;
  final bool enable;
  final VoidCallback onPressed;
  const LoginButton(this.title,
      {Key? key, this.enable = false, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 撑满整个屏幕
    return FractionallySizedBox(
      widthFactor: 1,
      child: MaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        height: 45,
        onPressed: enable ? onPressed : null,
        disabledColor: primaryColor[50],
        color: primaryColor,
        child: Text(
          title,
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}
