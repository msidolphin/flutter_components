import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_components/dialog/Dialog.dart';
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
            title: '确认对话框（自定义操作按钮）',
          ),
          Button('确认框', margin: EdgeInsets.symmetric(horizontal: 15), onPressed: () async {
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
                    textColor: ThemeColorUtil.primaryTextColor(context),
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
                    textColor: ThemeColorUtil.primaryTextColor(context),
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
                    textColor: Colors.red,
                  )
                ]
            );
          },),
          TitleWidget(
            title: '确认对话框（自定义内容）',
          ),
          Button('确认框',
            margin: EdgeInsets.symmetric(horizontal: 15),
            onPressed: () async {
              Ui.showCustomConfirmDialog(context,
                  showCloseButton: true,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SvgPicture.string(ResultPageSvgLib.WAITED, width: 65, height: 65,),
                      SizedBox(height: 12,),
                      Text('说明当前状态、提示用户解决方案，最好不要超过两行。', style: TextStyle(
                        fontSize: 14,
                        color: ThemeColorUtil.titleTextColor(context)
                      ), textAlign: TextAlign.center,)
                    ],
                  )
              );
            },
          ),
          TitleWidget(title: '自定义对话框'),
          Button('打开',
            margin: EdgeInsets.symmetric(horizontal: 15),
            onPressed: () {
              Ui.showDialog(context,
                child: Center(
                  child: CachedNetworkImage(
                    imageUrl: 'https://gdjcywebdata001.oss-cn-shenzhen.aliyuncs.com/e9815fe14ade42d18a33d0a10833fd5d.png',
                    width: 300,
                    height: 225,
                  ),
                ),
                transaction: DialogTransaction.scale,
                duration: Duration(milliseconds: 200)
              );
            },
          ),
          SizedBox(height: 15,)
        ],
      ),
    );
  }



}