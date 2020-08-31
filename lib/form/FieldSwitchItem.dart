import 'package:flutter/cupertino.dart';
import '../form/FieldItemMixin.dart';
import '../list/AbstractListItem.dart';

import 'RawFieldItem.dart';

// ignore: must_be_immutable
class FieldSwitchItem extends AbstractListItem {

  final String label;

  /// width of label
  final double labelWidth;

  final bool value;

  final ValueChanged<bool> onChanged;

  final Widget leading;

  final Widget trailing;

  final Color activeColor;

  FieldSwitchItem({
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

class _FieldSwitchItem extends State<FieldSwitchItem>
    with FieldItemMixin {

  @override
  Widget build(BuildContext context) {
    return RawFieldItem(
      leading: widget.leading,
      trailing: widget.trailing,
      isLast: widget.isLast,
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
      value: widget.value,
      activeColor: widget.activeColor,
      onChanged: (value) {
        widget.onChanged(value);
      },
    );
  }

}