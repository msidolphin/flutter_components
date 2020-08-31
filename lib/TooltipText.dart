import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './tooltip/src/tooltip.dart';
import './tooltip/src/types.dart';

import 'utils/ColorUtil.dart';

class TooltipText extends StatefulWidget {

  final String text;
  final TextStyle style;

  const TooltipText(this.text, {Key key, this.style}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _TooltipText();
  }

}

class _TooltipText extends State<TooltipText> {

  bool _show = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        _show = !_show;
        setState(() {
        });
      },
      child: SimpleTooltip(
        tooltipTap: () {
          _show = false;
          setState(() {
          });
        },
        ballonPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
        animationDuration: Duration(milliseconds: 500 ),
        show: _show,
        borderColor: Colors.transparent,
        borderRadius: 4,
        arrowBaseWidth: 18,
        arrowTipDistance: 0,
        arrowLength: 8,
        backgroundColor: ColorUtil.web("#000", 0.4),
        tooltipDirection: TooltipDirection.up,
        child: Material(
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              _show = !_show;
              setState(() {
              });
            },
            child: Text(widget.text + "1",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: widget.style,
            ),
          ),
        ),
        content: Text(widget.text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16
          )
        ),
      ),
    );
  }



}