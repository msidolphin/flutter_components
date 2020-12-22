import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_components/list/ListGroup.dart';
import 'package:flutter_components/list/ListItem.dart';
import 'package:flutter_components/widgets.dart';
import 'package:flutter_components_example/view/ButtonView.dart';
import 'package:flutter_components_example/view/ColorView.dart';
import 'package:flutter_components_example/view/DialogView.dart';
import 'package:flutter_components_example/view/EventCalendarView.dart';
import 'package:flutter_components_example/view/ExpandableTextView.dart';
import 'package:flutter_components_example/view/FormView.dart';
import 'package:flutter_components_example/view/ListGroupView.dart';
import 'package:flutter_components_example/view/ModalBottomView.dart';
import 'package:flutter_components_example/view/NoticeBarView.dart';
import 'package:flutter_components_example/view/PickerView.dart';
import 'package:flutter_components_example/view/ResultView.dart';
import 'package:flutter_components_example/view/SlidableView.dart';
import 'package:flutter_components_example/view/TabBarIndicatorView.dart';
import 'package:flutter_components_example/view/TimePickerView.dart';
import 'package:flutter_components_example/view/ToastView.dart';
import 'package:flutter_components_example/view/VerticalTabsView.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';

import 'SegmentView.dart';
import 'SignatureView.dart';

class Sample extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return SampleState();
  }

}

class SampleState extends State<Sample> {

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        child: EasyRefresh.custom(
            slivers: [
              SliverAppBar(
                expandedHeight: 80.0,
                pinned: true,
                backgroundColor: Colors.white,
                elevation: 0,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: false,
                  titlePadding: EdgeInsets.only(left: 15, bottom: 12),
                  title: Text('示例', style: TextStyle(
                    fontSize: 18,
                    color: Colors.black
                  ),),
                ),
              ),
              SliverList(delegate: SliverChildListDelegate.fixed([
                ListGroup(children: [
                    ListItem(title: '色彩',
                      leftPadding: 10,
                      leading: CircularIcon(
                       bgColor: Colors.orange,
                       icon: Icons.color_lens,
                      ),
                      onPressed: () {
                        to(context, ColorView());
                      },
                    ),
                    ListItem(title: '按钮',
                      leftPadding: 10,
                      leading: CircularIcon(
                        bgColor: Theme.of(context).primaryColor,
                        icon: Icons.smart_button,
                      ),
                      onPressed: () {
                        to(context, ButtonView());
                      },
                    ),
                    ListItem(title: '列表',
                      leftPadding: 10,
                      leading: CircularIcon(
                        bgColor: Colors.red,
                        icon: Icons.list,
                      ),
                      onPressed: () {
                        to(context, ListGroupView());
                      },
                    ),
                    ListItem(title: '表单',
                      leftPadding: 10,
                      leading: CircularIcon(
                        bgColor: Colors.green,
                        icon: Icons.format_list_bulleted,
                      ),
                      onPressed: () {
                        to(context, FormView());
                      },
                    ),
                    ListItem(title: '时间选择器',
                      leftPadding: 10,
                      leading: CircularIcon(
                        bgColor: Colors.pink,
                        icon: Icons.date_range,
                      ),
                      onPressed: () {
                        to(context, TimePickerView());
                      },
                    ),
                    ListItem(title: '弹窗',
                      leftPadding: 10,
                      leading: CircularIcon(
                        bgColor: Colors.orange,
                        icon: Icons.message,
                      ),
                      onPressed: () {
                        to(context, DialogView());
                      },
                    ),
                    ListItem(title: '轻提示',
                      leftPadding: 10,
                      leading: CircularIcon(
                        bgColor: Theme.of(context).primaryColor,
                        icon: Icons.privacy_tip,
                      ),
                      onPressed: () {
                        to(context, ToastView());
                      },
                    ),
                    ListItem(title: '底部弹窗',
                      leftPadding: 10,
                      leading: CircularIcon(
                        bgColor: Colors.red,
                        icon: Icons.line_style,
                      ),
                      onPressed: () {
                        to(context, ModalBottomView());
                      },
                    ),
                    ListItem(title: '通告栏',
                      leftPadding: 10,
                      leading: CircularIcon(
                        bgColor: Colors.green,
                        icon: Icons.volume_up,
                      ),
                      onPressed: () {
                        to(context, NoticeBarView());
                      },
                    ),
                    ListItem(title: '滑动操作',
                      leftPadding: 10,
                      leading: CircularIcon(
                        bgColor: Colors.pink,
                        icon: Icons.slideshow_sharp,
                      ),
                      onPressed: () {
                        to(context, SlidableView());
                      },
                    ),
                    ListItem(title: '操作结果',
                      leftPadding: 10,
                      leading: CircularIcon(
                        bgColor: Colors.greenAccent,
                        icon: Icons.done,
                      ),
                      onPressed: () {
                        to(context, ResultView());
                      },
                    ),
                    ListItem(title: '垂直TabBar',
                      leftPadding: 10,
                      leading: CircularIcon(
                        bgColor: Colors.orange,
                        icon: Icons.tab,
                      ),
                      onPressed: () {
                        to(context, VerticalTabsView());
                      },
                    ),
                    ListItem(title: '分段器',
                      leftPadding: 10,
                      leading: CircularIcon(
                        bgColor: Theme.of(context).primaryColor,
                        icon: Icons.segment,
                      ),
                      onPressed: () {
                        to(context, SegmentView());
                      },
                    ),
                    ListItem(title: '可展开文本',
                      leftPadding: 10,
                      leading: CircularIcon(
                        bgColor: Colors.red,
                        icon: Icons.text_format,
                      ),
                      onPressed: () {
                        to(context, ExpandableTextView());
                      },
                    ),
                    ListItem(title: '选择器',
                      leftPadding: 10,
                      leading: CircularIcon(
                        bgColor: Colors.green,
                        icon: Icons.format_line_spacing,
                      ),
                      onPressed: () {
                        to(context, PickerView());
                      },
                    ),
                    ListItem(title: '签名',
                      leftPadding: 10,
                      leading: CircularIcon(
                        bgColor: Colors.pink,
                        icon: Icons.format_paint,
                      ),
                      onPressed: () {
                        to(context, SignatureView());
                      },
                    ),
                    ListItem(title: '日历',
                      leftPadding: 10,
                      leading: CircularIcon(
                        bgColor: Colors.blue,
                        icon: Icons.calendar_today_rounded,
                      ),
                      onPressed: () {
                        to(context, EventCalendarView());
                      },
                    ),
                  ListItem(title: 'TabBar指示器',
                    leftPadding: 10,
                    leading: CircularIcon(
                      bgColor: Colors.red,
                      icon: Icons.tab,
                    ),
                    onPressed: () {
                      to(context, TabBarIndicatorView());
                    },
                  ),
                  ])
              ]))
            ]
        ),
      ),
    );
  }

  void to(BuildContext context, Widget page) {
    Navigator.push(context, MaterialWithModalsPageRoute(
      builder: (BuildContext context) {
        return Material(
          child: page,
        );
      },
    ));
  }


}

