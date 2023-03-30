import 'dart:convert';

import 'package:copy_bili_demo/http/request/home_request.dart';
import 'package:copy_bili_demo/model/home_model.dart';
import 'package:sk_net/sk_net.dart';

class HomeDao {
  static get(String categoryName, {int pageIndex = 1, pageSize = 1}) async {
    HomeRequest request = HomeRequest();
    // 拼接类别在后面
    // request.pathParams = categoryName;
    // request.add("pageIndex", pageIndex).add("pageSize", pageSize);
    var result = await SKNet.getInstance().fire(request);
    print(result);
    return HomeModel.fromJson(json.decode(result));
  }
}
