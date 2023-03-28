import 'package:copy_bili_demo/http/dao/profile_dao.dart';
import 'package:copy_bili_demo/model/home_model.dart';
import 'package:copy_bili_demo/model/profile_model.dart';
import 'package:copy_bili_demo/util/format_util.dart';
import 'package:copy_bili_demo/util/view_util.dart';
import 'package:copy_bili_demo/widget/benifit_card.dart';
import 'package:copy_bili_demo/widget/course_card.dart';
import 'package:copy_bili_demo/widget/sk_banner.dart';
import 'package:copy_bili_demo/widget/sk_blur.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with AutomaticKeepAliveClientMixin {
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
        padding: EdgeInsets.only(left: 10, bottom: 30),
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
                          Positioned.fill(child: SKBlur(sigma: 10)),
                          // 用户粉丝数等信息
                          Positioned(
                            bottom: 0,
                            right: 0,
                            left: 0,
                            child: _buildProfileInfo(),
                          ),
                        ],
                      )),
                )
              ];
            }),
            body: ListView(
              padding: EdgeInsets.only(top: 10),
              children: _buildContentList(),
            )));
  }

// 用户信息
  _buildProfileInfo() {
    if (_profileModel == null) return Text("");
    return Container(
      padding: EdgeInsets.only(left: 0, right: 0, top: 3, bottom: 2),
      color: Colors.white54,
      child: Row(
        // 两侧空间是间隔空间的一半
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _profileInfoItem("收藏", _profileModel!.favorite!),
          _profileInfoItem("点赞", _profileModel!.like!),
          _profileInfoItem("浏览", _profileModel!.browsing!),
          _profileInfoItem("金币", _profileModel!.coin!),
          _profileInfoItem("粉丝", _profileModel!.fans!)
        ],
      ),
    );
  }

  _profileInfoItem(String title, int count) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          countFormat(count),
          style: TextStyle(fontSize: 15, color: Colors.black87),
        ),
        Text(
          title,
          style: TextStyle(fontSize: 12, color: Colors.grey[600]),
        )
      ],
    );
  }

  _buildContentList() {
    if (_profileModel == null) return <Widget>[Text("")];
    return <Widget>[
      _buildBanner(),
      SizedBox(
        height: 10,
      ),
      CourseCard(courseList: _profileModel!.courselist!),
      SizedBox(
        height: 2,
      ),
      BenefitCard(),
    ];
  }

  _buildBanner() {
    List<BannerList> _bannerList = [];
    _profileModel!.bannerList!.forEach((element) {
      _bannerList.add(BannerList.fromJson(element.toJson()));
    });
    print(_bannerList);
    return SKBanner(
      bannerList: _bannerList,
      bannerHeight: 120,
      padding: EdgeInsets.only(left: 10, right: 10),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
