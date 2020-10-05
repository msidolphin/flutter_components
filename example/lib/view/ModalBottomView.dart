import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_components/widgets.dart';
import '../widget/TitleWidget.dart';

class _Item extends ICheckListItem {

  final String id;
  final String label;

  _Item({this.id, this.label});

  @override
  getId() {
    return id;
  }

  @override
  String getLabel() {
    return label;
  }

  @override
  bool isDisabled() {
    return false;
  }

}

class ModalBottomView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(

      child: ListView(
        children: <Widget>[
          TitleWidget(
            title: "showModalBottom 底部弹窗"
          ),
          Button("底部弹窗",
            margin: const EdgeInsets.symmetric(horizontal: 15),
            onPressed: () {
            Ui.showModalBottomSheet(context, builder: (context, scrollController) {
              return Material(
                child: Container(
                  color: Colors.white,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Column(
                          children: <Widget>[
                            Stack(
                              children: <Widget>[
                                Container(
                                  alignment: Alignment.center,
                                  height: 48,
                                  child: Text("标题", style: TextStyle(
                                      color: ThemeColorUtil.titleTextColor(context),
                                      fontSize: 15
                                  ),),
                                ),
                                Positioned(
                                  top: 16,
                                  right: 0,
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: SvgPicture.string(IconsSvgLib.CLOSE, width: 16, height: 16,),
                                  ),
                                )
                              ],
                            ),
                            Text(
                              "描述文案描述文案描述文案描述文案描述文案描述文案描述文案描述文案描述文案。",
                              style: TextStyle(
                                  color: ThemeColorUtil.titleTextColor(context),
                                  fontSize: 15
                              ),
                            ),
                            SizedBox(height: 25,),
                            Text(
                              "请选择取消订单的原因（必选）：",
                              style: TextStyle(
                                color: ThemeColorUtil.titleTextColor(context),
                                fontSize: 15,
                              ),
                            ),
                            SizedBox(height: 4,),
                          ],
                        ),
                      ),

                      RadioList(
                        options: [
                           _Item(id: '0', label: '配送信息有误'),
                           _Item(id: '1', label: '发票信息有误'),
                           _Item(id: '2', label: '商品买错了'),
                           _Item(id: '3', label: '重复下单/误下单'),
                           _Item(id: '4', label: '其他原因')
                        ],
                        value: "4",
                        selectedIcon: Icon(Icons.check_circle, color: ThemeColorUtil.primaryTextColor(context), size: 16),
                        unSelectedIcon: Icon(Icons.check_circle_outline, color: ThemeColorUtil.dividerColor(context), size: 16),
                      ),
                      SizedBox(height: 12,),
                      Button("确定",
                        margin: EdgeInsets.symmetric(horizontal: 12),
                        size: ButtonSize.small,),
                      SizedBox(height: 8,)
                    ],
                  )
                ),
              );
            } );
          },)
        ],
      ),
    );
  }

}