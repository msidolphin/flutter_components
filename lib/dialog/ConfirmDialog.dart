import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../i18n/i18n.dart';
import '../utils/ColorUtil.dart';

import '../utils/ThemeColorUtil.dart';
import 'BaseDialog.dart';

//typedef OnPressed = Function(BuildContext context);

// ignore: must_be_immutable
class ConfirmDialog extends BaseDialog {

  final Function onConfirm;
  final Function onCancel;
  final String cancelText;
  final String confirmText;
  final FlatLocale locale;
  final bool showCancel;
  final String title;
  final double width;
  final BorderRadiusGeometry borderRadius;
  final EdgeInsetsGeometry bodyPadding;
  final EdgeInsetsGeometry padding;
  /// 如果传入了actions，那么将不会展示默认的取消和确认按钮，并且排列方式为垂直排列
  final List<FlatButton> actions;

  ConfirmDialog({
    Key key,
    this.title = "",
    this.width = 270,
    @required Widget child,
    this.onConfirm,
    this.onCancel,
    this.locale = FlatLocale.zh_cn,
    this.confirmText,
    this.cancelText,
    this.showCancel = true,
    this.bodyPadding = const EdgeInsets.only(left: 20, right: 20, bottom: 28),
    this.padding = const EdgeInsets.only(top: 28.0),
    this.borderRadius = const BorderRadius.all(Radius.circular(8)),
    this.actions = const [],
  }): super(child: child, borderRadius: borderRadius);

  @override
  Widget render(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: ThemeColorUtil.backGroundColor(context),// Theme.of(context).trans,
          borderRadius: borderRadius,
        ),
        width: this.width,
        padding: this.padding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Offstage(
              offstage: title.isEmpty,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                  title.isEmpty ? '' : title,
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
            Container(
              child: Column(
                children: [
                  Container(
                    padding: this.bodyPadding,
                    child: this.child,
                  ),
                  actions == null || actions.isEmpty ? Row(
                    children: renderButtons(context)
                  ) : Column(
                    mainAxisSize: MainAxisSize.max,
                    children: renderActions(context),
                  )
                ],
              ),
            )
          ],
        )
    );
  }

  List<Widget> renderActions(BuildContext context) {
    List<Widget> widgets = [];
    widgets.add(Divider(height: 0.5,));
    for (int i = 0; i < actions.length; ++i) {
      widgets.add(SizedBox(
        height: 48.0,
        width: width,
        child: actions[i],
      ));
      if (i < actions.length - 1) {
        widgets.add(Divider(height: 0.5,));
      }
    }
    return widgets;
  }

  List<Widget> renderButtons (BuildContext context) {
    final String _cancelText = this.cancelText == null ?
    I18n.getLocaleCancel(locale) : this.cancelText;
    final String _confirmText = this.confirmText == null ?
    I18n.getLocaleDone(locale) : this.confirmText;
    if (showCancel) {
      return [
        Expanded(
          child: SizedBox(
            height: 48.0,
            child: Container(
              decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(
                          width: 0.5,
                          color: Theme.of(context).dividerColor
                      )
                  )
              ),
              child: FlatButton(
                child: Text(
                  _cancelText,
                  style: TextStyle(
                      fontSize: 18
                  ),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(0)),
                    side: BorderSide.none
                ),
                textColor: ColorUtil.web("#999"),
                onPressed: () {
                  if (this.onCancel != null) {
                    this.onCancel();
                  }
                  FocusScope.of(context).unfocus();
                  Navigator.of(context).pop(false);
                },
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 48.0,
          width: 0.5,
          child: const VerticalDivider(),
        ),
        Expanded(
          child: SizedBox(
            height: 48.0,
            child: Container(
              decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(
                          width: 0.5,
                          color: Theme.of(context).dividerColor
                      )
                  )
              ),
              child: FlatButton(
                child: Text(
                  _confirmText,
                  style: TextStyle(
                      fontSize: 18,
                    color: ThemeColorUtil.primaryTextColor(context)
                  ),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(0)),
                    side: BorderSide.none
                ),
                textColor: Theme.of(context).primaryColor,
                onPressed: () {
                  if (this.onConfirm != null) {
                    FocusScope.of(context).unfocus();
                    this.onConfirm();
                  } else {
                    Navigator.of(context).pop(true);
                  }
                },
              ),
            ),
          ),
        )
      ];
    } else {
      return [
        Expanded(
          child: SizedBox(
            height: 48.0,
            child: Container(
              decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(
                          width: 0.5,
                          color: Theme.of(context).dividerColor
                      )
                  )
              ),
              child: FlatButton(
                child: Text(
                  _confirmText,
                  style: TextStyle(
                      fontSize: 18
                  ),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(0)),
                    side: BorderSide.none
                ),
                textColor: Theme.of(context).primaryColor,
                onPressed: () {
                  if (this.onConfirm != null) {
                    this.onConfirm();
                  }
                },
              ),
            ),
          ),
        )
      ];
    }
  }

}