import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../bottomsheet/BottomSheetRoute.dart';

class WidgetUtil {

  static Widget emptyWidget() {
    return LimitedBox(
      maxWidth: 0.0,
      maxHeight: 0.0,
      child: ConstrainedBox(constraints: const BoxConstraints.expand(width: 0, height: 0)),
    );
  }

  static Widget createWidget (Widget widget) {
    if (widget == null) {
      return LimitedBox(
        maxWidth: 0.0,
        maxHeight: 0.0,
        child: ConstrainedBox(constraints: const BoxConstraints.expand(width: 0, height: 0)),
      );
    }
    return widget;
  }

  static Widget divider(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border(
              bottom: Divider.createBorderSide(context, width: 0.5)
          )
      ),
    );
  }

  static void showBottomSheet(BuildContext context, {
    @required Widget child
  }) {
    Navigator.push(context, BottomSheetRoute(child: child));
  }


}
