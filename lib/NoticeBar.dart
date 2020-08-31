import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './utils/ColorUtil.dart';
import './utils/Gaps.dart';

class NoticeBar extends StatefulWidget {
  final String text;
  final double height;
  final double iconSize;
  final double fontSize;
  final Widget prefix;
  final String bgColor; // backgroundColor background
  final String color;
  final bool showSuffix;

  NoticeBar(this.text, {
    Key key,
    this.height = 40.0,
    this.iconSize = 24.0,
    this.fontSize = 14.0,
    this.showSuffix = false,
    this.bgColor = '#fffbe8',
    this.color = '#ed6a0c',
    this.prefix,
   }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _NoticeBar();
  }

}

class _NoticeBar extends State<NoticeBar> {

  GlobalKey textKey = new GlobalKey(debugLabel: 'notice bar text key');

  double top;
  double left;

  bool visible = true;
  void _onClose() {
    setState(() {
      visible = false;
    });
  }


  @override
  void initState() {
    super.initState();
    // 感觉就是mounted
    WidgetsBinding.instance.addPostFrameCallback((time) {
      double textHeight = textKey.currentContext.size.height;
      double height = widget.height;
      setState(() {
        left = 0;
        top = (height - textHeight) / 2;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (visible) {
      return  Container(
          color:ColorUtil.web(widget.bgColor),
          height: widget.height,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                  height: widget.height,
                  width: widget.height,
                  color: ColorUtil.web(widget.bgColor),
                  child: renderPrefix()
              ),
              Expanded(
                child: Stack(
                  children: <Widget>[
                    Positioned (
                        top: top, // 这个要算啊
                        left: left,
                        child: Row(
                          children: <Widget>[
                            Text(
                                widget.text,
                                key: textKey,
                                style: TextStyle(
                                    color: ColorUtil.web(widget.color),
                                    fontSize: widget.fontSize
                                )
                            ),
                            Text(
                                widget.text,
                                style: TextStyle(
                                    color: ColorUtil.web(widget.color),
                                    fontSize: widget.fontSize
                                )
                            ),
                          ],
                        )
                    )
                  ],
                ),
              ),
              renderSuffix()
            ],
          ),
        );
    } else {
      return Gaps.empty; // 建议统一下
    }
  }



  Widget renderPrefix () {
    if (widget.prefix !=null) {
      return widget.prefix;
    } else {
      return Center(
          child: Icon(
              Icons.notifications_none,
              color: ColorUtil.web(widget.color),
              size: widget.iconSize
          )
      );
    }
  }

  Widget renderSuffix() {
    if (widget.showSuffix) {
      return Container(
          height: widget.height,
          width: widget.height,
          color: ColorUtil.web(widget.bgColor),
          child: IconButton(
            icon:Icon(Icons.close,color: ColorUtil.web(widget.color),size: widget.iconSize),
            onPressed: _onClose,
          )
      );
    } else {
      return Gaps.empty; // 这个也可以
    }
  }
}