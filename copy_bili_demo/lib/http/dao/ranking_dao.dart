import 'dart:convert';

import 'package:copy_bili_demo/http/core/sk_net.dart';
import 'package:copy_bili_demo/http/request/login_request.dart';
import 'package:copy_bili_demo/http/request/ranking_request.dart';

import '../../model/ranking_model.dart';

class RankingDao {
  static get({int pageIndex = 0, int pageSize = 10}) async {
    RankingRequest request = RankingRequest();

    //  这里添加页码 传递参数等操作
    var result = await SKNet.getInstance().fire(request);
    // type ‘String‘ is not a subtype of type ‘int‘ of ‘index‘
    // 使用jsonDecode 即可解决这个报错
    var d_result = jsonDecode(result);
    return RankingModel.fromJson(d_result["data"]);
  }
}
