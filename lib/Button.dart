import 'package:flutter/cupertino.dart' hide CupertinoActivityIndicator;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math' as math;

// Extracted from iOS 13.2 Beta.
const Color _kActiveTickColor = CupertinoDynamicColor.withBrightness(
  color: Color(0xFFEBEBF5),
  darkColor: Color(0xFFEBEBF5),
);


class Button extends StatefulWidget {

  final dynamic child;
  final VoidCallback onPressed;
  final VoidCallback onLongPressed;
  final VoidCallback onDisabled;
  final bool disabled;
  final bool loading;
  final bool radius;
  final bool ghost;
  final ButtonShape shape;
  final ButtonSize size;
  final EdgeInsetsGeometry margin;
  final Color backgroundColor;
  final Color textColor;
  final Color disabledBackgroundColor;
  final Color disabledTextColor;
  final double elevation;

  Button(this.child, {
    Key key,
    this.size = ButtonSize.medium,
    this.shape = ButtonShape.round,
    this.onPressed,
    this.onLongPressed,
    this.loading = false,
    this.radius = false,
    this.margin = const EdgeInsets.all(0),
    this.disabled = false,
    this.backgroundColor,
    this.textColor,
    this.elevation = 0,
    this.disabledBackgroundColor,
    this.disabledTextColor, this.onDisabled, this.ghost = false}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _Button();
  }

}

class _Button extends State<Button> {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.disabled ? () {
        widget.onDisabled?.call();
      } : null,
      child: Container(
        height: _getButtonSize(),
        margin: widget.margin,
        child: MaterialButton(
          padding: EdgeInsets.symmetric(horizontal: widget.loading ? 18 : 36),
          elevation: widget.elevation,
          onPressed: widget.disabled || widget.loading ? null : () {
            if (!widget.loading) widget.onPressed();
          },
          onLongPress: widget.disabled || widget.loading ? null : () {
            if (!widget.loading) widget.onLongPressed();
          },
          child: renderChild(),
          shape: _getButtonShape(),
          color: color(),
          highlightColor: widget.ghost ? Colors.transparent : null,
          hoverColor: widget.ghost ? Colors.transparent : null,
          focusColor: widget.ghost ? Colors.transparent : null,
          splashColor: widget.ghost ? Colors.transparent : null,
          highlightElevation: 0,
          textColor: textColor(),
          disabledColor: disabledColor(),
          disabledTextColor: disabledTextColor(),
        ),
      ),
    );
  }

  textColor() {
    if (widget.textColor != null) return widget.textColor;
    if (widget.ghost) return Theme.of(context).primaryColor;
    return Colors.white;
  }

  color() {
    if (widget.ghost) return Colors.transparent;
    if (widget.backgroundColor != null) return widget.backgroundColor;
    return Theme.of(context).primaryColor;
  }

  disabledColor() {
    Color primary = Theme.of(context).primaryColor;
    if (widget.ghost) return Colors.transparent;
    if (widget.loading) return Theme.of(context).primaryColor;
    if (widget.disabledBackgroundColor != null) return widget.disabledBackgroundColor;
    return Color.fromRGBO(primary.red, primary.green, primary.blue, 0.4);
  }

  disabledTextColor() {
    if (widget.ghost) return Theme.of(context).primaryColor;
    if (widget.disabledTextColor != null) return widget.disabledTextColor;
    return Colors.white;
  }


  Widget renderChild () {
    //
    Widget widgetChild = widget.child is String ? new Text(widget.child) : widget.child;

    if (widget.loading) {
      final Widget indicator = AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: CupertinoActivityIndicator(
          activeColor: !widget.ghost ? _kActiveTickColor : CupertinoDynamicColor.withBrightness(
            color: Theme.of(context).primaryColor,
            darkColor: Theme.of(context).primaryColor,
          ),
        ),
      );
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          indicator,
        ],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          widgetChild
        ],
      );
    }

  }

  double _getButtonSize () {
    switch(widget.size) {
      case ButtonSize.mini:
        return 20;
      case ButtonSize.small:
        return 35;
      case ButtonSize.medium:
        return 48;
      case ButtonSize.large:
        return 48;
      default:
        return 48;
    }
  }

  _getButtonShape () {
    switch(widget.shape) {
      case ButtonShape.round:
        return RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(_getButtonSize())),
          side: !widget.ghost ? BorderSide.none : BorderSide(
            width: 0.5,
            color: Theme.of(context).primaryColor
          )
        );
      case ButtonShape.square:
        return RoundedRectangleBorder(
            side: !widget.ghost ? BorderSide.none : BorderSide(
                width: 0.5,
                color: Theme.of(context).primaryColor
            )
        );
      case ButtonShape.radius:
        return RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4.0)),
            side: !widget.ghost ? BorderSide.none : BorderSide(
                width: 0.5,
                color: Theme.of(context).primaryColor
            )
        );
      case ButtonShape.circle:
        return CircleBorder(
            side: !widget.ghost ? BorderSide.none : BorderSide(
                width: 0.5,
                color: Theme.of(context).primaryColor
            )
        );
    }
  }


}

