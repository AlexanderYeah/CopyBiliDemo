import 'dart:convert';
import 'package:copy_bili_demo/http/request/profile_request.dart';
import 'package:copy_bili_demo/model/profile_model.dart';
import 'package:sk_net/sk_net.dart';

class ProfileDao {
  static get() async {
    ProfileRequest request = ProfileRequest();
    request.add("uri", "profileInfo");
    var result = await SKNet.getInstance().fire(request);
    var d_result = jsonDecode(result);

    return ProfileModel.fromJson(d_result);
  }
}
