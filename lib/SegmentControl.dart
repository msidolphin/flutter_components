import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './utils/ViewportUtil.dart';

typedef IndexChanged(int index);
class SegmentControl extends StatefulWidget {

  final List<SegmentControlItem> children;
  final int currentIndex;
  final Color bgColor;
  final Color textColor;
  final Color activeBgColor;
  final Color activeTextColor;
  final IndexChanged onChanged;

   SegmentControl({Key key,
    this.children,
    this.currentIndex = 0,
    this.bgColor = const Color(0xffffffff),
    this.textColor = const Color(0xff333333),
    this.activeBgColor = const Color(0xff333333),
    this.activeTextColor = const Color(0xffffffff),
    this.onChanged
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SegmentControl();
  }
}

class _SegmentControl extends State<SegmentControl> {

  int _currentIndex;

  @override
  // ignore: must_call_super
  void initState() {
    _currentIndex = widget.currentIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF363333),
        border: Border.all(width: 1.w,color: Color(0xFF363333)),
        borderRadius: BorderRadius.circular(4.w)
      ),
      child: Row(
        children: widget.children.asMap().keys.map((idx){
          SegmentControlItem item = widget.children[idx];
          return ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft:  Radius.circular(idx == 0 ?  4.w : 0) ,
              topRight: Radius.circular(idx == widget.children.length -1 ? 4.w : 0),
              bottomLeft: Radius.circular(idx == 0 ?  4.w : 0) ,
              bottomRight: Radius.circular(idx == widget.children.length -1 ? 4.w : 0),
            ),
            child: GestureDetector(
                onTap: () {
                  if(_currentIndex != idx) {
                    _currentIndex = idx;
                    setState(() {});
                    widget.onChanged(idx);
                  }
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 4.w,horizontal: 38.w),
                  decoration: BoxDecoration(
                      color: idx == _currentIndex ? widget.activeBgColor : widget.bgColor,
                      border: Border(
                        left: idx == 0 ?  BorderSide(width: 0,color: Colors.transparent) : BorderSide(width: 1.w,color: Color(0xFF363333)),
                      ),
                  ),
                  alignment: Alignment.center,
                  child: Text(item.text, style: TextStyle(
                      color: idx == _currentIndex ? widget.activeTextColor : widget.textColor,
                      fontSize: 24.w
                  ),),
                )
            ),
          );
        }).toList(),
      ),
    );
  }

}

class SegmentControlItem {
  final String text;
  SegmentControlItem({this.text});
}