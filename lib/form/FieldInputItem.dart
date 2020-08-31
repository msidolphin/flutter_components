import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../form/RawFieldItem.dart';
import '../form/enum/FieldInputType.dart';
import '../list/AbstractListItem.dart';
import '../utils/StringUtil.dart';
import '../utils/Ui.dart';
import '../utils/ViewportUtil.dart';
import '../utils/WidgetUtil.dart';

import '../utils/ThemeColorUtil.dart';
import 'formatter/NumberInputFormatter.dart';

// ignore: must_be_immutable
class FieldInputItem extends AbstractListItem {

  final String label;

  /// width of label
  final double labelWidth;

  /// type of input
  final FieldInputType type;

  /// content to be appear when the value is blank
  final String placeholder;

  /// initial value
  final String value;

  /// maximum number characters of value
  final int maxLength;

  /// max lines of input widget
  final int maxLines;

  final ValueChanged<String> onChanged;

  final VoidCallback onBlur;

  final VoidCallback onFocused;

  /// whether to show clear button
  final bool clearable;

  /// auto focus
  final bool autoFocus;

  final bool readOnly;

  final bool disabled;

  /// precision of input value
  final int precision;

  final Widget leading;

  final Widget trailing;

  final CrossAxisAlignment align;

  final bool showWordLimit;


  FieldInputItem({
    GlobalKey<FieldInputItemState> key,
    this.label,
    this.labelWidth,
    this.type = FieldInputType.text,
    @required this.value,
    this.maxLength,
    @required this.onChanged,
    this.clearable = true,
    this.placeholder,
    this.autoFocus = false,
    this.readOnly = false,
    this.disabled = false,
    this.precision = 2,
    this.leading,
    this.trailing,
    this.onBlur,
    this.onFocused,
    this.maxLines = 1,
    this.align = CrossAxisAlignment.center,
    this.showWordLimit = false
  }) :
//  assert(onChanged != null),
  super(key: key);

  @override
  State<StatefulWidget> createState() {
    return FieldInputItemState();
  }

}

class FieldInputItemState extends State<FieldInputItem>
    with AutomaticKeepAliveClientMixin, WidgetsBindingObserver {

  TextEditingController controller;

  FocusNode focusNode;

  bool focused;

  String _currentValue;

  @override
  void initState() {
    super.initState();
    focused = widget.autoFocus;
    controller = new TextEditingController(
        text: widget.value
    );
    _currentValue = widget.value != null ? widget.value : "";
    focusNode = new FocusNode();
    focusNode.addListener(() {
      setState(() {
        focused = focusNode.hasFocus;
        if (focused && widget.onFocused != null) {
          widget.onFocused();
        }
        if (!focused && widget.onBlur != null) {
          widget.onBlur();
        }
      });
    });
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return RawFieldItem(
      leading: widget.leading,
      trailing: widget.trailing,
      isLast: widget.isLast,
      verticalPadding: widget.maxLines == 1 ? 0 : 12,
      child: Row(
        crossAxisAlignment: widget.align,
        children: <Widget>[
          _renderLabel(),
          _renderInput(),
          _renderClearButton()
        ],
      ),
    );
  }

  Widget _renderLabel () {
    if (StringUtil.isNotBlank(widget.label)) {
      return Container(
        width: widget.labelWidth,
        margin: EdgeInsets.only(right: 15),
        child: Text(widget.label,
          style: TextStyle(
            fontSize: 28.w,
            color: ThemeColorUtil.titleTextColor(context)
          ),
        ),
      );
    }
    return WidgetUtil.emptyWidget();
  }

  Widget _renderInput () {
    return Expanded(
      child: TextFormField(
        keyboardType: _getInputType(),
        focusNode: focusNode,
        obscureText: widget.type == FieldInputType.password,
        controller: controller,
        readOnly: widget.readOnly,
        autofocus: widget.autoFocus,
        enabled: !widget.disabled,
        maxLines: widget.maxLines,
        onChanged: (value) {
          if (_currentValue == value) return;
          _currentValue = value;
          widget.onChanged(value);
        },
        style: TextStyle(
            fontSize: 28.w,
            textBaseline: TextBaseline.alphabetic
        ),
        cursorColor: Ui.isDarkMode(context) ? Colors.white : Theme.of(context).primaryColor,
        decoration: InputDecoration(
          counterStyle: null,
          // hidden counter
          counterText: !widget.showWordLimit ? "" : null,
          hintText: widget.placeholder,
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(0),
        ),
        maxLength: widget.maxLength,
        // interceptors digitsOnly phone email url
        inputFormatters: _getInputFormatter()
      ),
    );
  }

  Widget _renderClearButton () {
    if (widget.clearable && StringUtil.isNotBlank(widget.value) && focused) {
      return GestureDetector(
        onTap: () {
          setState(() {
            controller.clear();
            widget.onChanged("");
          });
        },
        child: Icon(Icons.clear, color: Colors.grey,),
      );
    }
    return WidgetUtil.emptyWidget();
  }

  List<TextInputFormatter> _getInputFormatter () {
    switch(widget.type) {
      case FieldInputType.text:
        return null;
      case FieldInputType.number:
        return [PrecisionLimitFormatter(widget.precision)];
      case FieldInputType.digit:
        return [WhitelistingTextInputFormatter.digitsOnly];
      default:
        return null;
    }
  }

  TextInputType _getInputType() {
    switch(widget.type) {
      case FieldInputType.text:
        return TextInputType.text;
      case FieldInputType.number:
        return TextInputType.numberWithOptions(decimal: true);
      case FieldInputType.digit:
        return TextInputType.number;
      case FieldInputType.password:
        return TextInputType.visiblePassword;
      default:
        return TextInputType.text;
    }
  }

  void setValue(String value) {
    if (_currentValue == value) return;
    _currentValue = value;
    controller.text = value;
    Future.delayed(Duration(milliseconds: 20), () {
      controller.selection = TextSelection.fromPosition(
          TextPosition(
              affinity: TextAffinity.downstream,
              offset: value.length
          )
      );
    });
    widget.onChanged(value);
  }


  @override
  void dispose() {
    controller.dispose();
    focusNode.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (!focused) return;
    // 解决应用再次被唤醒时内容恢复为上一次结果的问题
    if (state == AppLifecycleState.inactive) {
      controller.text = _currentValue;
      controller.selection = TextSelection.fromPosition(
          TextPosition(
              affinity: TextAffinity.downstream,
              offset: _currentValue.length
          )
      );
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  bool get wantKeepAlive => true;


}