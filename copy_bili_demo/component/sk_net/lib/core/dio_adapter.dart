import 'dart:convert';

import 'sk_error.dart';
import 'sk_net_adapter.dart';
import '../request/base_request.dart';
import 'package:dio/dio.dart';

class DioAdapter extends SKNetAdapter {
  // 构建我们自定义的网络请求返回类
  SKNetResponse buildRes(Response response, BaseRequest request) {
    return SKNetResponse(
        statusCode: response.statusCode,
        request: request,
        statusMessage: response.statusMessage,
        data: response.data,
        extra: response);
  }

  Future<SKNetResponse<T>> send<T>(BaseRequest request) async {
    var response;
    var options = Options(headers: request.header);
    var error;
    try {
      if (request.httpMethod() == HttpMethod.GET) {
        response = await Dio().get(request.url(), options: options);
      } else if (request.httpMethod() == HttpMethod.POST) {
        response = await Dio().post(request.url(), options: options);
      } else if (request.httpMethod() == HttpMethod.DELETE) {
        response = await Dio().delete(request.url(), options: options);
      }
    } on DioError catch (e) {
      error = e;
      response = e.response;
    }
    if (error != null) {
      // 抛出异常
      throw SKNetError(response?.statusCode ?? -1, error.toString(),
          data: buildRes(response, request));
    }
    return SKNetResponse(
        statusCode: response.statusCode,
        request: request,
        statusMessage: response.statusMessage,
        data: response.data,
        extra: response);
  }
}
