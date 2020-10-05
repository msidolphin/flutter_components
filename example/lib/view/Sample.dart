import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_components/list/ListGroup.dart';
import 'package:flutter_components/list/ListItem.dart';
import 'package:flutter_components_example/view/ButtonView.dart';
import 'package:flutter_components_example/view/ColorView.dart';
import 'package:flutter_components_example/view/DialogView.dart';
import 'package:flutter_components_example/view/FormView.dart';
import 'package:flutter_components_example/view/ListGroupView.dart';
import 'package:flutter_components_example/view/ModalBottomView.dart';
import 'package:flutter_components_example/view/NoticeBarView.dart';
import 'package:flutter_components_example/view/ResultView.dart';
import 'package:flutter_components_example/view/SlidableView.dart';
import 'package:flutter_components_example/view/TimePickerView.dart';
import 'package:flutter_components_example/view/ToastView.dart';
import 'package:flutter_components_example/view/VerticalTabsView.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

import 'SegmentView.dart';

class Sample extends StatelessWidget {

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
                flexibleSpace: FlexibleSpaceBar(
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
                      padding: 10,
                      leading: CircularIcon(
                       bgColor: Colors.orange,
                       icon: Icons.color_lens,
                      ),
                      onPressed: () {
                        to(context, ColorView());
                      },
                    ),
                    ListItem(title: '按钮',
                      padding: 10,
                      leading: CircularIcon(
                        bgColor: Theme.of(context).primaryColor,
                        icon: Icons.smart_button,
                      ),
                      onPressed: () {
                        to(context, ButtonView());
                      },
                    ),
                    ListItem(title: '列表',
                      padding: 10,
                      leading: CircularIcon(
                        bgColor: Colors.red,
                        icon: Icons.list,
                      ),
                      onPressed: () {
                        to(context, ListGroupView());
                      },
                    ),
                    ListItem(title: '表单',
                      padding: 10,
                      leading: CircularIcon(
                        bgColor: Colors.green,
                        icon: Icons.format_list_bulleted,
                      ),
                      onPressed: () {
                        to(context, FormView());
                      },
                    ),
                    ListItem(title: '时间选择器',
                      padding: 10,
                      leading: CircularIcon(
                        bgColor: Colors.pink,
                        icon: Icons.date_range,
                      ),
                      onPressed: () {
                        to(context, TimePickerView());
                      },
                    ),
                    ListItem(title: '弹窗',
                      padding: 10,
                      leading: CircularIcon(
                        bgColor: Colors.orange,
                        icon: Icons.message,
                      ),
                      onPressed: () {
                        to(context, DialogView());
                      },
                    ),
                    ListItem(title: '轻提示',
                      padding: 10,
                      leading: CircularIcon(
                        bgColor: Theme.of(context).primaryColor,
                        icon: Icons.privacy_tip,
                      ),
                      onPressed: () {
                        to(context, ToastView());
                      },
                    ),
                    ListItem(title: '底部弹窗',
                      padding: 10,
                      leading: CircularIcon(
                        bgColor: Colors.red,
                        icon: Icons.line_style,
                      ),
                      onPressed: () {
                        to(context, ModalBottomView());
                      },
                    ),
                    ListItem(title: '通告栏',
                      padding: 10,
                      leading: CircularIcon(
                        bgColor: Colors.green,
                        icon: Icons.volume_up,
                      ),
                      onPressed: () {
                        to(context, NoticeBarView());
                      },
                    ),
                    ListItem(title: '滑动操作',
                      padding: 10,
                      leading: CircularIcon(
                        bgColor: Colors.pink,
                        icon: Icons.slideshow_sharp,
                      ),
                      onPressed: () {
                        to(context, SlidableView());
                      },
                    ),
                    ListItem(title: '操作结果',
                      padding: 10,
                      leading: CircularIcon(
                        bgColor: Colors.greenAccent,
                        icon: Icons.done,
                      ),
                      onPressed: () {
                        to(context, ResultView());
                      },
                    ),
                    ListItem(title: '垂直TabBar',
                      padding: 10,
                      leading: CircularIcon(
                        bgColor: Colors.orange,
                        icon: Icons.tab,
                      ),
                      onPressed: () {
                        to(context, VerticalTabsView());
                      },
                    ),
                    ListItem(title: '分段器',
                      padding: 10,
                      leading: CircularIcon(
                        bgColor: Theme.of(context).primaryColor,
                        icon: Icons.segment,
                      ),
                      onPressed: () {
                        to(context, SegmentView());
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
    Navigator.push(context, MaterialPageRoute(
      builder: (BuildContext context) {
        return Material(
          child: page,
        );
      },
    ));
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