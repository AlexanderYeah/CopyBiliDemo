import 'package:copy_bili_demo/http/request/base_request.dart';

class RankingRequest extends BaseRequest {
  @override
  HttpMethod httpMethod() {
    // TODO: implement httpMethod
    return HttpMethod.GET;
  }

  @override
  bool isNeedLogin() {
    // TODO: implement isNeedLogin
    return false;
  }

  @override
  String path() {
    // TODO: implement path
    return "/GwXjH2Pcb2d5a8f8129d761e0215f79b289e468a67d2359/rank";
  }

  @override
  String domain() {
    // TODO: implement domain
    return "mockapi.eolink.com";
  }
}
