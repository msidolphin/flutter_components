import 'package:flutter/cupertino.dart';

class InlineBox extends StatelessWidget {

  final Widget child;

  const InlineBox({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      child: child,
    );
  }

}