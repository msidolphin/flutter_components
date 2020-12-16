import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// ignore: implementation_imports
import 'package:flutter/src/widgets/framework.dart';
import '../form/FieldItemMixin.dart';
import '../form/RawFieldItem.dart';
import '../list/AbstractListItem.dart';
import '../utils/WidgetUtil.dart';

// ignore: must_be_immutable
class FormSliderItem extends AbstractListItem {

  final String label;

  /// width of label
  final double labelWidth;

  final double value;

  final double min;

  final double max;

  final int divisions;

  final Widget prefix;

  final Widget suffix;

  final Widget leading;

  final Widget trailing;

  final Color activeColor;

  final Color thumbColor;

  final ValueChanged<double> onChanged;

  FormSliderItem({
    Key key,
    this.label,
    this.labelWidth,
    @required this.value,
    this.min = 0.0,
    this.max = 1.0,
    this.divisions,
    this.prefix,
    this.suffix,
    this.leading,
    this.trailing,
    this.activeColor,
    this.thumbColor = CupertinoColors.white,
    @required this.onChanged
  });


  @override
  State<StatefulWidget> createState() {
    return _FieldSliderItemState();
  }


}

class _FieldSliderItemState extends State<FormSliderItem>
  with FieldItemMixin {

  double _currentValue;


  @override
  void initState() {
    super.initState();
    _currentValue = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return RawFieldItem(
      isFirst: widget.isFirst,
      leading: widget.leading,
      trailing: widget.trailing,
      child: Row(
        children: <Widget>[
          renderLabel(widget.label, widget.labelWidth, context),
          Expanded(
            child: Row(
              children: <Widget>[
                renderPrefix(),
                Expanded(
                  child: CupertinoSlider(
                    value: _currentValue,
                    min: widget.min,
                    max: widget.max,
                    divisions: widget.divisions,
                    activeColor: widget.activeColor,
                    thumbColor: widget.thumbColor,
                    onChanged: (value) {
                      widget.onChanged(value);
                      _currentValue = value;
                      setState(() {

                      });
                    },
                  ),
                ),
                renderSuffix()
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget renderPrefix() {
    return WidgetUtil.createWidget(widget.prefix);
  }

  Widget renderSuffix() {
    return WidgetUtil.createWidget(widget.suffix);
  }

}