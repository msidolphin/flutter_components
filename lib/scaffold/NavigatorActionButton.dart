import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef VoidOnTap();
class NavigatorActionButton extends StatelessWidget {

  final VoidOnTap onTap;
  final String text;

  const NavigatorActionButton({Key key,
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
                color: Theme.of(context).primaryColor,
                fontSize: 15
            ),
          )
      ),
    );
  }
}