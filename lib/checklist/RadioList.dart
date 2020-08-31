
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../checklist/ICheckListItem.dart';
import '../checklist/CheckList.dart';

typedef ValueChanged(String value, String text);

class RadioList<T extends ICheckListItem> extends StatefulWidget {
  final String value;
  final List<T> dataSource;
  final Widget leading;
  final Widget selected;
  final Widget unSelected;
  final bool bordered;
  final ValueChanged onChanged;

  RadioList(this.dataSource, this.value,{
    Key key,
    this.leading,
    this.selected,
    this.unSelected,
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
        widget.dataSource,
        [widget.value],
        wrapBordered: widget.bordered,
        leading: widget.leading,
        selected: widget.selected,
        unSelected: widget.unSelected,
        multiple:false,
        onChanged: (value,text) {
          widget?.onChanged(value[0],text[0]);
        },
    );
  }
}