import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Grid extends StatefulWidget {
  final List<Widget> children;
  final int crossAxisCount;
  final double mainAxisSpacing;
  final double crossAxisSpacing;
  final double childAspectRatio;
  final Axis scrollDirection;
  final bool reverse;
  final bool primary;
  final bool shrinkWrap;
  final GridBorder border;
  final double borderWidth;

  Grid(this.children, {
    Key key,
    this.crossAxisCount = 3,
    this.mainAxisSpacing = 0.0,
    this.crossAxisSpacing = 0.0,
    this.childAspectRatio = 1.0,
    this.scrollDirection = Axis.vertical,
    this.reverse = false,
    this.shrinkWrap = false,
    this.primary = false,
    this.border = GridBorder.none,
    this.borderWidth = 0.5
  }) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _Grid();
  }

}

class _Grid extends State<Grid> {
  int length;//children长度
  int count;//一行个数
  int fr;// 宫格占满的行数 不满一行的不计数
  int lr;// length与行数的余数
  int ir; //(index + 1)与行数的余数

  List<Widget> _children;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
        crossAxisCount: widget.crossAxisCount,
        scrollDirection: widget.scrollDirection,
        crossAxisSpacing: widget.crossAxisSpacing,
        mainAxisSpacing: widget.mainAxisSpacing,
        childAspectRatio: widget.childAspectRatio,
        physics: const NeverScrollableScrollPhysics(),
        children:initListWidget(widget.children)
    );
  }

  List<Widget> initListWidget(children) {
    List<Widget> lists = [];
    for(int i = 0; i < children.length; ++i) {
      lists.add(getItemChild(children[i], i + 1));
    }
    return lists;
  }

  Widget getItemChild(item, index) {
    return Container(
      decoration: BoxDecoration(
          border: Border(
            left: BorderSide(
              width: getItemBorderWidth('left', index),
              color: Theme.of(context).dividerColor,
            ),
            top:BorderSide(
              width: getItemBorderWidth('top', index),
              color: Theme.of(context).dividerColor,
            ),
            right:BorderSide(
              width: getItemBorderWidth('right', index),
              color: Theme.of(context).dividerColor,
            ),
            bottom: BorderSide(
              width: getItemBorderWidth('bottom', index),
              color: Theme.of(context).dividerColor,
            ),
          )
      ),
      child: item
    );
  }


  double getItemBorderWidth (String value, int i) {
    length = widget.children.length;
    count = widget.crossAxisCount;
    lr = length % count ;
    ir = i % count;
    fr = (length / count).floor();
    if (widget.border == GridBorder.half) {
      return getHalfBorderWidth(value, i);
    } else if ((widget.border == GridBorder.full)){
      return getFullBorderWidth(value, i);
    } else {
      return 0.0;
    }
  }

  double getHalfBorderWidth(String value, int i) {
     if (value == 'right') {
        if (ir != 0) {
          return widget.borderWidth;
        } else {
          return 0.0;
        }
    } else if (value == 'bottom') {
        if (lr > 0  && (i <= length - lr)) {
          return widget.borderWidth;
        } else if(lr == 0  && (i <= length - count)) {
          return widget.borderWidth;
        } else {
          return 0.0;
        }
    } else {
      return 0.0;
    }
  }
  double getFullBorderWidth(String value, int i) {
    if (value == 'left') { //
      if(ir == 1) {
        return widget.borderWidth;
      } else {
        return 0.0;
      }
    } else if (value == 'top') {
      if(i <= count) {
        return widget.borderWidth;
      } else {
        return 0.0;
      }
    } else {
      return widget.borderWidth;
    }
  }
}

enum GridBorder {
  none,
  half,
  full
}