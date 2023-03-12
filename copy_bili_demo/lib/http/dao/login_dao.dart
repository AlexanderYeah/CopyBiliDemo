import 'dart:convert';

import '../../db/sk_cache.dart';

import '/http/core/sk_net.dart';
import 'package:copy_bili_demo/http/request/base_request.dart';

import '../request/login_request.dart';
import '../request/register_request.dart';

class LoginDao {
  // 获取本地的access_token 从而得知用户是否登录
  static isUserLogin() {
    if (SKCache.getInstance().get("access_token") != null) {
      return true;
    } else {
      return false;
    }
  }

  //  登录方法
  static login(String username, String password) {
    return _send(username, password);
  }

  // 注册方法
  static register(String username, String password, String verifyCode) {
    return _send(username, password, verifyCode: verifyCode);
  }

  static _send(String username, String password, {verifyCode}) async {
    BaseRequest request;
    // 证明是注册
    if (verifyCode != null) {
      request = RegisterRequest();
      request
          .add("username", username)
          .add("password", password)
          .add("verifyCode", verifyCode);
    } else {
      request = LoginRequest();
      request.add("username", username).add("password", password);
    }

    // 发送请求 回调结果
    var result = await SKNet.getInstance().fire(request);

    return result;
  }
}
