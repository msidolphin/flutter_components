import 'package:flutter/material.dart';

// ignore: must_be_immutable
abstract class BaseDialog extends StatelessWidget{

  BaseDialog({
    Key key,
    @required this.child
  }) : super(key : key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(//创建透明层
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      // 键盘弹出收起动画过渡
      body: AnimatedContainer(
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height - MediaQuery.of(context).viewInsets.bottom,
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeInCubic,
        child: render(context)
      ),
    );
  }

  Widget render (BuildContext context) {
    return this.child;
  }

}