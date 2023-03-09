// 这个是请求工具类
import 'sk_error.dart';

import '../request/base_request.dart';
import 'sk_net_adapter.dart';
import 'mock_adaper.dart';
import 'dio_adapter.dart';

class SKNet {
  SKNet._();
  // 使用单例模式
  static SKNet? _instance;
  static getInstance() {
    if (_instance == null) {
      _instance = SKNet._();
    }

    return _instance;
  }

  //  发送请求的方法
  Future fire(BaseRequest request) async {
    SKNetResponse? response;
    var error;

    try {
      response = await send(request);
    } on SKNetError catch (e) {
      error = e;
      response = e.data;
      printLog(e.message);
    } catch (e) {
      error = e;
      printLog(e);
    }
    // 判断response是否为空
    if (response == null) {
      printLog(error);
    }
    var result = response!.data;
    // 解析状态吗
    int? status = response.statusCode;

    switch (status) {
      case 200:
        // 正常
        return result;
        break;
      case 401:
        // 需要登录
        throw NeedLogin();
        break;
      case 403:
        // 需要鉴权
        throw NeedAuth(result.toString(), data: result);
        break;
      default:
        // 默认抛出基础的异常
        throw SKNetError(status!, result.toString(), data: result);
    }
  }

  Future<dynamic> send<T>(BaseRequest request) async {
    printLog(request.url());
    printLog(request.header);
    printLog(request.httpMethod());
    printLog(request.params);

    SKNetAdapter adapter = DioAdapter();
    return adapter.send(request);
  }

  // 创建一个打印参数的方法

  printLog(value) {
    print("SKNet--${value}");
  }
}
