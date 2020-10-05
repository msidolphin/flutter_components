import 'package:flutter/cupertino.dart';

import 'package:flutter_components/widgets.dart';

import '../widget/TitleWidget.dart';

class ToastView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 15),
        children: <Widget>[
          TitleWidget(title: 'Toast 吐司',),
          TitleWidget(title: '文本提示',),
          Button("文本提示",
            onPressed: () {
              Toast.show("文本提示文本提示");
            },
          ),
          TitleWidget(title: '成功提示',),
          Button("操作成功",
            onPressed: () {
              Toast.success("操作成功");
            },
          ),
          TitleWidget(title: '错误提示',),
          Button("错误提示",
            onPressed: () {
              Toast.failed("错误提示");
            },
          ),
          TitleWidget(title: '警告提示',),
          Button("警告提示",
            onPressed: () {
              Toast.warning("警告提示");
            },
          ),
          TitleWidget(title: '加载提示',),
          Button("加载提示",
            onPressed: () async {
              Toast.showLoading();
              await Future.delayed(Duration(seconds: 2));
              Toast.hideLoading();
            },
          ),
          SizedBox(height: 30,)
        ],
      ),
    );
  }
  
}