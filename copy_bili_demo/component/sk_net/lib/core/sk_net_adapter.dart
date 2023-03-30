import 'dart:convert';
import '../request/base_request.dart';

abstract class SKNetAdapter {
  // 发送请求的方法
  Future<SKNetResponse<T>> send<T>(BaseRequest request);
}

class SKNetResponse<T> {
  Object? data;
  BaseRequest? request;
  int? statusCode;
  String? statusMessage;
  dynamic extra;

  SKNetResponse(
      {this.data,
      this.request,
      this.statusCode,
      this.statusMessage,
      this.extra});

  @override
  String toString() {
    if (data is Map) {
      return json.encode(data);
    }
    // TODO: implement toString
    return super.toString();
  }
}
