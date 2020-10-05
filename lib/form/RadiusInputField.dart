import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utils/ColorUtil.dart';
import 'enum/FormInputType.dart';
import 'formatter/NumberInputFormatter.dart';
typedef ValueDisabled();

class RadiusInputField extends StatefulWidget {
  final ValueChanged<String> onChanged;
  final ValueDisabled onDisabled;
  final VoidCallback onBlur;
  final VoidCallback onFocused;
  final int maxLength;
  final String value;
  final double width;
  final double height;
  final double radius;
  final bool readOnly;
  final String placeholder;
  final FormInputType type;
  final bool disabled;
  final int precision;
  final bool clearable;
  final bool autoFocus;
  final int maxLines;
  final Color backgroundColor;
  final TextEditingController controller;
  final TextStyle style;


  const RadiusInputField({
    Key key,
    @required this.width,
    @required this.height,
    @required this.radius,
    this.onChanged,
    this.maxLength,
    this.value,
    this.readOnly = false,
    this.placeholder = "请输入",
    this.type = FormInputType.text,
    this.disabled = false,
    this.precision = 2,
    this.clearable = false,
    this.onFocused,
    this.autoFocus = false,
    this.onBlur,
    this.maxLines = 1,
    this.backgroundColor,
    this.onDisabled,
    @required this.controller,
    this.style,
  }): super(key: key);

  @override
  _RadiusInputField createState() => _RadiusInputField(controller: controller);
}

class _RadiusInputField extends State<RadiusInputField>
    with  WidgetsBindingObserver{
  final TextEditingController controller;

  FocusNode focusNode;

  bool focused;

  String _currentValue;

  Color _backgroundColor;

  _RadiusInputField({this.controller});

  @override
  void initState() {
    super.initState();
    focused = widget.autoFocus;
    _backgroundColor = widget.backgroundColor == null ? ColorUtil.web('#F5F5F5') : widget.backgroundColor;
    _currentValue = controller?.text != null ? controller?.text : "";
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
    return Container(
      height: widget.height,
      width: widget.width,
      padding: EdgeInsets.only(left:10,right:10),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widget.radius),
          color: _backgroundColor
      ),
      child: _renderInput(),
    );
  }

  Widget _renderInput () {
    return TextFormField(
         onTap: widget.disabled ? () {
           widget.onDisabled();
         } : null,
        keyboardType: _getInputType(),
        focusNode: focusNode,
        obscureText: widget.type == FormInputType.password,
        controller: controller,
        readOnly: widget.disabled,
        textAlign: TextAlign.center,
        autofocus: widget.autoFocus,
        maxLines: widget.maxLines,
        onChanged: (value) {
          if (_currentValue == value) return;
          _currentValue = value;
          widget.onChanged(value);
        },
        style: widget.style == null ? TextStyle(
            fontSize: 14,
            textBaseline: TextBaseline.alphabetic
        ) : widget.style,
        cursorColor: Theme.of(context).primaryColor,
        decoration: InputDecoration(
          isDense: true,
          counterStyle: null,
          // hidden counter
          counterText: "",
          hintText: widget.placeholder,
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(0),
        ),
        maxLength: widget.maxLength,
        // interceptors digitsOnly phone email url
        inputFormatters: _getInputFormatter()
    );
  }

  List<TextInputFormatter> _getInputFormatter () {
    switch(widget.type) {
      case FormInputType.text:
        return null;
      case FormInputType.number:
        return [PrecisionLimitFormatter(widget.precision)];
      case FormInputType.digit:
        return [WhitelistingTextInputFormatter.digitsOnly];
      default:
        return null;
    }
  }

  TextInputType _getInputType() {
    switch(widget.type) {
      case FormInputType.text:
        return TextInputType.text;
      case FormInputType.number:
        return TextInputType.numberWithOptions(decimal: true, signed: false);
      case FormInputType.digit:
        return TextInputType.number;
      case FormInputType.password:
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
//    controller?.dispose();
    focusNode?.dispose();
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
}
