import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// 间隔
class Gaps {
  /// 水平间隔
  static const Widget hGap4 = const SizedBox(width: 4.0);
  static const Widget hGap5 = const SizedBox(width: 5.0);
  static const Widget hGap6 = const SizedBox(width: 6.0);
  static const Widget hGap8 = const SizedBox(width: 8.0);
  static const Widget hGap10 = const SizedBox(width: 10.0);
  static const Widget hGap12 = const SizedBox(width: 12.0);
  static const Widget hGap15 = const SizedBox(width: 15.0);
  static const Widget hGap16 = const SizedBox(width: 16.0);
  static const Widget hGap18 = const SizedBox(width: 18.0);
  /// 垂直间隔
  static const Widget vGap4 = const SizedBox(height: 4.0);
  static const Widget vGap5 = const SizedBox(height: 5.0);
  static const Widget vGap6 = const SizedBox(height: 6.0);
  static const Widget vGap8 = const SizedBox(height: 8.0);
  static const Widget vGap10 = const SizedBox(height: 10.0);
  static const Widget vGap12 = const SizedBox(height: 12.0);
  static const Widget vGap15 = const SizedBox(height: 15.0);
  static const Widget vGap16 = const SizedBox(height: 16.0);
  static const Widget vGap50 = const SizedBox(height: 50.0);
  static const Widget vGap18 = const SizedBox(width: 18.0);

  static Widget line = const Divider();

  static Widget vLine = const SizedBox(
    width: 0.6,
    height: 24.0,
    child: const VerticalDivider(),
  );

  static const Widget empty = const SizedBox();
}
