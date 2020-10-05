import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_components/widgets.dart';

import '../widget/TitleWidget.dart';

class ResultView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        color: Colors.white,
        child: ListView(
          children: <Widget>[
            TitleWidget(title: 'ResultPage 结果页',),
            TitleWidget(title: '操作成功',),
            ResultPage(
              title: "操作成功",
              subtitle: "内容详情可折行，建议不超过两行建议不超过两行建议不超过两行",
            ),
            TitleWidget(title: '等待处理',),
            ResultPage(
              title: "等待处理",
              subtitle: "内容详情可折行，建议不超过两行",
              type: ResultPageType.waited,
            ),
            TitleWidget(title: '无法完成操作',),
            ResultPage(
              title: "无法完成操作",
              subtitle: "内容详情可折行，建议不超过两行",
              type: ResultPageType.error,
            ),
            TitleWidget(title: '警告提示',),
            ResultPage(
              title: "警告提示",
              subtitle: "内容详情可折行，建议不超过两行",
              type: ResultPageType.warning,
            ),
            TitleWidget(title: '信息提示',),
            ResultPage(
              title: "信息提示",
              subtitle: "内容详情可折行，建议不超过两行建议不超过两行建议不超过两行",
              type: ResultPageType.info,
            )
          ],
        ),
      ),
    );
  }

}