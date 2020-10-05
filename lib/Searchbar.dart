import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import './utils/ThemeColorUtil.dart';

class SearchBar extends StatefulWidget {

  const SearchBar({
    Key key,
    this.onChanged,
    this.autoFocus = false,
    this.placeholder,
    this.focusNode, this.action, this.onSubmitted
  }) : super(key: key);

  final ValueChanged<String> onChanged;
  final bool autoFocus;
  final String placeholder;
  final FocusNode focusNode;
  final TextInputAction action;
  final ValueChanged<String> onSubmitted;

  @override
  State<StatefulWidget> createState() {
    return _SearchBarState();
  }

}


class _SearchBarState extends State<SearchBar> with WidgetsBindingObserver {

  TextEditingController controller;

  String _currentValue = "";

  @override
  void initState() {
    _currentValue = "";
    controller = new TextEditingController(
      text: _currentValue
    );
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }


    @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: ThemeColorUtil.backGroundColor(context),
        borderRadius: BorderRadius.circular(18)
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.search, size: 20, color: Color(0xffbbbbbb),),
          SizedBox(width: 9,),
          Expanded(
            child: TextField(
              controller: controller,
              autofocus: widget.autoFocus,
              cursorColor: ThemeColorUtil.primaryTextColor(context),
              textInputAction: widget.action,
              decoration: InputDecoration(
                  hintText: widget.placeholder,
                  isDense: true,
                  contentPadding: EdgeInsets.all(0),
                  border: InputBorder.none
              ),
              onChanged: (value) {
                if (_currentValue == value) return;
                widget.onChanged(value);
                _currentValue = value;
              },
              onSubmitted: widget.onSubmitted,
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    controller?.removeListener(() {});
    controller?.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
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