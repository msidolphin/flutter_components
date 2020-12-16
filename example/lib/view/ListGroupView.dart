import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_components/list/AbstractListItem.dart';
import 'package:flutter_components/widgets.dart';

import '../widget/TitleWidget.dart';

class CustomListItem extends AbstractListItem {

  final Widget child;

  final double leftPadding;

  CustomListItem({@required this.child, this.leftPadding = 0, });

  @override
  State<StatefulWidget> createState() {
    return CustomListItemState();
  }

}

class CustomListItemState extends State<CustomListItem> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: widget.leftPadding),
      child: Container(
        child: widget.child,
        decoration: BoxDecoration(
          border: widget.isFirst ? null : Border(
            top: Divider.createBorderSide(context, width: 0.4),
          )
        ),
      ),
    );
  }

}

class ListGroupView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        TitleWidget(
          title: "List 列表",
        ),
        ListGroup(
          children: [
            ListItem(
              title: "标题名称",
              onPressed: () {},
            ),
            CustomListItem(child: Container(
              color: Colors.white,
              height: 30,
              alignment: Alignment.center,
              child: Text('自定义容器'),
            )),
            ListItem(
              title: "标题名称",
              titleStyle: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.red
              ),
              trailing: CupertinoSwitch(
                value: false,
                activeColor:ThemeColorUtil.primaryColor(context),
              ),
              onPressed: () {},
            ),
            ListItem(
              title: "标题名称",
              trailing: CupertinoSwitch(
                value: true,
                activeColor:ThemeColorUtil.primaryColor(context),
              ),
              onPressed: () {},
            ),
            ListItem(
              title: "标题名称",
              trailing: ListItemTrailing(
                text: "详细内容",
                textStyle: TextStyle(
                  color: Colors.blue
                ),
                placeholder: "请输入内容",
              ),
            ),
            ListItem(
              title: "标题名称",
              trailing: ListItemTrailing(
                text: "详细内容",
                placeholder: "请输入内容",
              ),
              onPressed: () {},
            ),
            ListItem(
              title: "标题名称",
              trailing: Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xffFF0000)
                ),
              ),
              onPressed: () {},
            ),
            ListItem(
              title: "标题名称",
              trailing: Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    color: Color(0xffdddddd),
                ),
              ),
              onPressed: () {},
            ),

          ],
        ),
        SizedBox(height: 20,),
        ListGroup(
          children: [
            ListItem(
              leading: Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  color: Color(0xffdddddd),
                ),
              ),
              title: "标题名称",
            ),
            ListItem(
              leading: Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  color: Color(0xffdddddd),
                ),
              ),
              title: "手机号",
              trailing: ListItemTrailing(
                 text: "18655256672",
                 placeholder: "请输入手机号",
              ),
              onPressed: () {},
            ),
            ListItem(
              leading: Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  color: Color(0xffdddddd),
                ),
              ),
              title: "标题名称",
              trailing: Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  color: Color(0xffdddddd),
                ),
              ),
              onPressed: () {},
            ),
          ],
        )
      ],
    );
  }

}