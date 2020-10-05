import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_components/widgets.dart';
import 'package:flutter_components_example/widget/TitleWidget.dart';

class ExpandableTextView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: SafeArea(child: ListView(children: [
        TitleWidget(title: 'ExpandableText 可展开文本',),
        Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: ExpandableText('''唐纳德·特朗普（Donald Trump，1946年6月14日- ），出生于美国纽约，祖籍德国巴伐利亚 [1]  ，德裔美国共和党籍政治家、企业家、房地产商人、电视人 [2]  ，第45任美国总统。
特朗普于1968年获得宾夕法尼亚大学沃顿商学院经济学学士学位，随后任职于父亲弗雷德·特朗普的房地产公司。1971年接管公司，从事房地产开发，投资范围逐步延伸至其他多个行业。特朗普于2015年6月以美国共和党人身份宣布参选美国总统，2016年11月9日当选美国第45任总统，2017年1月20日宣誓就职。2019年9月24日，美国国会众议院启动针对特朗普的弹劾调查，12月18日经过全体投票通过两项弹劾条款。2020年2月5日，美国国会参议院否决了两项弹劾条款，弹劾失败 [3-4]  。
自2017年1月上任以来，特朗普政府在减税、强硬贸易政策、加大外交军事布局、放松金融监管方面通过立法、签署行政令、人事任命等多个方面取得了较大进展，其中税改是其前期政绩的最大亮点 [5]  。
2020年8月27日，特朗普在白宫接受共和党总统候选人提名，正式成为2020年美国总统候选人。 [6]  2020年10月2日，特朗普发推宣布，自己和第一夫人梅拉尼娅新冠病毒检测呈阳性，已开始隔离。
''', expandText: '展开', maxLines: 4, collapseText: '收起'),
        )
      ],)),
    );
  }

}