import 'package:copy_bili_demo/model/home_model.dart';
import 'package:copy_bili_demo/model/video_model.dart';
import 'package:copy_bili_demo/navigator/sk_navigator.dart';
import 'package:copy_bili_demo/util/view_util.dart';
import 'package:flutter/material.dart';
import 'package:sk_base/format_util.dart';
import 'package:transparent_image/transparent_image.dart';

class VideoCard extends StatelessWidget {
  final VideoList videoMo;
  const VideoCard({super.key, required this.videoMo});

  // 底部的标题等信息
  _infoText() {
    // 占满整个区域
    return Expanded(
        child: Container(
      padding: EdgeInsets.only(top: 5, left: 8, right: 8, bottom: 5),
      child: Column(
        children: [
          Text(
            videoMo.title!,
            style: TextStyle(fontSize: 13),
            maxLines: 2,
          ),
          _owner(),
        ],
      ),
    ));
  }

  // up 主的区域
  _owner() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      // 左边是图标 右边是昵称
      children: [
        Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(9),
              child: Image.asset(
                "images/avatar.png",
                fit: BoxFit.cover,
                width: 18,
                height: 18,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 5),
              child: Text(
                videoMo.owner!.name!,
                style: TextStyle(fontSize: 11),
              ),
            )
          ],
        ),
        // 右边的按钮
        Icon(
          Icons.more_vert_sharp,
          size: 15,
        )
      ],
    );
  }

  // 抽离的图片区域的图标加文字
  _iconTextWidget(IconData? icondata, int count) {
    String views = "";
    if (icondata != null) {
      views = countFormat(count);
    } else {
      views = durationTransform(videoMo.duration!);
    }
    return Row(
      children: [
        if (icondata != null)
          Icon(
            icondata,
            color: Colors.white,
            size: 12,
          ),
        Padding(
          padding: EdgeInsets.only(left: 4),
          child: Text(
            views,
            style: TextStyle(color: Colors.white, fontSize: 11),
          ),
        )
      ],
    );
  }

  // 图片区域相关的信息
  _itemImage(context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        cachedImage(videoMo.cover!, width: size.width / 2 - 10, height: 120),
        // 淡入淡出的效果
        // FadeInImage.memoryNetwork(
        //   height: 120,
        //   placeholder: kTransparentImage,
        //   image: videoMo.cover!,
        //   fit: BoxFit.cover,
        // ),
        // 图片上浮动的文字
        // 这个部分的内容 整条 居在下面 左右填满
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Container(
            padding: EdgeInsets.only(left: 8, right: 8, bottom: 3, top: 5),
            // 渐变颜色条条 有个黑色的阴影 衬托出白色的文字
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [Colors.black54, Colors.transparent])),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // 左边浏览数
                _iconTextWidget(Icons.ondemand_video, videoMo.view!),
                // 中间喜欢的人数
                _iconTextWidget(Icons.favorite, videoMo.favorite!),
                // 右边时长显示
                _iconTextWidget(null, videoMo.duration!),
              ],
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          // SKNavigator.getIntance()
          //     .onJumpTo(RouteStatus.detail, args: {"videoMo": videoMo});
        },
        child: SizedBox(
          height: 300,
          child: Card(
              // 取消卡片的默认边距
              margin: EdgeInsets.only(left: 4, right: 4, bottom: 8),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 图片区域的显示
                    _itemImage(context),
                    // 底部的标题区域
                    _infoText()
                  ],
                ),
              )),
        ));
  }
}
