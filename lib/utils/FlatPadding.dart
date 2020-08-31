import 'package:flutter/cupertino.dart';

class FlatPadding extends EdgeInsets {

  ///
  /// css风格的构造函数 支持
  /// 上 右 下 左
  /// 上 左右 下
  /// 上下 左右
  /// 上下左右
  FlatPadding(double p1, [double p2, double p3, double p4])
      : super.fromLTRB((p4 != null ? p4 : (p2 != null ? p2 : (p3 != null ? p3 : p1))),
      p1,
      (p3 != null ? p2 : (p2 != null ? p2 : p1)),
      (p3 != null ? p3 : p1));

}