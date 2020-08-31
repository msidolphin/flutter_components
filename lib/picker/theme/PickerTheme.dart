import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

/// Default value of DatePicker's background color.
const PICKER_BACKGROUND_COLOR = Colors.white;

/// Default value of whether show title widget or not.
const PICKER_SHOW_TITLE_DEFAULT = true;

/// Default value of DatePicker's height.
const double PICKER_HEIGHT = 210.0;

/// Default value of DatePicker's title height.
const double PICKER_TITLE_HEIGHT = 44.0;

/// Default value of DatePicker's column height.
const double PICKER_ITEM_HEIGHT = 36.0;

/// Default value of DatePicker's item [TextStyle].
const TextStyle PICKER_ITEM_TEXT_STYLE =
const TextStyle(color: Color(0xFF000046), fontSize: 16.0);

class PickerTheme extends Diagnosticable {
  final cancelDefault = const Text('OK');

  /// DateTimePicker theme.
  ///
  /// [backgroundColor] DatePicker's background color.
  /// [cancelTextStyle] Default cancel widget's [TextStyle].
  /// [confirmTextStyle] Default confirm widget's [TextStyle].
  /// [cancel] Custom cancel widget.
  /// [confirm] Custom confirm widget.
  /// [title] Custom title widget. If specify a title widget, the cancel and confirm widgets will not display. Must set [titleHeight] value for custom title widget.
  /// [showTitle] Whether display title widget or not. If set false, the default cancel and confirm widgets will not display, but the custom title widget will display if had specified one custom title widget.
  /// [pickerHeight] The value of DatePicker's height.
  /// [titleHeight] The value of DatePicker's title height.
  /// [itemHeight] The value of DatePicker's column height.
  /// [itemTextStyle] The value of DatePicker's column [TextStyle].
  const PickerTheme({
    this.backgroundColor: PICKER_BACKGROUND_COLOR,
    this.cancelTextStyle,
    this.confirmTextStyle,
    this.cancel,
    this.confirm,
    this.title,
    this.showTitle: PICKER_SHOW_TITLE_DEFAULT,
    this.pickerHeight: PICKER_HEIGHT,
    this.titleHeight: PICKER_TITLE_HEIGHT,
    this.itemHeight: PICKER_ITEM_HEIGHT,
    this.itemTextStyle: PICKER_ITEM_TEXT_STYLE,
  });

  static const PickerTheme Default = const PickerTheme();

  /// DatePicker's background color.
  final Color backgroundColor;

  /// Default cancel widget's [TextStyle].
  final TextStyle cancelTextStyle;

  /// Default confirm widget's [TextStyle].
  final TextStyle confirmTextStyle;

  /// Custom cancel [Widget].
  final Widget cancel;

  /// Custom confirm [Widget].
  final Widget confirm;

  /// Custom title [Widget]. If specify a title widget, the cancel and confirm widgets will not display.
  final Widget title;

  /// Whether display title widget or not. If set false, the default cancel and confirm widgets will not display, but the custom title widget will display if had specified one custom title widget.
  final bool showTitle;

  /// The value of DatePicker's height.
  final double pickerHeight;

  /// The value of DatePicker's title height.
  final double titleHeight;

  /// The value of DatePicker's column height.
  final double itemHeight;

  /// The value of DatePicker's column [TextStyle].
  final TextStyle itemTextStyle;

  PickerTheme copyWiths({
    double pickerHeight
  }) {
    return PickerTheme(
      backgroundColor: this.backgroundColor,
      cancelTextStyle: this.cancelTextStyle,
      confirmTextStyle: this.confirmTextStyle,
      cancel: this.cancel,
      confirm: this.confirm,
      title: this.title,
      showTitle: this.showTitle,
      pickerHeight: pickerHeight ?? this.pickerHeight,
      titleHeight: this.titleHeight,
      itemHeight: this.itemHeight,
      itemTextStyle: this.itemTextStyle
    );
  }

}
