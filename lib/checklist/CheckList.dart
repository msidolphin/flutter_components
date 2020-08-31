

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../form/FieldItemMixin.dart';
import '../form/RawFieldItem.dart';
import '../utils/Gaps.dart';
import '../checklist/ICheckListItem.dart';
import '../utils/ThemeColorUtil.dart';

typedef ValueChanged(List<String> value, List<String> text);
typedef VoidCallback = Function();

class CheckList<T extends ICheckListItem> extends StatefulWidget {
  final List<String> value;
  final List<T> dataSource;
  final Widget leading;
  final Widget selected;
  final Widget unSelected;
  final bool multiple;
  final bool wrapBordered;
  final int limit;
  final ValueChanged onChanged;
  final VoidCallback onExceed;

  CheckList(this.dataSource, this.value, {
    Key key,
    this.multiple = true,
    this.leading,
    this.selected,
    this.unSelected,
    this.limit = 0,
    this.onChanged,
    this.onExceed,
    this.wrapBordered = false,
  }) : assert(value != null), super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CheckList();
  }
}

class _CheckList extends State<CheckList> with FieldItemMixin{
  List<String> currentValue;
  @override
  void initState() {
    super.initState();
    setState(() {
      currentValue = List.generate(widget.value.length, (index) {
        return widget.value[index];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Material(
      color: ThemeColorUtil.backGroundColor(context),
      child: Container(
          decoration: BoxDecoration(
              border: widget.wrapBordered ? Border(
                top:BorderSide(
                  width: 0.5,
                  color: Theme.of(context).dividerColor,
                ),
                bottom: BorderSide(
                  width: 0.5,
                  color: Theme.of(context).dividerColor,
                ),
              ) : null
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
              children: initChildren(widget.dataSource)
          ),
      ),
    );
  }
  List<Widget> initChildren(List<ICheckListItem> children) {
    List<Widget> _children = [];
    for(int i = 0; i < children.length; ++i) {
      _children.add(getItemChild(children[i], i));
    }
    return _children;
  }
  Widget getItemChild (ICheckListItem item, index) {
    return RawFieldItem(
        isLast: index == widget.dataSource.length -1 ? true : false,
        leading: widget.leading,
        onPressed: () {
          setState(() {
            String value = item.getId();
            int i = currentValue.indexOf(value);
            if (widget.multiple) {
              if (i != -1) {
                currentValue.remove(item.getId());
              } else if (widget.limit == 0 || (widget.limit != 0 && currentValue.length < widget.limit)){
                currentValue.add(item.getId());
              } else {
                widget.onExceed();
              }
            } else {
              currentValue[0] = value;
            }
            if (widget.onChanged != null) {
              List<String> currentText = [];
              int index = -1;
              for(ICheckListItem it in widget.dataSource) {
                index = currentValue.indexOf(it.getId());
                if (index != -1) currentText.add(it.getLabel());
              }
              widget?.onChanged(currentValue,currentText);
            }
          });
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            renderLabel(item.getLabel(), 100, context),
            renderIcon(item.getId()),
          ],
        )
    );
  }
  Widget renderIcon(value) {
    if (widget.multiple) {
      if (currentValue.indexOf(value) != -1) {
        return widget.selected != null ? widget.selected : Icon(Icons.check, color: ThemeColorUtil.primaryTextColor(context), size: 16);
      } else {
        return widget.unSelected != null ? widget.unSelected : Gaps.empty;
      }
    } else {
      if (currentValue[0] == value) {
        return widget.selected != null ? widget.selected : Icon(Icons.check, color: ThemeColorUtil.primaryTextColor(context), size: 16);
      } else {
        return widget.unSelected != null ? widget.unSelected : Gaps.empty;
      }
    }
  }
}