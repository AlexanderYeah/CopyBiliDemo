import 'package:copy_bili_demo/model/profile_model.dart';
import 'package:copy_bili_demo/util/view_util.dart';
import 'package:flutter/material.dart';

class CourseCard extends StatelessWidget {
  final List<CourseMo> courseList;
  const CourseCard({super.key, required this.courseList});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [_buildTitle(), ..._buildCardList(context)],
      ),
    );
  }

  // 标题
  _buildTitle() {
    return Container(
      margin: EdgeInsets.only(left: 12, top: 10, bottom: 10),
      child: Row(
        children: [
          Text(
            "职场进阶",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            "带你突破技术瓶颈",
            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  // 动态布局
  _buildCardList(BuildContext context) {
    /**
     *   [
     *  {
            "name": "移动端架构师",
            "cover": "https://o.devio.org/images/fa/banner/mobilearchitect.png",
            "url": "https://class.imooc.com/sale/mobilearchitect",
            "group": 1
        },
        ]
    */
    var courseGroup = Map();
    // 将课程进行分组
    courseList.forEach((element) {
      // 如果分组中不包含这个类别的组 那就去创建
      if (!courseGroup.containsKey(element.group)) {
        courseGroup[element.group] = [];
      }
      List list = courseGroup[element.group];
      list.add(element);
    });
    // 计算数量
    return courseGroup.entries.map((e) {
      List list = e.value;
      // 根据卡片数量计算出每个卡片的宽度
      // 20 为左右的边距 5 为卡片之间的边距
      var width =
          (MediaQuery.of(context).size.width - 20 - (list.length - 1) * 5) /
              list.length;

      var height = width / 16 * 8;
      // 这里可以根据item的数量去返回不同的高度
      if (list.length == 1) {
        height = width / 16 * 5;
      }
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ...list.map((mo) => _buildCardItem(mo, width, height)).toSet()
        ],
      );
    });
  }

  _buildCardItem(CourseMo mo, width, height) {
    return InkWell(
      onTap: () {
        print("点击事件");
      },
      child: Padding(
        padding: EdgeInsets.only(right: 5, bottom: 12),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: cachedImage(mo.cover!, width: width, height: height),
        ),
      ),
    );
  }
}
