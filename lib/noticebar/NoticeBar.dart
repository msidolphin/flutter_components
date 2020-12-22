import 'package:flutter/material.dart';

import '../utils/Gaps.dart';

const Color _fontColor = Color(0xffFF8F1F);
const Color _color = Color(0xFFFFF9ED);

class NoticeBar extends StatefulWidget {

  final Color fontColor;
  final Color color;
  final Widget icon;
  final int duration;
  final bool closeable;
  final Widget child;

  final bool isScrollable;

  NoticeBar({
    this.fontColor = _fontColor,
    this.color = _color,
    this.icon,
    this.duration = 15000,
    this.closeable = false,
    @required this.child, this.isScrollable = true,
  });

  @override
  NoticeBarState createState() => NoticeBarState();
}

class NoticeBarState extends State<NoticeBar> with TickerProviderStateMixin {

  GlobalKey _barKey = GlobalKey();
  GlobalKey _boxKey = GlobalKey();
  double _maxLeft;
  double _boxWidth;
  final double _boxPadding = 5;
  double _left = 0;
  AnimationController controller;
  Animation transform;
  bool isClose = false;

  @override
  initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(init);
  }

  void init(Duration time) {
    _maxLeft = _barKey.currentContext?.size?.width;
    _boxWidth = _boxKey.currentContext?.size?.width;
    if (_maxLeft == null) _maxLeft = 0;
    if (_boxWidth == null) _boxWidth = 0;
    if (_maxLeft > _boxWidth && widget.isScrollable) {
      controller = AnimationController(
          duration: Duration(milliseconds: widget.duration),
          vsync: this
      )
        ..repeat();
      createAnimate(0.0, -_maxLeft);
    }
  }

  void createAnimate(double start, double end) {
    transform?.removeListener(this.transformListener);
    transform = Tween<double>(begin: start, end: end)
        .animate(
        CurvedAnimation(
            parent: controller,
            curve: Curves.linear
        )
    )
      ..addListener(this.transformListener);
  }

  void transformListener() {
    setState(() {
      if (-(_maxLeft - 1) >= transform.value) {
        _left = _boxWidth;
        createAnimate(_boxWidth, -_maxLeft);
      } else {
        _left = transform.value;
      }
    });
  }

  void close() {
    disposeAnimate();
    setState(() {
      isClose = true;
    });
  }

  void disposeAnimate() {
    controller?.dispose();
    controller = null;
  }

  @override
  void dispose() {
    disposeAnimate();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isClose) {
      return SizedBox(height: 0.0);
    }

    final List<Widget> children = [
      Expanded(
          key: _boxKey,
          flex: 1,
          child: Stack(
              children: <Widget>[
                Positioned(
                    top: 0,
                    left: 0,
                    bottom: 0,
                    child: Align(
                        key: _barKey,
                        alignment: Alignment.centerLeft,
                        child: DefaultTextStyle(
                            style: TextStyle(
                                color: widget.fontColor,
                                fontSize: 14.0
                            ),
                            child: Transform.translate(
                                offset: Offset(_left, 0.0),
                                child: widget.child
                            )
                        )
                    )
                )
              ]
          )
      )
    ];

    Widget icon = widget.icon != null ? Padding(
        padding: EdgeInsets.only(right: 5.0),
        child: widget.icon
    ) : Gaps.empty;

    Widget closeBtn = widget.closeable ? GestureDetector(
        onTap: close,
        child: Padding(
            padding: EdgeInsets.only(left: 5),
            child: Icon(Icons.close, color: Color(0xFFE8E8E8), size: 20.0)
        )
    ) : Gaps.empty;

    children.insert(0, icon);

    children.add(closeBtn);

    return widget.isScrollable ? Container(
        height: 32,
        child: DecoratedBox(
            decoration: BoxDecoration(
                color: widget.color
            ),
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: _boxPadding),
                child: Row(
                  children: children
                )
            )
        )
    ) : Container(
      constraints: BoxConstraints(
        minHeight: 32
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: widget.color
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: _boxPadding, vertical: 0),
          child: Row(
            children: [
              icon,
              Expanded(
                child: Align(
                    key: _barKey,
                    alignment: Alignment.centerLeft,
                    child: DefaultTextStyle(
                        style: TextStyle(
                            color: widget.fontColor,
                            fontSize: 14.0
                        ),
                        child: Transform.translate(
                            offset: Offset(_left, 0.0),
                            child: widget.child
                        )
                    )
                ),
              ),
              closeBtn
            ],
          ),
        ),
      ),
    );
  }
}