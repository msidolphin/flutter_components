import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// 骨架屏 元素背景 ->形状及颜色
class SkeletonDecoration extends BoxDecoration {
  SkeletonDecoration({
    bool isCircle: false,
    bool isDark: false,
    BorderRadiusGeometry borderRadius
  }) : super(
    color: !isDark ? Colors.grey[350] : Colors.grey[700],
    shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
    borderRadius: borderRadius
  );
}