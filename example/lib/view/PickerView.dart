import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_components/picker/Picker.dart';
import 'package:flutter_components_example/widget/TitleWidget.dart';

class PickerView extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return PickerViewState();
  }

}

class PickerViewState extends State<PickerView> {

  String value = "2";
  String text = "梨子🍐";

  List<String> multipleColumnsSelectedValue = ["1", "18"];
  List<String> multipleColumnsSelectedText = ["生肖", "羊🐑"];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          TitleWidget(title: 'Picker 选择器',),
          Padding(padding: const EdgeInsets.symmetric(horizontal: 15),
            child: FlatButton(
              child: Text('当前已选：$text'),
              onPressed: () {
                Picker.show(context, dataSource: {
                  "0": {
                    "1": "苹果🍎",
                    "2": "梨子🍐",
                    "3": "桃子🍑"
                  },
                }, level: 1,
                  value: [value],
                  onConfirm: (values, texts) {
                    setState(() {
                      value = values.first;
                      text = texts.first;
                    });
                  }
                );
              },
            ),
          ),
          Padding(padding: const EdgeInsets.symmetric(horizontal: 15),
            child: FlatButton(
              child: Text('【cupertino风格】当前已选：$text'),
              onPressed: () {
                Picker.show(context, dataSource: {
                  "0": {
                    "1": "苹果🍎",
                    "2": "梨子🍐",
                    "3": "桃子🍑"
                  },
                }, level: 1,
                    value: [value],
                    onConfirm: (values, texts) {
                      setState(() {
                        value = values.first;
                        text = texts.first;
                      });
                    },
                    useCupertinoStyle: true
                );
              },
            ),
          ),
          Padding(padding: const EdgeInsets.symmetric(horizontal: 15),
            child: FlatButton(
              child: Text('【material风格】当前已选：$text'),
              onPressed: () {
                Picker.show(context, dataSource: {
                  "0": {
                    "1": "苹果🍎",
                    "2": "梨子🍐",
                    "3": "桃子🍑"
                  },
                }, level: 1,
                  value: [value],
                  onConfirm: (values, texts) {
                    setState(() {
                      value = values.first;
                      text = texts.first;
                    });
                  },
                  useCupertinoStyle: false
                );
              },
            ),
          ),
          Padding(padding: const EdgeInsets.symmetric(horizontal: 15),
            child: FlatButton(
              child: Text('多列选择：${multipleColumnsSelectedText.join("/")}'),
              onPressed: () {
                Picker.show(context, dataSource: {
                  "0": {
                    "1": "生肖",
                    "2": "星座"
                  },
                  "1": {
                    "11": "鼠🐭",
                    "12": "牛🐂",
                    "13": "虎🐯",
                    "14": "兔🐰",
                    "15": "龙🐲",
                    "16": "蛇🐍",
                    "17": "马🐎",
                    "18": "羊🐑",
                    "19": "猴🐒",
                    "110": "鸡🐔",
                    "111": "狗🐶",
                    "112": "猪🐷"
                  },
                  "2": {
                    "21": "白羊座♈️",
                    "22": "金牛座♉️",
                    "23": "双子座♊️",
                    "24": "巨蟹座♋️",
                    "25": "狮子座♌️",
                    "26": "处女座♍️",
                    "27": "天秤座♎️",
                    "28": "天蝎座♏️",
                    "29": "射手座♐️",
                    "210": "魔蝎座♑",
                    "211": "水瓶座♒️",
                    "212": "双鱼座♓️"
                  }
                }, level: 2,
                    value: multipleColumnsSelectedValue,
                    onConfirm: (values, texts) {
                      setState(() {
                        multipleColumnsSelectedValue = values;
                        multipleColumnsSelectedText = texts;
                      });
                    },
                    useCupertinoStyle: true
                );
              },
            ),
          ),
        ],
      ),
    );
  }

}