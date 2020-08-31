import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../i18n/i18n.dart';
import '../picker/theme/PickerTheme.dart';

import 'layout/BottomSheetPIckerLayout.dart';

class PickerRoute<T> extends PopupRoute<T> {
  PickerRoute({
    @required this.child,
    this.dateFormat,
    this.locale = FlatLocale.zh_cn,
    this.pickerTheme = PickerTheme.Default,
    this.onCancel,
    this.onConfirm,
    this.theme,
    this.barrierLabel,
    this.minuteDivider,
    this.title = "",
    RouteSettings settings,
  }) : super(settings: settings);

  final String dateFormat;
  final FlatLocale locale;
  final PickerTheme pickerTheme;
  final VoidCallback onCancel;
  final VoidCallback onConfirm;
  final int minuteDivider;
  final Widget child;
  final String title;
  final ThemeData theme;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 300);

  @override
  bool get barrierDismissible => true;

  @override
  final String barrierLabel;

  @override
  Color get barrierColor => Colors.black45;

  AnimationController _animationController;

  @override
  AnimationController createAnimationController() {
    assert(_animationController == null);
    _animationController = AnimationController(vsync: navigator.overlay, duration: Duration(milliseconds: 300));
//        BottomSheet.createAnimationController(navigator.overlay);
    return _animationController;
  }

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    double height = pickerTheme.pickerHeight;
    if (pickerTheme.title != null || pickerTheme.showTitle) {
      height += pickerTheme.titleHeight;
    }

    Widget bottomSheet = AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: new MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: BottomSheetPickerLayout(
            this,
            height,
            this.child,
            title: title,
            locale: this.locale,
            theme: this.pickerTheme,
            onCancel: this.onCancel,
            onConfirm: this.onConfirm,
          )
      ),
    );

    if (theme != null) {
      bottomSheet = new Theme(data: theme, child: bottomSheet);
    }
    return bottomSheet;
  }
}