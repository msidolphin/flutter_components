import 'package:flutter/material.dart';
import '../list/AbstractListItem.dart';
import '../list/ListTile.dart';
import '../utils/ThemeColorUtil.dart';
import '../utils/WidgetUtil.dart';


// ignore: must_be_immutable
class ListItem extends AbstractListItem {

  /// TODO 标题支持固定宽？
  final GestureTapCallback onPressed;
  /// widget
  final dynamic title;
  final Widget trailing;
  final Widget leading;
  final String icon;
  final double leftPadding;
  final int maxLines;
  final CrossAxisAlignment align;
  final bool border;
  final Color arrowColor;
  final bool dense;
  final TextStyle titleStyle;

  ListItem({
    Key key,
    this.onPressed,
    this.dense = true,
    @required this.title,
    this.icon,
    this.leading,
    this.maxLines = 1,
    this.trailing,
    this.leftPadding = 12,
    this.align = CrossAxisAlignment.center,
    this.border = true,
    this.arrowColor,
    this.titleStyle,
  }) : assert(title != null && (title is Widget || title is String)), super(key: key);



  @override
  State<StatefulWidget> createState() {
    return _ListItemState();
  }


}


class _ListItemState extends State<ListItem> {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: $ListTile(
        dense: widget.dense,
        isFirst: !widget.border ? true : widget.isFirst,
        leading: widget.leading == null ? _renderLeading() : widget.leading,
        contentPadding: EdgeInsets.only(left: widget.leftPadding, right: 0),
        title: Container(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: widget.align,
            children: <Widget>[
              widget.title is Widget ? widget.title : _renderHeading(context),
              SizedBox(width: 15,),
              Expanded(child: Container(
                alignment: Alignment.centerRight,
                child: _renderTrailing(context),
              )),
            ],
          ),
        ),
        onTap: widget.onPressed != null ? widget.onPressed : null
      ),
    );
  }

  Widget _renderHeading(BuildContext context) {
    TextStyle style = TextStyle(
      color: ThemeColorUtil.titleTextColor(context),
      fontSize: 17,
    );
    if (widget.titleStyle != null) {
      style = style.merge(widget.titleStyle);
    }
    return Container(
      child: Text(
        widget.title,
        style: style,
      ),
    );
  }

  Widget _renderLeading() {
    if (widget.icon == null) return null;
    bool isNetworkImage = widget.icon.startsWith("http");
    bool isAsset = !isNetworkImage;
    return isAsset ? Image.asset(widget.icon, width: 20, height: 20) : Image.network(widget.icon, width: 20, height: 20);
  }

  Widget _renderTrailing (BuildContext context) {
    Widget arrow = Icon(
      Icons.arrow_forward_ios,
      color: widget.arrowColor == null ? ThemeColorUtil.subTitleTextColor(context) : widget.arrowColor,
      size: 12
    );
    if (widget.onPressed != null) {
      if (widget.trailing == null) {
        return Container(
          padding: EdgeInsets.only(right: 12),
          alignment: Alignment.centerRight,
          child: arrow,
        );
      } else {
        return Container(
            padding: EdgeInsets.only(left: 12, right: 12),
            constraints: BoxConstraints(
              maxWidth: 300
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Expanded(
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: widget.trailing,
                  ),
                ),
                arrow
              ],
            )
        );
      }
    } else {
      if (widget.trailing == null) {
        return new Text(" ");
      } else {
        return Container(
          alignment: Alignment.centerRight,
          padding: EdgeInsets.only(right: 12),
          child: widget.trailing
        );
      }
    }
  }

}




class ListItemTrailing extends StatelessWidget {

  final String text;
  final TextStyle textStyle;
  final String placeholder;
  final TextStyle placeholderStyle;
  final int maxLines;

  const ListItemTrailing(
      {Key key, this.text, this.placeholder, this.maxLines = 2,
    this.textStyle,
    this.placeholderStyle
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text == null || text.trim().isEmpty ? (placeholder != null && placeholder.isNotEmpty) ? placeholder : "" : text,
      overflow: TextOverflow.ellipsis,
      maxLines: maxLines,
      style: showPlaceholder() ? TextStyle(
        fontSize: 17,
        color: ThemeColorUtil.disabledColor(context)
      ).merge(placeholderStyle) : TextStyle(
        fontSize: 17,
        color: ThemeColorUtil.subTitleTextColor(context)
      ).merge(textStyle),
    );
  }

  bool showPlaceholder() {
    return text == null || text.trim().isEmpty;
  }

}