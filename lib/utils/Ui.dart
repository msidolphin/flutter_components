import 'package:flutter/cupertino.dart' hide Dialog, CloseButton;
import 'package:flutter/material.dart' hide Dialog, CloseButton;
import '../bottomsheet/BottomSheetRoute.dart';
import '../dialog/ConfirmDialog.dart';
import '../dialog/Dialog.dart';

import '../model/IdLabel.dart';
import 'ThemeColorUtil.dart';

class Ui {

  static bool isDarkMode(BuildContext context){
    return Theme.of(context).brightness == Brightness.dark;
  }

  static Future showCustomConfirmDialog(BuildContext context, {
    @required Widget child,
    String title = '提示',
    bool showCancelButton = true,
    String cancelText = '取消',
    String confirmText = '确认',
    @required Function onConfirm,
    Function onCancel
  }) {
    assert(child != null);
    return Dialog.show(
      context: context,
      child: ConfirmDialog(
        title: title,
        cancelText: cancelText,
        confirmText: confirmText,
        showCancel: showCancelButton,
        child: child,
        onConfirm: onConfirm,
        onCancel: onCancel,
      ),
    );
  }

  static Future showConfirmDialog(BuildContext context, {
    @required String message,
    String title = '提示',
    bool showCancelButton = true,
    String cancelText = '取消',
    String confirmText = '确认',
    @required Function onConfirm,
    Function onCancel
  }) async {
    return Dialog.show(
      context: context,
      child: ConfirmDialog(
        title: title,
        cancelText: cancelText,
        confirmText: confirmText,
        showCancel: showCancelButton,
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

  static void showBottomSelectSheet(BuildContext context, {
    @required List<IdLabel> data,
    @required String value,
    @required ValueChanged<IdLabel> onChanged,
  }) {
    int count = data.length;
    Ui.showBottomSheet(
        context,
        child: Container(
          height: (count + 1) * 44 + 8.0,
          alignment: Alignment.center,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: count,
                  itemBuilder: (BuildContext context, int index) {
                    IdLabel project = data[index];
                    return Material(
                      color: Colors.white,
                      child: InkWell(
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border: index == count - 1 ? null : Border(
                              bottom: Divider.createBorderSide(context, width: 0.5)
                            )
                          ),
                              height: 44,
                          child: Text(project.label, style: TextStyle(
                            color: project.id == value ? ThemeColorUtil.primaryColor(context) : Color(0xFF333333),
                          ),),
                        ),
                        onTap: () {
                          Navigator.of(context).pop();
                          if (project.id == value) return;
                          onChanged(project);
                        },
                      ),
                    );
                  }
                ),
              ),
              SizedBox(height: 8),
              Container(
                child: Material(
                  color: Colors.white,
                  child: Row(
                    children: <Widget>[
                      InkWell(
                        child: Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width,
                          height: 44,
                          child: Text('取消',
                            style: TextStyle(
                                fontSize: 17,
                                color: Theme.of(context).errorColor
                            ),
                          )
                        ),
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                ),
                alignment: Alignment.center,
              ),
            ],
          ),
        )
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