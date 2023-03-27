import 'base_request.dart';

class RegisterRequest extends BaseRequest {
  @override
  HttpMethod httpMethod() {
    // TODO: implement httpMethod
    return HttpMethod.POST;
  }

  @override
  bool isNeedLogin() {
    // TODO: implement isNeedLogin
    return false;
  }

  @override
  String path() {
    // TODO: implement path
    return "user/register";
  }

  @override
  String domain() {
    // TODO: implement domain
    return "mockapi.eolink.com";
  }
}
