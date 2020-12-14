import 'package:flutter/material.dart';
import '../list/AbstractListItem.dart';
import '../list/ListTile.dart';
import '../utils/ThemeColorUtil.dart';
import '../utils/WidgetUtil.dart';


// ignore: must_be_immutable
class ListItem extends AbstractListItem {

  /// TODO 标题支持固定宽？
  final GestureTapCallback onPressed;
  final String title;
  final Widget subtitle;
  final Widget trailing;
  final Widget leading;
  final String icon;
  final double padding;
  final int maxLines;
  final CrossAxisAlignment align;
  final bool border;
  final Color arrowColor;
  final bool dense;
  final bool visible;

  ListItem({
    Key key,
    this.onPressed,
    this.dense = true,
    @required this.title,
    this.icon,
    this.leading,
    this.maxLines = 1,
    this.subtitle,
    this.trailing,
    this.padding = 12,
    this.align = CrossAxisAlignment.center,
    this.border = true,
    this.visible = true,
    this.arrowColor,
  }) : super(key: key);



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
        isLast: !widget.border ? true : widget.isLast,
        leading: widget.leading == null ? _renderLeading() : widget.leading,
        contentPadding: EdgeInsets.only(left: 12, right: 0),
        title: Container(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: widget.align,
            children: <Widget>[
              _renderHeading(context),
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
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            widget.title,
            style: TextStyle(
              color: ThemeColorUtil.titleTextColor(context),
              fontSize: 17
            ),
          ),
          WidgetUtil.createWidget(widget.subtitle),
        ],
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
  final String placeholder;
  final int maxLines;

  const ListItemTrailing({Key key, this.text, this.placeholder, this.maxLines = 2}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text == null || text.trim().isEmpty ? (placeholder != null && placeholder.isNotEmpty) ? placeholder : "" : text,
      overflow: TextOverflow.ellipsis,
      maxLines: maxLines,
      style: TextStyle(
        fontSize: 17,
        color: showPlaceholder() ? ThemeColorUtil.disabledColor(context) : ThemeColorUtil.subTitleTextColor(context)
      ),
    );
  }

  bool showPlaceholder() {
    return text == null || text.trim().isEmpty;
  }

}