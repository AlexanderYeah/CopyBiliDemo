import 'package:copy_bili_demo/http/dao/profile_dao.dart';
import 'package:copy_bili_demo/model/profile_model.dart';
import 'package:copy_bili_demo/util/view_util.dart';
import 'package:copy_bili_demo/widget/sk_blur.dart';
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
    _loadData();
  }

  _loadData() async {
    try {
      ProfileModel model = await ProfileDao.get();
      print(model);
      setState(() {
        _profileModel = model;
      });
    } catch (error) {
      print(error);
    }
  }

  _buildHeader() {
    if (_profileModel == null) {
      return Container();
    } else {
      return Container(
        alignment: Alignment.bottomLeft,
        padding: EdgeInsets.only(left: 10, bottom: 20),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(23),
              child: cachedImage(_profileModel!.face!, width: 46, height: 46),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              _profileModel!.name!,
              style: TextStyle(fontSize: 15, color: Colors.black54),
            )
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: NestedScrollView(
      headerSliverBuilder: ((context, innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
            // 扩展高度
            expandedHeight: 160,
            // 滚动到顶部 标题是否固定
            pinned: true,
            // 定义滚动空间
            flexibleSpace: FlexibleSpaceBar(
                // 视差滚动
                collapseMode: CollapseMode.parallax,
                titlePadding: EdgeInsets.only(left: 0),
                title: _buildHeader(),
                // 这里使用绝对定位 下面是图片 上面的模糊效果
                background: Stack(
                  children: [
                    Positioned.fill(
                        child: cachedImage(
                            "https://img1.baidu.com/it/u=2221584418,2618750016&fm=253&fmt=auto&app=138&f=JPEG?w=889&h=500")),
                    Positioned.fill(child: SKBlur(sigma: 10))
                  ],
                )),
          )
        ];
      }),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return Text("data");
        },
      ),
    ));
  }
}
