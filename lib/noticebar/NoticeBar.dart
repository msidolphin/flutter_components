import 'package:flutter/material.dart';

import '../utils/Gaps.dart';

// 默认字体颜色
const Color _fontColor = Color(0xffFF8F1F);
// 背景色
const Color _color = Color(0xFFFFF9ED);

class NoticeBar extends StatefulWidget {
  // 字体颜色
  final Color fontColor;
  // 背景色
  final Color color;
  // 图标
  final Widget icon;
  // 动画过度时间
  final int duration;
  // 是否可关闭
  final bool closeable;
  // 内容
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
  // bar容器key
  GlobalKey _barKey = GlobalKey();
  // box
  GlobalKey _boxKey = GlobalKey();
  // 最大值
  double _maxLeft;
  double _boxWidth;
  // padding
  final double _boxPadding = 5;
  double _left = 0;
  // 动画
  AnimationController controller;
  Animation transform;
  // 是否被关闭
  bool isClose = false;

  @override
  initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(init);
  }

  void init(Duration time) {
    _maxLeft = _barKey.currentContext?.size.width;
    _boxWidth = _boxKey.currentContext?.size.width;
    if (_maxLeft == null) _maxLeft = 0;
    if (_boxWidth == null) _boxWidth = 0;
    // 判断是否滚动
    if (_maxLeft > _boxWidth) {
      // 初始化动画
      controller = AnimationController(
          duration: Duration(milliseconds: widget.duration),
          vsync: this
      )
        ..repeat();
      createAnimate(0.0, -_maxLeft);
    }
  }

  // 创建动画
  void createAnimate(double start, double end) {
    transform = Tween<double>(begin: start, end: end)
        .animate(
        CurvedAnimation(
            parent: controller,
            curve: Curves.linear
        )
    )
      ..addListener(() {
        setState(() {
          if (-(_maxLeft - 1) >= transform.value) {
            _left = _boxWidth;
            createAnimate(_boxWidth, -_maxLeft);
          } else {
            _left = transform.value;
          }
        });
      });
  }

  // 关闭
  void close() {
    disposeAnimate();
    setState(() {
      isClose = true;
    });
  }

  // 销毁动画
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