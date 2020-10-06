import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_components/Button.dart';
import 'package:flutter_components/widgets.dart';
import 'package:flutter_components_example/widget/TitleWidget.dart';

class ButtonView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        alignment: Alignment.topLeft,
        child: ListView(
          children: <Widget>[
            TitleWidget(
              title: "Button 按钮",
            ),
            Button('普通按钮', onPressed: () {
            }),
            SizedBox(height: 4,),
            Button('加载中...', loading: true,),
            SizedBox(height: 4,),
            Button('禁用', disabled: true,),
            SizedBox(height: 4,),
            Button('幽灵按钮', ghost: true,),
            SizedBox(height: 4,),
            Button('加载中...', ghost: true, loading: true,),
            SizedBox(height: 4,),
            InlineBox(
              child: Container(
                width: 160,
                child: Button('小号按钮', size: ButtonSize.small,),
              ),
            ),
            SizedBox(height: 4,),
            InlineBox(
              child: Container(
                width: 160,
                child: Button('小号按钮', size: ButtonSize.small, ghost: true,),
              ),
            ),
          ],
        ),
      ),
    );
  }


}