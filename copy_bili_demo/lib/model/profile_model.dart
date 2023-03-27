class ProfileModel {
  String? name;
  String? face;
  int? fans;
  int? favorite;
  int? like;
  int? coin;
  int? browsing;
  List<BannerMo>? bannerList;
  List<CourseMo>? courselist;

  ProfileModel(
      {this.name,
      this.face,
      this.fans,
      this.favorite,
      this.like,
      this.coin,
      this.browsing,
      this.bannerList,
      this.courselist});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    face = json['face'];
    fans = json['fans'];
    favorite = json['favorite'];
    like = json['like'];
    coin = json['coin'];
    browsing = json['browsing'];
    if (json['bannerList'] != null) {
      bannerList = <BannerMo>[];
      json['bannerList'].forEach((v) {
        bannerList!.add(new BannerMo.fromJson(v));
      });
    }
    if (json['courselist'] != null) {
      courselist = <CourseMo>[];
      json['courselist'].forEach((v) {
        courselist!.add(new CourseMo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['face'] = this.face;
    data['fans'] = this.fans;
    data['favorite'] = this.favorite;
    data['like'] = this.like;
    data['coin'] = this.coin;
    data['browsing'] = this.browsing;
    if (this.bannerList != null) {
      data['bannerList'] = this.bannerList!.map((v) => v.toJson()).toList();
    }
    if (this.courselist != null) {
      data['courselist'] = this.courselist!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BannerMo {
  String? id;
  int? sticky;
  String? type;
  String? title;
  String? subtitle;
  String? url;
  String? cover;
  String? createlime;
  String? createTime;

  BannerMo(
      {this.id,
      this.sticky,
      this.type,
      this.title,
      this.subtitle,
      this.url,
      this.cover,
      this.createlime,
      this.createTime});

  BannerMo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sticky = json['sticky'];
    type = json['type'];
    title = json['title'];
    subtitle = json['subtitle'];
    url = json['url'];
    cover = json['cover'];
    createlime = json['createlime'];
    createTime = json['createTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sticky'] = this.sticky;
    data['type'] = this.type;
    data['title'] = this.title;
    data['subtitle'] = this.subtitle;
    data['url'] = this.url;
    data['cover'] = this.cover;
    data['createlime'] = this.createlime;
    data['createTime'] = this.createTime;
    return data;
  }
}

class CourseMo {
  String? name;
  String? cover;
  String? url;
  int? group;

  CourseMo({this.name, this.cover, this.url, this.group});

  CourseMo.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    cover = json['cover'];
    url = json['url'];
    group = json['group'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['cover'] = this.cover;
    data['url'] = this.url;
    data['group'] = this.group;
    return data;
  }
}
