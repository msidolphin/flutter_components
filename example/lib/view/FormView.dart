import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_components/widgets.dart';

class FormView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Material(
        child: ListView(
          children: <Widget>[
            FormGroup(
              children: [
                FormInputItem(
                  label: '单项输入',
                  placeholder: '请输入',
                  value: '',
                  onChanged: (value) {},
                ),
                FormInputItem(
                  label: '密码输入项',
                  type: FormInputType.password,
                  placeholder: '请输入',
                  value: '',
                  onChanged: (value) {},
                ),
                FormInputItem(
                  label: '副标题',
                  subTitle: '我是副标题',
                  placeholder: '请输入',
                  value: '',
                  onChanged: (value) {},
                ),
                FormSwitchItem(
                  label: '开关',
                  value: true,
                  onChanged: (value) {},
                ),
                FormSliderItem(
                  label: '滑块',
                  value: 10,
                  max: 100,
                  min: 0,
                  onChanged: (value) {},
                ),
                FormInputItem(
                  leading: Container(
                    width: 28,
                    height: 28,
                    color: Color(0xFFE8E8E8),
                  ),
                  label: '前置内容',
                  placeholder: '请输入',
                  value: '',
                  onChanged: (value) {},
                ),
                FormInputItem(
                  leading: Container(
                    width: 28,
                    height: 28,
                    color: Color(0xFFE8E8E8),
                  ),
                  label: '前置内容',
                  placeholder: '请输入',
                  value: '',
                  onChanged: (value) {},
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.all(15),
              child: Button('提交'),
            )
          ],
        ),
      ),
    );
  }


}