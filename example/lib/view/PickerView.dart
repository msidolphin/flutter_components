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

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Material(
      color: Colors.white,
      child: ListView(
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
          )
        ],
      ),
    ));
  }

}