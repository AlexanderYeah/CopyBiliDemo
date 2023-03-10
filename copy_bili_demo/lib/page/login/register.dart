import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../widget/login_input.dart';
import '../../widget/appbar.dart';
import '../../widget/login_effect.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _isProtect = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar("注册", "登录", () {
        print("登录");
      }),
      body: Container(
        child: ListView(
          children: [
            LoginEffect(_isProtect),
            LoginInput(
                title: "用户名",
                hintText: "请输入用户名",
                onChanged: (value) {
                  print(value);
                },
                focusChange: (value) {}),
            LoginInput(
                title: "密码",
                hintText: "请输入密码",
                obscureText: true,
                onChanged: (value) {
                  print(value);
                },
                focusChange: (value) {
                  print(value);
                  this.setState(() {
                    _isProtect = value;
                  });
                }),
          ],
        ),
      ),
    );
  }
}
