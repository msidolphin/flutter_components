import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './utils/ThemeColorUtil.dart';

typedef VoidOnTap();
class ActionButtonWidget extends StatelessWidget {

  final VoidOnTap onTap;
  final String text;

  const ActionButtonWidget({Key key,
    this.onTap,
    this.text = "取消",}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap == null ? () {
        Navigator.of(context).pop();
      } : onTap,
      child: Container(
          alignment: Alignment.center,
          width: 56.0,
          child: Text(
            text,
            style: TextStyle(
              color: ThemeColorUtil.primaryTextColor(context),
              fontSize: 15
            ),
          )
      ),
    );
  }
}