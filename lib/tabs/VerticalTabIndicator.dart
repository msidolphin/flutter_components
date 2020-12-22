import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class VerticalUnderlineTabIndicator extends Decoration {



  const VerticalUnderlineTabIndicator({
    this.borderSide = const BorderSide(width: 2.0, color: Colors.white),
    this.insets = EdgeInsets.zero,
    this.sliderColor = Colors.transparent,
  }) : assert(borderSide != null),
        assert(insets != null);

  final BorderSide borderSide;

  final EdgeInsetsGeometry insets;

  final Color sliderColor;

  @override
  Decoration lerpFrom(Decoration a, double t) {
    if (a is VerticalUnderlineTabIndicator) {
      return VerticalUnderlineTabIndicator(
        borderSide: BorderSide.lerp(a.borderSide, borderSide, t),
        insets: EdgeInsetsGeometry.lerp(a.insets, insets, t),
      );
    }
    return super.lerpFrom(a, t);
  }

  @override
  Decoration lerpTo(Decoration b, double t) {
    if (b is VerticalUnderlineTabIndicator) {
      return VerticalUnderlineTabIndicator(
        borderSide: BorderSide.lerp(borderSide, b.borderSide, t),
        insets: EdgeInsetsGeometry.lerp(insets, b.insets, t),
      );
    }
    return super.lerpTo(b, t);
  }

  @override
  _UnderlinePainter createBoxPainter([ VoidCallback onChanged ]) {
    return _UnderlinePainter(this, onChanged);
  }
}

class _UnderlinePainter extends BoxPainter {
  _UnderlinePainter(this.decoration, VoidCallback onChanged)
      : assert(decoration != null),
        super(onChanged);

  final VerticalUnderlineTabIndicator decoration;

  BorderSide get borderSide => decoration.borderSide;
  EdgeInsetsGeometry get insets => decoration.insets;
  Color get sliderColor => decoration.sliderColor;

  Rect _indicatorRectFor(Rect rect, TextDirection textDirection) {
    assert(rect != null);
    assert(textDirection != null);
    final Rect indicator = insets.resolve(textDirection).deflateRect(rect);
    return Rect.fromLTWH(
        0,
        indicator.left,
        borderSide.width,
        indicator.width
    );
  }

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    assert(configuration != null);
    assert(configuration.size != null);
    final Rect rect = offset & configuration.size;
    final TextDirection textDirection = configuration.textDirection;
    final Rect indicator = _indicatorRectFor(rect, textDirection).deflate(borderSide.width / 2.0);
    /// 绘制滑块
    canvas.drawRect(Rect.fromCenter(
        center: indicator.center,
        width: 1000, /// 暂时获取不到准确的宽度，画一个很宽的。。。  当前可以传进来
        height: indicator.height + borderSide.width
    ), new Paint(
    )..style = PaintingStyle.fill..color = sliderColor);
    /// 绘制标识线
    final Paint paint = borderSide.toPaint()..strokeCap = StrokeCap.round;
    canvas.drawLine(Offset(indicator.topLeft.dx, indicator.topLeft.dy + 10), Offset(indicator.bottomLeft.dx, indicator.bottomLeft.dy - 10), paint);

  }
}
