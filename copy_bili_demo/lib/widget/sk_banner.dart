import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class SKBanner extends StatelessWidget {
  final List bannerList;
  final double bannerHeight;
  final EdgeInsetsGeometry? padding;

  const SKBanner(
      {super.key,
      required this.bannerList,
      this.bannerHeight = 160,
      this.padding});
  _imageItem(item) {
    return InkWell(
        onTap: () {
          print(item.title);
          _handleClick(item);
        },
        child: Container(
          padding: padding,
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(6)),
            child: Image.network(item.cover, fit: BoxFit.fill),
          ),
        ));
  }

  _banner() {
    return Swiper(
      itemCount: bannerList.length,
      autoplay: true,
      pagination: SwiperPagination(
          alignment: Alignment.bottomRight,
          margin: EdgeInsets.only(right: 8, bottom: 10),
          builder: DotSwiperPaginationBuilder(
            color: Colors.white60,
            size: 6,
            activeSize: 9,
          )),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            print("click");
            _handleClick(bannerList[index]);
          },
          child: _imageItem(bannerList[index]),
        );
      },
    );
  }

  _handleClick(item) {
    if (item.type == 'video') {
      // 跳转详情界面
    } else {
      // to do
      print(item.url);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: bannerHeight,
      child: _banner(),
    );
  }
}
