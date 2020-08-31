import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './utils/ThemeColorUtil.dart';

typedef VoidOnTap();
class InkWellWidget extends StatelessWidget {

  final BorderRadiusGeometry borderRadius;
  final VoidOnTap onTap;
  final Widget child;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;
  final Color color;
  final Decoration decoration;

  const InkWellWidget({Key key,
    this.borderRadius,
    this.onTap,
    this.child,
    this.margin,
    this.padding,
    this.color = Colors.white,
    this.decoration}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      decoration: decoration,
      child: Material(
        borderRadius: borderRadius,
        color: color,
        child: InkWell(
          borderRadius: borderRadius,
          onTap: onTap,
          child: Container(
            padding: padding,
            child: child,
          ),
        ),
      ),
    );
  }
}