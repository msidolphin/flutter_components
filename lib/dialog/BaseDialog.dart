import 'package:flutter/material.dart';

// ignore: must_be_immutable
abstract class BaseDialog extends StatelessWidget{

  BaseDialog({
    Key key,
    @required this.child,
    this.borderRadius
  }) : super(key : key);

  final BorderRadiusGeometry borderRadius;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        borderRadius: borderRadius,
        child: render(context),
      )
    );
  }

  Widget render (BuildContext context) {
    return this.child;
  }

}