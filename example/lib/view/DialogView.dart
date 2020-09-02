import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_components/toast/toast.dart';
import 'package:flutter_components/widgets.dart';

import '../widget/TitleWidget.dart';

class DialogView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListView(
        children: <Widget>[
          TitleWidget(
            title: '确认对话框',
          ),
          Button('确认框', margin: EdgeInsets.symmetric(horizontal: 15), onPressed: () async {
            final result = await Ui.showConfirmDialog(
                context,
                message: '无标题的提示弹窗，仅适用于：一两行内容。',
                onConfirm: () {
                  Navigator.of(context).pop(true);
                }
            );
            if (result == null) Ui.showSnackBar(context, text: '点击了遮罩层');
            else {
              Ui.showSnackBar(context, text: result ? '点击了确认' : '点击了取消');
            }
          },),
          TitleWidget(
            title: '确认对话框（带标题）',
          ),
          Button('确认框', margin: EdgeInsets.symmetric(horizontal: 15), onPressed: () async {
            final result = await Ui.showConfirmDialog(
                context,
                title: '标题',
                message: '无标题的提示弹窗，仅适用于：一两行内容。',
                onConfirm: () {
                  Navigator.of(context).pop(true);
                }
            );
            if (result == null) Ui.showSnackBar(context, text: '点击了遮罩层');
            else {
              Ui.showSnackBar(context, text: result ? '点击了确认' : '点击了取消');
            }
          },),
          TitleWidget(
            title: '确认对话框（不带取消按钮）',
          ),
          Button('确认框', margin: EdgeInsets.symmetric(horizontal: 15), onPressed: () async {
            final result = await Ui.showConfirmDialog(
                context,
                title: '标题',
                showCancelButton: false,
                message: '无标题的提示弹窗，仅适用于：一两行内容。',
                onConfirm: () {
                  Navigator.of(context).pop(true);
                }
            );
            if (result == null) Ui.showSnackBar(context, text: '点击了遮罩层');
            else {
              Ui.showSnackBar(context, text: result ? '点击了确认' : '点击了取消');
            }
          },),
          TitleWidget(
            title: '确认对话框（自定义按钮文案）',
          ),
          Button('确认框', margin: EdgeInsets.symmetric(horizontal: 15), onPressed: () async {
            final result = await Ui.showConfirmDialog(
                context,
                title: '标题',
                cancelText: '关闭',
                confirmText: '我知道了',
                message: '无标题的提示弹窗，仅适用于：一两行内容。',
                onConfirm: () {
                  Navigator.of(context).pop(true);
                }
            );
            if (result == null) Ui.showSnackBar(context, text: '点击了遮罩层');
            else {
              Ui.showSnackBar(context, text: result ? '点击了确认' : '点击了取消');
            }
          },),
          TitleWidget(
            title: '对话框（自定义操作按钮）',
          ),
          Button('对话框', margin: EdgeInsets.symmetric(horizontal: 15), onPressed: () async {
            Ui.showConfirmDialog(
                context,
                title: '标题',
                message: '无标题的提示弹窗，仅适用于：一两行内容。',
                actions: [
                  FlatButton(
                    child: Text('打开',
                      style: TextStyle(
                          fontSize: 18,
                          color: ThemeColorUtil.primaryTextColor(context)
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(0)),
                        side: BorderSide.none
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(true);
                      Ui.showSnackBar(context, text: '打开');
                    },
                  ),
                  FlatButton(
                    child: Text('复制',
                      style: TextStyle(
                          fontSize: 18,
                          color: ThemeColorUtil.primaryTextColor(context)
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(0)),
                        side: BorderSide.none
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(true);
                      Ui.showSnackBar(context, text: '复制');
                    },
                  ),
                  FlatButton(
                    child: Text('取消',
                      style: TextStyle(
                          fontSize: 18,
                        color: Colors.red
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(0)),
                        side: BorderSide.none
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(false);
                      Ui.showSnackBar(context, text: '取消');
                    },
                  )
                ]
            );
          },),
        ],
      ),
    );
  }



}