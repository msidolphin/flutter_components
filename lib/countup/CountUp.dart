
import 'package:flutter/material.dart';
import 'package:flutter_components/types.dart';

class CountUp extends StatefulWidget {

  const CountUp(this.number,{
    Key key,
    this.style,
    this.duration = const Duration(microseconds: 1200),
    this.formatter,
  }): super(key: key);

  final num number;
  final TextStyle style;
  final Duration duration;
  final ValueFormatter formatter;

  @override
  _CountUpState createState() => _CountUpState();

}

class _CountUpState extends State<CountUp> with SingleTickerProviderStateMixin {

  Animation<double> _animation;
  AnimationController _controller;
  num _fromNumber = 0;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(duration: widget.duration, vsync: this);
    final Animation curve = CurvedAnimation(parent: _controller, curve: Curves.linear);
    _animation = Tween<double>(begin: 0, end: 1).animate(curve);
    _controller.forward(from: 0);
  }

  @override
  void didUpdateWidget(CountUp oldWidget) {
    super.didUpdateWidget(oldWidget);
    // 数据变化时执行动画
    if (oldWidget.number != widget.number) {
      _fromNumber = oldWidget.number;
      _controller.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return AnimatedBuilder(
      animation: _animation,
      builder: (_, __) {
        // 数字默认从0增长。数据变化时，由之前数字为基础变化。
        double value = (_fromNumber + (_animation.value * (widget.number - _fromNumber)));
        String valueStr = value.toString();
        if (widget.formatter != null) {
          valueStr = widget.formatter(value);
        }
        return Text(
          valueStr,
          style: widget.style,
        );
      },
    );
  }

}


