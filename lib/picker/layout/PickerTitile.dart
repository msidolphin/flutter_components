import 'package:flutter/material.dart';

import '../../i18n/i18n.dart';
import '../../utils/ThemeColorUtil.dart';
import '../../utils/Ui.dart';
import '../DatePickerConstants.dart';
import '../theme/PickerTheme.dart';

class PickerTitle extends StatelessWidget {
  PickerTitle({
    Key key,
    this.pickerTheme,
    this.locale,
    this.title = "",
    @required this.onCancel,
    @required this.onConfirm,
  }) : super(key: key);

  final PickerTheme pickerTheme;
  final FlatLocale locale;
  final String title;
  final DateVoidCallback onCancel, onConfirm;

  @override
  Widget build(BuildContext context) {
    if (pickerTheme.title != null) {
      return pickerTheme.title;
    }
    return Material(
      child: Container(
        height: pickerTheme.titleHeight,
        decoration: BoxDecoration(color: ThemeColorUtil.backGroundColor(context)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              height: pickerTheme.titleHeight,
              child: FlatButton(
                  child: _renderCancelWidget(context),
                  onPressed: () => this.onCancel()),
            ),
            Expanded(
              child: Container(
                  alignment: Alignment.center,
                  child: Text(title, style: TextStyle(
                      fontSize: 14,
                      color: ThemeColorUtil.titleTextColor(context)
                  ),)
              ),
            ),
            Container(
              height: pickerTheme.titleHeight,
              child: FlatButton(
                  child: _renderConfirmWidget(context),
                  onPressed: () => this.onConfirm()),
            ),
          ],
        ),
      ),
    );
  }

  /// render cancel button widget
  Widget _renderCancelWidget(BuildContext context) {
    Widget cancelWidget = pickerTheme.cancel;
    if (cancelWidget == null) {
      TextStyle textStyle = pickerTheme.cancelTextStyle ??
          TextStyle(
              color: Theme.of(context).unselectedWidgetColor, fontSize: 16.0);
      cancelWidget =
          Text(I18n.getLocaleCancel(locale), style: textStyle);
    }
    return cancelWidget;
  }

  /// render confirm button widget
  Widget _renderConfirmWidget(BuildContext context) {
    Widget confirmWidget = pickerTheme.confirm;
    if (confirmWidget == null) {
      TextStyle textStyle = pickerTheme.confirmTextStyle ??
          TextStyle(color: Ui.isDarkMode(context) ? Colors.white : Theme.of(context).primaryColor, fontSize: 16.0);
      confirmWidget =
          Text(I18n.getLocaleDone(locale), style: textStyle);
    }
    return confirmWidget;
  }
}
