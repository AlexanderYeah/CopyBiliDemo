import 'package:copy_bili_demo/model/profile_model.dart';
import 'package:copy_bili_demo/util/view_util.dart';
import 'package:copy_bili_demo/widget/sk_blur.dart';
import 'package:flutter/material.dart';

class BenefitCard extends StatelessWidget {
  const BenefitCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10),
      child: Column(
        children: [_buildTitle(), ..._buildBenifit(context)],
      ),
    );
  }

  _buildBenifit(context) {
    //计算每个卡片的宽度 默认为3个卡片
    var width = (MediaQuery.of(context).size.width - 20 - 15) / 3;
    return [
      Row(
        children: [
          _benefitItem("交流群", width),
          _benefitItem("问答区", width),
          _benefitItem("电子书", width),
        ],
      )
    ];
  }

  //
  _benefitItem(title, width) {
    return Padding(
      padding: EdgeInsets.only(right: 5, bottom: 7),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Container(
          alignment: Alignment.center,
          width: width,
          height: 60,
          decoration: BoxDecoration(
            color: Colors.deepOrangeAccent,
          ),
          child: Stack(
            children: [
              Positioned.fill(
                  child: SKBlur(
                sigma: 20,
              )),
              Positioned.fill(
                  child: Center(
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                ),
              )),
            ],
          ),
        ),
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
            "增值服务",
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
}
