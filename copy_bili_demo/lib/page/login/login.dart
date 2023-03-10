import 'package:copy_bili_demo/util/color.dart';

import '../../widget/appbar.dart';
import 'package:flutter/material.dart';
import '../../widget/login_effect.dart';
import '../../widget/login_input.dart';
import '../../http/dao/login_dao.dart';
import 'dart:convert';
import '../../widget/login_button.dart';
import '../../widget/toast.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isProtect = false;
  bool _isEnableLogin = false;
  String _username = "";
  String _password = "";

  @override
  _verifyInput() {
    bool enable = false;
    if (_username != "" && _password != "") {
      enable = true;
    } else {
      enable = false;
    }
    setState(() {
      _isEnableLogin = enable;
    });
  }

  /*****---UI-----***/
  _loginBtn() {
    return LoginButton(
      "登录",
      enable: _isEnableLogin,
      onPressed: () {
        _sendLogin();
      },
    );
  }

  _sendLogin() async {
    try {
      var result = await LoginDao.login(_username, _password);
      var res = json.decode(result);
      if (res["code"] == 200) {
        showToast("登录成功");
        print("登录成功");
        // if (widget.onJumpToLogin != null) {
        //   widget.onJumpToLogin();
        // }
      }
    } catch (error) {
      print(error);
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar("登录", "注册", () {}),
      body: Container(
        child: ListView(
          children: [
            LoginEffect(_isProtect),
            LoginInput(
                title: "用户名",
                hintText: "请输入用户名",
                onChanged: (value) {
                  _username = value;
                  _verifyInput();
                },
                focusChange: (value) {}),
            LoginInput(
                title: "密码",
                hintText: "请输入密码",
                obscureText: true,
                onChanged: (value) {
                  _password = value;
                  _verifyInput();
                },
                focusChange: (value) {
                  this.setState(() {
                    _isProtect = value;
                  });
                }),
            // 登录按钮
            Padding(
              padding: EdgeInsets.only(top: 20, left: 20, right: 20),
              child: _loginBtn(),
            )
          ],
        ),
      ),
    );
  }
}
