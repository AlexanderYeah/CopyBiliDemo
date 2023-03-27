import 'package:copy_bili_demo/core/sk_base_tab_state.dart';
import 'package:copy_bili_demo/http/dao/ranking_dao.dart';
import 'package:copy_bili_demo/model/ranking_model.dart';
import 'package:flutter/material.dart';

import '../../widget/ranking_video_card.dart';

class RankingTabPage extends StatefulWidget {
  const RankingTabPage({super.key});

  @override
  State<RankingTabPage> createState() => _RankingTabPageState();
}

class _RankingTabPageState
    extends SKBaseTabState<RankingModel, VideoMo, RankingTabPage> {
  @override
  // TODO: implement contentChild
  get contentChild => Container(
        child: ListView.builder(
            // 滚动 防止只有一条数据的时候 滑不动
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.only(top: 10),
            itemCount: dataList.length,
            controller: scrollController,
            itemBuilder: (context, index) {
              return RankingVideoCard(dataList[index]);
            }),
      );

  @override
  Future<RankingModel> getData(int pageIdx) async {
    // TODO: implement getData
    RankingModel model = await RankingDao.get();
    return model;
  }

  @override
  List<VideoMo> parseList(RankingModel result) {
    // TODO: implement parseList
    return result.list!;
  }
}
