import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_components/tabbar/PercentTabIndicator.dart';
import '../widget/TitleWidget.dart';

class TabBarIndicatorView extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return TabBarViewState();
  }

}

class TabBarViewState extends State<TabBarIndicatorView> {

  @override
  void initState() {
    super.initState();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        TitleWidget(title: "TabBar Indicator" ),
        TitleWidget(title: "选择到日" ),
        DefaultTabController(
          length: 3,
          child: Container(
            height: 300,
            child: Column(
              children: [
                TabBar(
                  labelColor: Colors.black,
                  indicator: PercentTabIndicator(
                    percent: 0.5,
                    borderSide: const BorderSide(width: 4.0, color: Colors.blue),
                    strokeCap: StrokeCap.round
                  ),
                  indicatorSize: TabBarIndicatorSize.label,
                  tabs: [
                    Tab(text: '主页',),
                    Tab(text: '帖子',),
                    Tab(text: '动态',)
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      Container(color: Colors.red,),
                      Container(color: Colors.green,),
                      Container(color: Colors.blue,),
                    ],
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
