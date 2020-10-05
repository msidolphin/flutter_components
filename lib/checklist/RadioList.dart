
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../checklist/ICheckListItem.dart';
import '../checklist/CheckList.dart';

typedef RadioValueChanged(String value, String text);

class RadioList<T extends ICheckListItem> extends StatefulWidget {
  final String value;
  final List<T> options;
  final Widget leading;
  final Widget selectedIcon;
  final Widget unSelectedIcon;
  final bool bordered;
  final RadioValueChanged onChanged;

  RadioList({this.options, this.value,
    Key key,
    this.leading,
    this.selectedIcon,
    this.unSelectedIcon,
    this.onChanged, this.bordered = false
  }) :
        super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _RadioList();
  }
}

class _RadioList extends State<RadioList>{

  @override
  Widget build(BuildContext context) {
    return  CheckList(
        options: widget.options,
        value: [widget.value],
        wrapBordered: widget.bordered,
        leading: widget.leading,
        selectedIcon: widget.selectedIcon,
        unSelectedIcon: widget.unSelectedIcon,
        multiple:false,
        onChanged: (value,text) {
          widget?.onChanged?.call(value[0],text[0]);
        },
    );
  }
}