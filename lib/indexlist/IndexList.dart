import 'package:flutter/material.dart';
import 'package:azlistview/azlistview.dart';
import '../indexlist/IIndexListItem.dart';
import 'package:lpinyin/lpinyin.dart';

import '../utils/ThemeColorUtil.dart';

typedef Widget ItemBuilder<T extends IIndexListItem>(BuildContext context, T model);

/// from https://github.com/flutterchina/azlistview/blob/master/example/lib/demos/city_select.dart
class IndexList<T extends IIndexListItem> extends StatefulWidget {

  final List<T> dataSource;
  final List<T> topDataSource;
  final ItemBuilder itemBuilder;
  final Widget suspensionWidget;
  final ValueChanged<String> onSusTagChanged;
  final AzListViewHeader header;
  final int itemHeight;
  final double suspensionHeight;
  final ValueChanged<double> onScroll;

  const IndexList({
    Key key,
    @required this.dataSource,
    this.topDataSource,
    this.itemBuilder,
    this.suspensionWidget,
    this.onSusTagChanged,
    this.header,
    this.itemHeight = 50, this.suspensionHeight = 40, this.onScroll
  }) : super(key: key);

  static sortByPinyin(List<IIndexListItem> list) {
    if (list == null || list.isEmpty) return;
    for (int i = 0, length = list.length; i < length; i++) {
      /// 拼音库
      PinyinHelper.addPinyinDict(["曾=zēng"]);
      String pinyin = PinyinHelper.getPinyinE(list[i].name);
      String tag = pinyin.substring(0, 1).toUpperCase();
      list[i].pinyin = pinyin;
      list[i].namePinyin = '${list[i].name}${pinyin.toLowerCase().replaceAll(" ", "")}';
      if (RegExp("[A-Z]").hasMatch(tag)) {
        list[i].tagIndex = tag;
      } else {
        list[i].tagIndex = "#";
      }
    }
    SuspensionUtil.sortListBySuspensionTag(list);
    for (int i = 1; i < list.length; ++i) {
      if (list[i].tagIndex != list[i - 1].tagIndex) {
        list[i - 1].isLast = true;
      }
    }
  }

  @override
  State<StatefulWidget> createState() {
    return _IndexListState<T>();
  }
}

class _IndexListState<T extends IIndexListItem> extends State<IndexList> {

  String _suspensionTag = "";

  bool showIndexBar = true;

  ScrollController _scrollController;

  double _dy = 0;

  @override
  void initState() {
    if (widget.dataSource.length > 0) {
      setState(() {
        _suspensionTag = widget.dataSource[0].tagIndex;
      });
    }
    _scrollController = new ScrollController();
    if (widget.onScroll != null) {
      _scrollController.addListener(() {
        widget.onScroll(_scrollController.position.pixels);
      });
    }
    super.initState();
  }

  Widget _buildSusWidget(String susTag) {
    return Container(
      height: widget.suspensionHeight.toDouble(),
      padding: const EdgeInsets.only(left: 15.0),
      color: Color(0xfff3f4f5),
      alignment: Alignment.centerLeft,
      child: Text(
        '$susTag',
        softWrap: false,
        style: TextStyle(
          fontSize: 14.0,
          color: Color(0xff999999),
        ),
      ),
    );
  }

  Widget _buildListItem(T model) {
    String susTag = model.getSuspensionTag();
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Offstage(
          offstage: model.isShowSuspension != true,
          child: _buildSusWidget(susTag),
        ),
        InkWell(
          onTap: () {
            Navigator.pop(context, model);
          },
          child: Container(
            padding: EdgeInsets.only(left: 15),
            child: Container(
              alignment: Alignment.centerLeft,
              height: widget.itemHeight.toDouble(),
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(width: model.isLast ? 0 : 0.5, color: Theme.of(context).dividerColor)
                  )
              ),
              child: Text(model.name),
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: AzListView(
        controller: _scrollController,
        data: widget.dataSource,
        topData: widget.topDataSource,
        itemBuilder: (context,  model) {
          if (widget.itemBuilder != null) {
            return widget.itemBuilder(context, model);
          }
          return _buildListItem(model);
        },
        suspensionWidget: widget.suspensionWidget != null ? widget.suspensionWidget :  _buildSusWidget(_suspensionTag),
        isUseRealIndex: true,
        itemHeight: widget.itemHeight,
        suspensionHeight: widget.suspensionHeight.toInt(),
        onSusTagChanged: widget.onSusTagChanged != null ? widget.onSusTagChanged : _onSusTagChanged,
        header: widget.header,
        indexBarBuilder:(context, list, onTouch) {
          return IndexBar(
              onTouch: onTouch,
              data: list,
              itemHeight: 18,
              touchDownColor: Colors.transparent,
              touchDownTextStyle: TextStyle(
                fontSize: 12,
                color: ThemeColorUtil.primaryTextColor(context)
              ),
              textStyle: TextStyle(
                fontSize: 12,
                color: ThemeColorUtil.primaryTextColor(context)
              )
          );
        },
      ),
    );
  }

  void _onSusTagChanged(String tag) {
    setState(() {
      _suspensionTag = tag;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

}