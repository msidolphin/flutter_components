// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


/// Used with [TabBar.indicator] to draw a horizontal line below the
/// selected tab.
///
/// The selected tab underline is inset from the tab's boundary by [insets].
/// The [borderSide] defines the line's color and weight.
///
/// The [TabBar.indicatorSize] property can be used to define the indicator's
/// bounds in terms of its (centered) widget with [TabIndicatorSize.label],
/// or the entire tab with [TabIndicatorSize.tab].
class PercentTabIndicator extends Decoration {
  /// Create an underline style selected tab indicator.
  ///
  /// The [borderSide] and [insets] arguments must not be null.
  const PercentTabIndicator({
    this.borderSide = const BorderSide(width: 2.0, color: Colors.blue),
    this.percent = 0.5,
    this.strokeCap = StrokeCap.square,
    this.insets = EdgeInsets.zero,
  }) : assert(borderSide != null),
        assert(insets != null);

  /// The color and weight of the horizontal line drawn below the selected tab.
  final BorderSide borderSide;

  final StrokeCap strokeCap;

  final double percent;
  /// Locates the selected tab's underline relative to the tab's boundary.
  ///
  /// The [TabBar.indicatorSize] property can be used to define the
  /// tab indicator's bounds in terms of its (centered) tab widget with
  /// [TabIndicatorSize.label], or the entire tab with [TabIndicatorSize.tab].
  final EdgeInsetsGeometry insets;

  @override
  Decoration lerpFrom(Decoration a, double t) {
    if (a is PercentTabIndicator) {
      return PercentTabIndicator(
        borderSide: BorderSide.lerp(a.borderSide, borderSide, t),
        insets: EdgeInsetsGeometry.lerp(a.insets, insets, t),
        percent: percent,
        strokeCap: strokeCap
      );
    }
    return super.lerpFrom(a, t);
  }

  @override
  Decoration lerpTo(Decoration b, double t) {
    if (b is PercentTabIndicator) {
      return PercentTabIndicator(
        borderSide: BorderSide.lerp(borderSide, b.borderSide, t),
        insets: EdgeInsetsGeometry.lerp(insets, b.insets, t),
        percent: percent,
        strokeCap: strokeCap
      );
    }
    return super.lerpTo(b, t);
  }

  @override
  PercentTabIndicatorPainter createBoxPainter([ VoidCallback onChanged ]) {
    return PercentTabIndicatorPainter(
      decoration: this,
      percent: percent,
      onChanged: onChanged,
      strokeCap: strokeCap
    );
  }
}

class PercentTabIndicatorPainter extends BoxPainter {

  PercentTabIndicatorPainter({this.decoration, VoidCallback onChanged, this.percent, this.strokeCap})
      : assert(decoration != null),
        super(onChanged);

  final PercentTabIndicator decoration;
  final double percent;
  final StrokeCap strokeCap;

  double dx = 0;

  BorderSide get borderSide => decoration.borderSide;
  EdgeInsetsGeometry get insets => decoration.insets;

  Rect _indicatorRectFor(Rect rect, TextDirection textDirection) {
    assert(rect != null);
    assert(textDirection != null);
    final Rect indicator = insets.resolve(textDirection).deflateRect(rect);
    double left = indicator.left;
    return Rect.fromLTWH(
      left,
      indicator.bottom - borderSide.width,
      indicator.width,
      borderSide.width,
    );
  }

  void paintIndicator(Canvas canvas,
      Offset offset,
      ImageConfiguration configuration,
      Rect currentRect,
      Rect targetRect
    ) {
    assert(configuration != null);
    assert(configuration.size != null);
    /// 37.8 141.3
    final Rect rect = offset & configuration.size;
    final TextDirection textDirection = configuration.textDirection;

    assert(rect != null);
    assert(textDirection != null);
    final Rect indicator = insets.resolve(textDirection).deflateRect(rect);
    Rect indicatorRect;
    /// 计算滑动系数（TODO 粗略计算 更好的方式是求出最大滑动距离再求得系数）
    double minWidth = math.min(targetRect.width, currentRect.width);
    double maxWidth = math.max(targetRect.width, currentRect.width);
    double k = (maxWidth / minWidth).floor() + 1.0;
    if  (targetRect.left < currentRect.left) {
      /// 滑动距离
      double left = indicator.left;
      double dx = (currentRect.left - indicator.left) * k;
      double maxWidth = currentRect.left - targetRect.left;
      double right = currentRect.left + currentRect.width;
      double minRight = targetRect.width + targetRect.left;
      if (dx >= maxWidth) {
        left = targetRect.left;
        /// 右侧收缩
        right += (indicator.left - this.dx) * 2;
      } else {
        left = currentRect.left - dx;
        this.dx = indicator.left;
      }
      /// 检查右边界
      if (right < minRight) right = minRight;
      indicatorRect = Rect.fromLTRB(
          left,
          indicator.bottom - borderSide.width,
          right,
          indicator.height
      ).deflate(borderSide.width / 2.0);
    } else {
      /// 滑动距离
      double dx = (indicator.left - currentRect.left) * k;
      double left = currentRect.left;
      /// 最大右边界
      double maxRight = targetRect.left + targetRect.width;
      double right = left + currentRect.width + dx;
      if (right > maxRight) {
        right = maxRight;
        /// 左侧收缩
        left += (indicator.left - this.dx) * 2;
      } else {
        this.dx = indicator.left;
      }
      /// 防止左边界溢出
      if (left > targetRect.left) {
        left = targetRect.left;
      }
      indicatorRect = Rect.fromLTRB(
          left,
          indicator.bottom - borderSide.width,
          right,
          indicator.height
      ).deflate(borderSide.width / 2.0);
    }
    final Paint paint = borderSide.toPaint()..strokeCap = strokeCap;
    canvas.drawLine(indicatorRect.bottomLeft, indicatorRect.bottomRight, paint);
  }

  @override
  void paint(Canvas canvas,
      Offset offset,
      ImageConfiguration configuration,
    ) {
    assert(configuration != null);
    assert(configuration.size != null);
    final Rect rect = offset & configuration.size;
    final TextDirection textDirection = configuration.textDirection;
    final Rect indicator = _indicatorRectFor(rect, textDirection).deflate(borderSide.width / 2.0);
    final Paint paint = borderSide.toPaint()..strokeCap = strokeCap;
    canvas.drawLine(indicator.bottomLeft, indicator.bottomRight, paint);
  }

}
