import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../utils/Ui.dart';
import '../list/ListItem.dart';
import '../utils/FlatMarging.dart';
import '../utils/Util.dart';

// ignore: must_be_immutable
class ListGroup extends StatelessWidget {

  final List<ListItem> children;

  final EdgeInsetsGeometry margin;

  final bool bordered;

  List<ListItem> _children;


  ListGroup({@required this.children, this.margin, this.bordered = false}) {
    this.handleLastItem();
  }

  void handleLastItem () {
    // deep clone
    this._children = List<ListItem>.generate(
      this.children.length,
          (index) => this.children[index],
      growable: true,
    );
    this._children = Util.filter<ListItem>(this._children, (item) => item.visible);
    if (this._children.length > 0) {
      this._children[this._children.length - 1].isLast = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return createWidget(context);
  }

  Widget createWidget (BuildContext context) {
    return Container(
        margin: this.margin == null ? FlatMargin(0) : this.margin,
        decoration: BoxDecoration(
            border: bordered ? Border(
              top: Divider.createBorderSide(context, width: 0.4),
              bottom: Divider.createBorderSide(context, width: 0.4),
            ) : null
        ),
        child: Material( // 套一层Material，解决漪涟效果失效的问题 https://www.jianshu.com/p/48c2ea1218e5
          color: Ui.isDarkMode(context) ? Theme.of(context).scaffoldBackgroundColor : Colors.white,
          child: Column(
            children: _children
          ),
        ));
  }

}