class Demo extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        body: Center(
          child: FlatButton(
            child: Text('presss'),
            onPressed: () {
              showCupertinoModalBottomSheet(
                expand: false,
                context: context,
                backgroundColor: Colors.transparent,
                builder: (context, s) => Material(
                    child: SafeArea(
                      top: false,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ListTile(
                            title: Text('Edit'),
                            leading: Icon(Icons.edit),
                            onTap: () => Navigator.of(context).pop(),
                          ),
                          ListTile(
                            title: Text('Copy'),
                            leading: Icon(Icons.content_copy),
                            onTap: () => Navigator.of(context).pop(),
                          ),
                          ListTile(
                            title: Text('Cut'),
                            leading: Icon(Icons.content_cut),
                            onTap: () => Navigator.of(context).pop(),
                          ),
                          ListTile(
                            title: Text('Move'),
                            leading: Icon(Icons.folder_open),
                            onTap: () => Navigator.of(context).pop(),
                          ),
                          ListTile(
                            title: Text('Delete'),
                            leading: Icon(Icons.delete),
                            onTap: () => Navigator.of(context).pop(),
                          )
                        ],
                      ),
                    )),
              );
            },
          ),
        ),
      ),
    );
  }


}


/// 圆形边框Icon
class CircularIcon extends StatelessWidget {
  /// 颜色
  final Color color;

  /// 背景颜色
  final Color bgColor;

  /// Icon
  final IconData icon;

  const CircularIcon({
    Key key,
    this.color = Colors.white,
    this.bgColor = Colors.orange,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
      ),
      child: Center(
        child: icon == null
            ? EmptyIcon()
            : Icon(
          icon,
          size: 15.0,
          color: color,
        ),
      ),
    );
  }
}

class EmptyIcon extends Icon {
  const EmptyIcon() : super(Icons.hourglass_empty);
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}