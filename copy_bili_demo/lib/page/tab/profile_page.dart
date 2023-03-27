import 'package:copy_bili_demo/http/dao/profile_dao.dart';
import 'package:copy_bili_demo/model/profile_model.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  ProfileModel? _profileModel;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  _loadData() async {
    try {
      ProfileModel model = ProfileDao.get();
      print(model);
      setState(() {
        _profileModel = model;
      });
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("我的"),
    );
  }
}
