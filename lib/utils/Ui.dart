import 'dart:io';

import 'package:flutter/cupertino.dart' hide Dialog, CloseButton;
import 'package:flutter/material.dart' hide Dialog, CloseButton;
import '../bottomsheet/BottomSheetRoute.dart';
import '../dialog/ConfirmDialog.dart';
import '../dialog/Dialog.dart';

import '../model/IdLabel.dart';
import '../widgets.dart';
import 'ThemeColorUtil.dart';

class Ui {

  static bool isDarkMode(BuildContext context){
    return Theme.of(context).brightness == Brightness.dark;
  }

  static Future showModalBottomSheet(BuildContext context, {
    @required ScrollWidgetBuilder builder,
    Color backgroundColor,
    double elevation,
    ShapeBorder shape,
    Clip clipBehavior,
    Color barrierColor,
    bool bounce = false,
    bool expand = false,
    AnimationController secondAnimation,
    bool useRootNavigator = false,
    bool isDismissible = true,
    bool enableDrag = true,
  }) {
    assert(builder != null);
    if (Platform.isIOS) {
      return showCupertinoModalBottomSheet(
        context: context,
        builder: builder,
        backgroundColor: backgroundColor,
        elevation: elevation,
        shape: shape,
        clipBehavior: clipBehavior,
        barrierColor: barrierColor,
        bounce: bounce,
        expand: expand,
        secondAnimation: secondAnimation,
        useRootNavigator: useRootNavigator,
        isDismissible: isDismissible,
        enableDrag: enableDrag
      );
    } else {
      return showMaterialModalBottomSheet(
        context: context,
        builder: builder,
        backgroundColor: backgroundColor,
        elevation: elevation,
        shape: shape,
        clipBehavior: clipBehavior,
        barrierColor: barrierColor,
        bounce: bounce,
        expand: expand,
        secondAnimation: secondAnimation,
        useRootNavigator: useRootNavigator,
        isDismissible: isDismissible,
        enableDrag: enableDrag
      );
    }
  }

 static Future showCustomConfirmDialog(BuildContext context, {
    @required Widget child,
    String title = '',
    bool showCancelButton = true,
    String cancelText = '取消',
    String confirmText = '确认',
    Function onConfirm,
    Function onCancel,
    List<FlatButton> actions = const [],
    bool showCloseButton = false
  }) {
    assert(child != null);
    return Dialog.show(
      context: context,
      child: ConfirmDialog(
        title: title,
        cancelText: cancelText,
        confirmText: confirmText,
        showCancel: showCancelButton,
        showCloseButton: showCloseButton,
        child: child,
        actions: actions,
        onConfirm: onConfirm,
        onCancel: onCancel,
      ),
    );
  }

  static Future<bool> showConfirmDialog(BuildContext context, {
    @required String message,
    String title = '',
    bool showCancelButton = true,
    String cancelText = '取消',
    String confirmText = '确认',
    Function onConfirm,
    Function onCancel,
    List<FlatButton> actions = const [],
    bool showCloseButton = false
  }) async {
    return Dialog.show(
      context: context,
      child: ConfirmDialog(
        title: title,
        cancelText: cancelText,
        confirmText: confirmText,
        showCancel: showCancelButton,
        showCloseButton: showCloseButton,
        actions: actions,
        child: Text(message,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Color(0XFF888888),
            fontSize: 14,
          ),),
        onConfirm: onConfirm,
        onCancel: onCancel,
      ),
    );
  }

  static Future<T> showBottomSheet<T>(BuildContext context, {
    @required Widget child
  }) async {
    FocusScope.of(context).unfocus();
    T res = await Navigator.push(
        context,
        BottomSheetRoute(
            child: Material(
              color: Colors.transparent,
              child: child,
            )
        )
    );
    return res;
  }

  static void showSnackBar(BuildContext context, {
    @required String text,
    Duration duration = const Duration(seconds: 1),
    SnackBarAction action
  }) {
    assert(text != null);
    if (action == null) {
      action = new SnackBarAction(label: "关闭", onPressed: () {
        Scaffold.of(context).hideCurrentSnackBar();
      });
    }
    final snackBar = new SnackBar(content: new Text(text), action: action, duration: duration,);
    Scaffold.of(context).showSnackBar(snackBar);
  }

  static Widget divider(BuildContext context, {double width = 0.5}) {
    return Container(
      decoration: BoxDecoration(
          border: Border(
              bottom: Divider.createBorderSide(context, width: width)
          )
      ),
    );
  }

  static Future showDialog(BuildContext context, {
    @required Widget child
  }) {
    return Dialog.show(
      context: context,
      child: child,
    );
  }

}