import '/http/request/base_request.dart';

import 'sk_net_adapter.dart';

class MockAdapter extends SKNetAdapter {
  @override
  Future<SKNetResponse<T>> send<T>(BaseRequest request) {
    // TODO: implement send
    return Future<SKNetResponse<T>>.delayed(Duration(seconds: 1), () {
      return SKNetResponse(
          data: {"code": 401, "message": "success"}, statusCode: 401);
    });
  }
}
