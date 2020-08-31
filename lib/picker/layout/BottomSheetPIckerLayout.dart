import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../i18n/i18n.dart';
import '../theme/PickerTheme.dart';

import '../PickerRoute.dart';
import 'PickerTitile.dart';

class BottomSheetPickerLayout extends StatelessWidget {

  final PickerRoute route;

  final double pickerHeight;

  final Widget child;

  final FlatLocale locale;

  final PickerTheme theme;

  final VoidCallback onCancel;
  final VoidCallback onConfirm;
  final String title;


  BottomSheetPickerLayout(this.route, this.pickerHeight, this.child, {
    this.locale = FlatLocale.en_us,
    this.theme,
    this.onCancel,
    this.onConfirm,
    this.title = ""
  });

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      child: new AnimatedBuilder(
        animation: route.animation,
        builder: (BuildContext context, Widget child) {
          return new ClipRect(
            child: new CustomSingleChildLayout(
              delegate: new _BottomPickerLayout(route.animation.value,
                  contentHeight: pickerHeight),
              child: Column(
                children: <Widget>[
                  PickerTitle(
                    locale: this.locale,
                    pickerTheme: this.theme,
                    onConfirm: this.onConfirm,
                    onCancel: this.onCancel,
                    title: title,
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.white,
                      padding: EdgeInsets.only(left: 0, right: 0),
                      child: this.child
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

}

class _BottomPickerLayout extends SingleChildLayoutDelegate {
  _BottomPickerLayout(this.progress, {this.contentHeight});

  final double progress;
  final double contentHeight;

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    return new BoxConstraints(
      minWidth: constraints.maxWidth,
      maxWidth: constraints.maxWidth,
      minHeight: 0.0,
      maxHeight: contentHeight,
    );
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    double height = size.height - childSize.height * progress;
    return new Offset(0.0, height);
  }

  @override
  bool shouldRelayout(_BottomPickerLayout oldDelegate) {
    return progress != oldDelegate.progress;
  }
}
