import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../form/FieldItemMixin.dart';
import '../list/AbstractListItem.dart';

import 'RawFieldItem.dart';

// ignore: must_be_immutable
class FormSwitchItem extends AbstractListItem {

  final String label;

  /// width of label
  final double labelWidth;

  final bool value;

  final ValueChanged<bool> onChanged;

  final Widget leading;

  final Widget trailing;

  final Color activeColor;

  FormSwitchItem({
    Key key,
    this.label,
    this.labelWidth,
    @required this.value,
    @required this.onChanged,
    this.leading,
    this.trailing,
    this.activeColor,
  }):
  assert(value != null),
  assert(onChanged != null),
  super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _FieldSwitchItem();
  }

}

class _FieldSwitchItem extends State<FormSwitchItem>
    with FieldItemMixin {

  bool _currentValue = false;


  @override
  void initState() {
    super.initState();
    _currentValue = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return RawFieldItem(
      leading: widget.leading,
      trailing: widget.trailing,
      isFirst: widget.isFirst,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          renderLabel(widget.label, widget.labelWidth, context),
          renderSwitch()
        ],
      ),
    );;
  }



  Widget renderSwitch() {
    return CupertinoSwitch(
      value: _currentValue,
      activeColor: widget.activeColor != null ? widget.activeColor : Theme.of(context).primaryColor,
      onChanged: (value) {
        widget.onChanged(value);
        _currentValue = value;
        setState(() {

        });
      },
    );
  }

}