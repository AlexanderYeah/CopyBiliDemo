// 派生出子类

// 需要登录的的异常
class NeedLogin extends SKNetError {
  NeedLogin({int code = 401, String message = "请先登录"}) : super(code, message);
}

// 需要授权的异常
class NeedAuth extends SKNetError {
  NeedAuth(String message, {int code = 403, dynamic data})
      : super(code, message, data: data);
}

// 网络异常统一格式

class SKNetError implements Exception {
  // final是在运行的时候才赋值
  final int code;
  final String message;
  final dynamic data;
  SKNetError(this.code, this.message, {this.data});
}
