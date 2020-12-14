import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Ui.dart';

class ThemeColorUtil {

  /// 主题色
  static Color primaryColor(BuildContext context) {
    return Theme.of(context).primaryColor;
  }

  /// 主题色
  static LinearGradient primaryLineGradientColor(BuildContext context) {
    return  LinearGradient(
        colors: [Color(0xFF409BFF), Color(0xFF1677FF)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight);
  }

  /// 主题文本色
  static Color primaryTextColor(BuildContext context) {
    return Ui.isDarkMode(context) ? Colors.white : Theme.of(context).primaryColor;
  }

  /// 主题边框色
  static Color primaryBorderColor(BuildContext context) {
    return Ui.isDarkMode(context) ? Colors.white : Theme.of(context).primaryColor;
  }

  /// 标题
  static Color titleTextColor(BuildContext context) {
    return Ui.isDarkMode(context) ? Color(0xFF696969) : Color(0xff333333);
  }


  /// 副标题
  static Color subTitleTextColor(BuildContext context) {
    return Ui.isDarkMode(context) ? Color(0xFF696969) : Color.fromRGBO(0, 0, 0, 0.5);
  }

  /// 正文
  static Color bodyTextColor(BuildContext context) {
    return Ui.isDarkMode(context) ? Color(0xFF696969) : Color(0xff333333);
  }

  /// 数字金额颜色
  static Color numberTextColor(BuildContext context) {
    return Ui.isDarkMode(context) ? Colors.white : Color(0xFFFF3B30);
  }

  /// 数字金额颜色
  static Color assistButtonColor(BuildContext context) {
    return Ui.isDarkMode(context) ? Colors.white : Color(0xFFFF8F1F);
  }

  /// 暗文字/失效
  static Color disableTextColor(BuildContext context) {
    return Ui.isDarkMode(context) ? Color(0xffcccccc) : Color(0xffcccccc);
  }

  /// 禁用颜色
  static Color disabledColor(BuildContext context) {
    return Theme.of(context).disabledColor;
  }

  /// 分割线
  static Color dividerColor(BuildContext context) {
    return Ui.isDarkMode(context) ? Theme.of(context).dividerColor : Theme.of(context).dividerColor;
  }

  /// 全局背景色
  static Color globalBackGroundColor(BuildContext context) {
    return Ui.isDarkMode(context) ? Theme.of(context).scaffoldBackgroundColor : Color(0xFFF4F4F4);
  }

  /// 卡片背景色
  static Color cardBackgroundColor(BuildContext context) {
    return Colors.white;
  }

  /// 卡片内背景色
  static Color innerBackGroundColor(BuildContext context) {
    return Ui.isDarkMode(context) ? Theme.of(context).scaffoldBackgroundColor : Color(0xFFF7F7F7);
  }

  /// 背景色
  static Color backGroundColor(BuildContext context) {
    return Ui.isDarkMode(context) ? Theme.of(context).scaffoldBackgroundColor : Color(0xFFFFFFFF);
  }

}