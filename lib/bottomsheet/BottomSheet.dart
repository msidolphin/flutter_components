import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'BottomSheetRoute.dart';

class BottomSheet {

  static void show(BuildContext context, {
    @required Widget child
  }) {
    FocusScope.of(context).unfocus();
    Navigator.push(
      context,
      BottomSheetRoute(
        child: Material(
          color: Colors.transparent,
          child: child,
        )
      )
    );
  }

}
