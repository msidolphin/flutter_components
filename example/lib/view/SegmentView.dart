import 'package:flutter/cupertino.dart';
import 'package:flutter_components/utils/ThemeColorUtil.dart';
import 'package:flutter_components/widgets.dart';

import '../widget/TitleWidget.dart';

class SegmentView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SegmentView();
  }

}

class _SegmentView  extends State<SegmentView> {
  int segmentedControlValue1 = 1;
  int segmentedControlValue2 = 2;
  int segmentedControlValue3 = 3;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        TitleWidget(title: "SegmentedControl 分段器",),
        SegmentedControl(
          groupValue: segmentedControlValue1,
          children: {
            1: Text("全部"),
            2: Text("在线"),
          },
          onValueChanged: (v) {
            setState(() {
              segmentedControlValue1 = v;
            });

          },
        ),
        SizedBox(height: 12,),
        SegmentedControl(
          groupValue: segmentedControlValue2,
          children: {
            1: Text("热线",),
            2: Text("全部"),
            3: Text("在线"),
          },
          onValueChanged: (v) {
            setState(() {
              segmentedControlValue2 = v;
            });

          },
        ),
        SizedBox(height: 12,),
        SegmentedControl(
          groupValue: segmentedControlValue3,
          children: {
            1: Text("热线",),
            2: Text("全部"),
            3: Text("在线"),
            4: Text("其他"),
          },
          onValueChanged: (v) {
            setState(() {
              segmentedControlValue3 = v;
            });

          },
        ),
      ],
    );
  }
}