import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//文本提示的Widget
class ToastView extends StatefulWidget {

  final List<Widget> children;
  final EdgeInsetsGeometry contentPadding;
  final Color contentColor;
  final BorderRadiusGeometry borderRadius;
  final double minWidth;
  final double minHeight;

  const ToastView(
      {Key key,
        @required this.children,
        this.contentPadding,
        this.contentColor,
        this.borderRadius,
        this.minHeight = 0,
        this.minWidth = 0})
      : super(key: key);

  @override
  ToastViewState createState() => ToastViewState();
}

class ToastViewState extends State<ToastView> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Container(
            constraints: constraints.copyWith(
              minHeight: widget.minHeight,
              minWidth: widget.minHeight,
              maxWidth: constraints.biggest.width * 0.8
            ),
            padding: widget.contentPadding,
            decoration: BoxDecoration(
              color: widget.contentColor,
              borderRadius: widget.borderRadius,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: widget.children
            ));
      },
    );
  }
}


