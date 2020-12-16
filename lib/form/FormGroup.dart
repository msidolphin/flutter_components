import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../list/AbstractListItem.dart';
import '../utils/Ui.dart';

// ignore: must_be_immutable
class FormGroup extends StatelessWidget {

  final List<AbstractListItem> children;

  final EdgeInsetsGeometry margin;

  List<AbstractListItem> _children;

  final bool bordered;

  FormGroup(
      {Key key, this.margin, @required this.children, this.bordered = false}
  ) : assert(children != null), super(key: key) {
    handleLastItem();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: this.margin == null ? EdgeInsets.all(0) : this.margin,
        decoration: BoxDecoration(
            border: bordered ?  Border(
              top: Divider.createBorderSide(context, width: 0.5),
              bottom: Divider.createBorderSide(context, width: 0.5),
            ) : null
        ),
        child: Material( // 套一层Material，解决漪涟效果失效的问题 https://www.jianshu.com/p/48c2ea1218e5
          color: Ui.isDarkMode(context) ? Theme.of(context).scaffoldBackgroundColor : Colors.white,
          child: Column(
              children: _children
          ),
        ));
    }

  void handleLastItem () {
    // deep clone
    this._children =  List<AbstractListItem>.generate(
      this.children.length,
          (index) => this.children[index],
      growable: true,
    );
    if (this._children.length > 0) {
      this._children.first.isFirst = true;
    }
  }

}