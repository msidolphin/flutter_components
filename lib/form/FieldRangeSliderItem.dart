import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// ignore: implementation_imports
import 'package:flutter/src/widgets/framework.dart';
import '../form/FieldItemMixin.dart';
import '../form/RawFieldItem.dart';
import '../list/AbstractListItem.dart';
import '../utils/ColorUtil.dart';
import '../utils/WidgetUtil.dart';

// ignore: must_be_immutable
class FieldRangeSliderItem extends AbstractListItem {

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

  final ValueChanged<RangeValues> onChanged;

  FieldRangeSliderItem({
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
    return _FieldRangeSliderItemState();
  }


}

class _FieldRangeSliderItemState extends State<FieldRangeSliderItem>
    with FieldItemMixin {

  @override
  Widget build(BuildContext context) {
    return RawFieldItem(
      isLast: widget.isLast,
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
                  child: SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      trackHeight: 2,
                      activeTrackColor: Theme.of(context).primaryColor,
                      inactiveTrackColor: ColorUtil.insideBackground,
//                      Color disabledActiveTrackColor,
//                      Color disabledInactiveTrackColor,
//                      activeTickMarkColor: Colors.black,
//                      Color inactiveTickMarkColor,
//                      Color disabledActiveTickMarkColor,
//                      Color disabledInactiveTickMarkColor,
//                      Color thumbColor,
                        overlappingShapeStrokeColor: Colors.blue,
//                      Color disabledThumbColor,
//                        overlayColor: Colors.blue,
//                      Color valueIndicatorColor,
//                        SliderComponentShape overlayShape,
//                      SliderTickMarkShape tickMarkShape,
//                      SliderComponentShape thumbShape,
//                      SliderTrackShape trackShape,
//                      SliderComponentShape valueIndicatorShape,
//                      RangeSliderTickMarkShape rangeTickMarkShape,
//                      RangeSliderThumbShape rangeThumbShape,
//                      RangeSliderTrackShape rangeTrackShape,
//                      RangeSliderValueIndicatorShape rangeValueIndicatorShape,
//                      ShowValueIndicator showValueIndicator,
//                      TextStyle valueIndicatorTextStyle,
//                      double minThumbSeparation,
//                      RangeThumbSelector thumbSelector,
                    ),
                    child: RangeSlider(
                      values: RangeValues(0, widget.value),
                      min: widget.min,
                      max: widget.max,
                      divisions: widget.divisions,
                      activeColor: widget.activeColor,
                      onChanged: (value) {
//                      widget.onChanged(value);
                      },
                    ),
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