enum ButtonType {
  Primary,
  Warning,
}
enum ButtonShape {
  radius,// 默认按钮
  round,//圆角按钮
  square,
  circle
}
enum ButtonSize {
  mini,
  small,
  medium,
  large
}


const double _kDefaultIndicatorRadius = 10.0;



/// An iOS-style activity indicator that spins clockwise.
///
/// See also:
///
///  * <https://developer.apple.com/ios/human-interface-guidelines/controls/progress-indicators/#activity-indicators>
class CupertinoActivityIndicator extends StatefulWidget {
  /// Creates an iOS-style activity indicator that spins clockwise.
  const CupertinoActivityIndicator({
    Key key,
    this.animating = true,
    this.radius = _kDefaultIndicatorRadius,
    this.activeColor = _kActiveTickColor
  }) : assert(animating != null),
        assert(radius != null),
        assert(radius > 0),
        super(key: key);

  /// Whether the activity indicator is running its animation.
  ///
  /// Defaults to true.
  final bool animating;

  /// Radius of the spinner widget.
  ///
  /// Defaults to 10px. Must be positive and cannot be null.
  final double radius;

  final CupertinoDynamicColor activeColor;

  @override
  _CupertinoActivityIndicatorState createState() => _CupertinoActivityIndicatorState();
}


class _CupertinoActivityIndicatorState extends State<CupertinoActivityIndicator> with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    if (widget.animating)
      _controller.repeat();
  }

  @override
  void didUpdateWidget(CupertinoActivityIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.animating != oldWidget.animating) {
      if (widget.animating)
        _controller.repeat();
      else
        _controller.stop();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.radius * 2,
      width: widget.radius * 2,
      child: CustomPaint(
        painter: _CupertinoActivityIndicatorPainter(
          position: _controller,
          activeColor: CupertinoDynamicColor.resolve(widget.activeColor, context),
          radius: widget.radius,
        ),
      ),
    );
  }
}

const double _kTwoPI = math.pi * 2.0;
const int _kTickCount = 12;

// Alpha values extracted from the native component (for both dark and light mode).
// The list has a length of 12.
const List<int> _alphaValues = <int>[147, 131, 114, 97, 81, 64, 47, 47, 47, 47, 47, 47];

class _CupertinoActivityIndicatorPainter extends CustomPainter {
  _CupertinoActivityIndicatorPainter({
    @required this.position,
    @required this.activeColor,
    double radius,
  }) : tickFundamentalRRect = RRect.fromLTRBXY(
    -radius,
    radius / _kDefaultIndicatorRadius,
    -radius / 2.0,
    -radius / _kDefaultIndicatorRadius,
    radius / _kDefaultIndicatorRadius,
    radius / _kDefaultIndicatorRadius,
  ),
        super(repaint: position);

  final Animation<double> position;
  final RRect tickFundamentalRRect;
  final Color activeColor;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint();

    canvas.save();
    canvas.translate(size.width / 2.0, size.height / 2.0);

    final int activeTick = (_kTickCount * position.value).floor();

    for (int i = 0; i < _kTickCount; ++ i) {
      final int t = (i + activeTick) % _kTickCount;
      paint.color = activeColor.withAlpha(_alphaValues[t]);
      canvas.drawRRect(tickFundamentalRRect, paint);
      canvas.rotate(-_kTwoPI / _kTickCount);
    }

    canvas.restore();
  }

  @override
  bool shouldRepaint(_CupertinoActivityIndicatorPainter oldPainter) {
    return oldPainter.position != position || oldPainter.activeColor != activeColor;
  }
}
