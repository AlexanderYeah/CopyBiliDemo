import 'dart:convert';

import 'package:copy_bili_demo/http/dao/login_dao.dart';
import 'package:copy_bili_demo/navigator/sk_navigator.dart';
import 'package:copy_bili_demo/util/string_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../widget/login_input.dart';
import '../../widget/appbar.dart';
import '../../widget/login_effect.dart';
import '../../widget/login_button.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _isProtect = false;
  bool _isEnableLogin = false;
  String _username = "";
  String _password = "";
  String _rePassword = "";

  /*****---Data Handle-----***/
  //检查输入是否合格 设置登录按钮可以点击
  _verifyInput() {
    bool enable = false;
    if (_username != "" && _password != "" && _rePassword != "") {
      enable = true;
    } else {
      enable = false;
    }
    setState(() {
      _isEnableLogin = enable;
    });
  }

  _verifyParams() {
    String? tips;
    if (_password != _rePassword) {
      tips = "两次输入密码不一致";
    }

    if (tips != null) {
      print(tips);
      return;
    }

    _sendLogin();
  }

  _sendLogin() async {
    try {
      var result = await LoginDao.login(_username, _password);
      var res = json.decode(result);
      if (res["code"] == 200) {
        SKNavigator.getIntance().onJumpTo(RouteStatus.home);
      }
    } catch (error) {
      print(error);
    }
  }

  /*****---UI-----***/
  _loginBtn() {
    return LoginButton(
      "注册",
      enable: _isEnableLogin,
      onPressed: () {
        if (_isEnableLogin) {
          _verifyParams();
        } else {
          print("输入错误,不可登陆");
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar("注册", "登录", () {
        SKNavigator.getIntance().onJumpTo(RouteStatus.login);
      }),
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
            LoginInput(
                title: "确认密码",
                hintText: "请再次输入密码",
                obscureText: true,
                onChanged: (value) {
                  _rePassword = value;
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
