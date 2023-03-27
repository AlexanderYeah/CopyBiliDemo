import 'package:copy_bili_demo/model/ranking_model.dart';
import 'package:copy_bili_demo/util/color.dart';
import 'package:copy_bili_demo/util/format_util.dart';
import 'package:flutter/material.dart';

class RankingVideoCard extends StatefulWidget {
  final VideoMo videoMo;
  const RankingVideoCard(this.videoMo, {super.key});

  @override
  State<RankingVideoCard> createState() => _RankingVideoCardState();
}

class _RankingVideoCardState extends State<RankingVideoCard> {
  _imageItem() {
    return Container(
      padding: EdgeInsets.only(left: 5),
      width: 160,
      height: 90,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Image.network(
              widget.videoMo.cover!,
              fit: BoxFit.fill,
              width: 160,
              height: 90,
            ),
          ),
          Align(
              alignment: Alignment.bottomRight,
              child: Container(
                color: Colors.black38,
                margin: EdgeInsets.only(right: 6, bottom: 4),
                child: Text(
                  " 10:42 ",
                  style: TextStyle(color: Colors.white, fontSize: 11),
                ),
              ))
        ],
      ),
    );
  }

  _authorInfo() {
    return Row(
      children: [
        Icon(
          Icons.videocam_sharp,
          color: Colors.grey,
        ),
        SizedBox(
          width: 5,
        ),
        Text(
          widget.videoMo.owner!.name!,
          style: TextStyle(color: Colors.grey, fontSize: 12),
        )
      ],
    );
  }

  _iconAndText(IconData icons, String title) {
    return Row(
      children: [
        Icon(
          icons,
          color: Colors.grey,
          size: 15,
        ),
        Padding(
          padding: EdgeInsets.only(left: 5),
          child: Text(
            title,
            style: TextStyle(fontSize: 11),
          ),
        )
      ],
    );
  }

  _bottomItem() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            _iconAndText(
                Icons.ondemand_video, countFormat(widget.videoMo.view!)),
            SizedBox(
              width: 5,
            ),
            _iconAndText(Icons.favorite, countFormat(widget.videoMo.favorite!)),
          ],
        ),
        // 右边的三个点按钮
        Icon(
          Icons.more_vert_sharp,
          size: 15,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 120,
        child: Card(
          margin: EdgeInsets.only(left: 4, right: 4, bottom: 8),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Row(children: [
              // 图片区域
              _imageItem(),
              Container(
                margin: EdgeInsets.only(left: 10),
                width: MediaQuery.of(context).size.width - 160 - 30,
                height: 100,
                child: Column(
                  // 计算文字标题的比例
                  children: [
                    // 标题
                    Expanded(
                        flex: 7,
                        child: Container(
                          child: Text(
                            widget.videoMo.title!,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style:
                                TextStyle(color: Colors.black87, fontSize: 14),
                          ),
                        )),
                    // 作者信息
                    Expanded(
                        flex: 4,
                        child: Container(
                          child: _authorInfo(),
                        )),
                    // 底部播放量信息
                    Expanded(
                        flex: 3,
                        child: Container(
                          color: Colors.white,
                          child: _bottomItem(),
                        ))
                  ],
                ),
              )
              // 右边的文字区域
            ]),
          ),
        ));
  }
}
