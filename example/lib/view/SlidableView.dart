import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_components/utils/Gaps.dart';


import 'package:flutter_components/widgets.dart';
import '../widget/TitleWidget.dart';

class SlidableView extends StatefulWidget {


  @override
  State<StatefulWidget> createState() {
    return SlidableViewState();
  }


}

class SlidableViewState extends State<SlidableView> {

  List list = [{
    "name": "贤哥",
    "phone": "185****1234",
    "address": "广东省珠海市高新区南方软家园",
    "isDefault": true
  },{
    "name": "小易",
    "phone": "185****6666",
    "address": "广东省珠海市高新区南方软家园一街六栋212",
    "isDefault": false
  },{
    "name": "张三",
    "phone": "185****1234",
    "address": "广东省珠海市高新区南方软家园",
    "isDefault": false
  }];

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TitleWidget(title: "SlidableView 侧滑操作栏" ),
          Expanded(
            child: ListView.builder(itemBuilder: (ctx, index) {
              Map item = list[index];
              return Slidable(
                key: Key(item['name']),
                actionPane: SlidableDrawerActionPane(),
                actionExtentRatio: 0.2,
                dismissal: SlidableDismissal(
                  child: SlidableDrawerDismissal(),
                  closeOnCanceled:true,
                  onWillDismiss: (actionType) async {
                    return Ui.showConfirmDialog(context, message: '确认删除该条记录吗？',
                      onConfirm: () {
                        Navigator.of(context).pop(true);
                      }
                    );
                  },
                  onDismissed: (actionType) {
                    print(actionType);
                    setState(() {
                      list.removeAt(index);
                    });
                  },
                ),
                child: Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(12),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Text(item['name'], style: TextStyle(
                                    color: ThemeColorUtil.titleTextColor(context),
                                    fontSize: 15
                                ),),
                                SizedBox(width: 10,),
                                Text(item['phone'], style: TextStyle(
                                    color: ThemeColorUtil.titleTextColor(context),
                                    fontSize: 15
                                ),),
                                SizedBox(width: 8,),
                                item['isDefault'] ? Container(
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                      color: ThemeColorUtil.primaryColor(context),
                                      borderRadius: BorderRadius.circular(2)
                                  ),
                                  child: Text("默认",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 11,
                                        height: 1
                                    ),
                                  ),
                                ) : Gaps.empty
                              ],
                            ),
                            Text(item['address'], style: TextStyle(
                                color: ThemeColorUtil.subTitleTextColor(context),
                                fontSize: 13
                            ),),
                          ],
                        ),
                      ),
                      SvgPicture.string(IconsSvgLib.EDIT, width: 16, height: 16,),
                    ],
                  ),
                ),
                secondaryActions: <Widget>[
                  SlideAction(
                    color: Color(0xffCCCCCC),
                    child: Container(
                      child: Text("设置默认", style: TextStyle(
                          fontSize: 13,
                          color: Color(0xffffffff)
                      ),),
                    ),
                    onTap: () {
                      Toast.show("设置默认成功");
                    },
                  ),
                  SlideAction(
                    color: Color(0xffFF3B30),
                    child: Container(
                      child: Text("删除", style: TextStyle(
                          fontSize: 13,
                          color: Color(0xffffffff)
                      ),),
                    ),
                    onTap: () {
                      Toast.show("删除成功");
                      list.removeAt(index);
                      setState(() {

                      });
                    },
                  ),
                ],
              );
            }, itemCount: list.length,),
          )
        ],
      ),
    );

  }

}
