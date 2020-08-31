import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../catalogpicker/CatalogPickerItem.dart';
import '../i18n/i18n.dart';
import '../picker/PickerRoute.dart';
import '../picker/theme/PickerTheme.dart';
import '../utils/ColorUtil.dart';
import '../utils/Gaps.dart';

typedef ValueChanged(List<String> value, List<String> text);

class CatalogPicker {


  static void show(BuildContext context, {
    @required Map<String, dynamic> dataSource,
    String root = 'top',
    int limit = 0,
    @required List<String> value,
    VoidCallback onExceed,
    @required ValueChanged onConfirm,
    PickerTheme theme,
    FlatLocale locale = FlatLocale.zh_cn
  }) {
    assert(dataSource != null);
    if (theme == null) {
      theme = PickerTheme.Default.copyWiths(pickerHeight: 300);
    }
    List<String> values = [];
    List<String> texts = [];
    PickerRoute route = PickerRoute(
        pickerTheme: theme,
        locale: locale,
        onConfirm: () {
          if (onConfirm != null) {
            onConfirm(values, texts);
          }
          Navigator.pop(context);
        },
        onCancel: () {
          Navigator.pop(context);
        },
        child: CatalogPickerWidget(
            value: value,
            dataSource: dataSource,
            root: root,
            limit: limit,
            onExceed: onExceed,
            onChanged: (value, text) {
              values = value;
              texts = text;
            },
            locale: locale,
        ),
    );
    FocusScope.of(context).unfocus();
    Navigator.push(context, route);
  }

}


class CatalogPickerWidget extends StatefulWidget {

  final Map<String, dynamic> dataSource;
  
  final String root;

  final int limit;

  final List<String> value;

  final ValueChanged onChanged;

  final VoidCallback onExceed;

  final FlatLocale locale;

  const CatalogPickerWidget({
    Key key,
    this.root = '0',
    @required this.dataSource,
    this.limit = 0,
    @required this.value,
    @required this.onChanged,
    this.onExceed,
    this.locale = FlatLocale.en_us
  }) :
  assert(limit == null || limit >= 0),
  assert(value != null),
  super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CatalogPickerWidgetState();
  }


}

class _CatalogPickerWidgetState extends State<CatalogPickerWidget>
 with SingleTickerProviderStateMixin {

  List<CatalogPickerItem> primary;
  List<CatalogPickerItem> secondary;
  String currentPrimary;
  List<String> selected;
  List<String> text;
  AnimationController ac;
  Animation<double> scaleTween;

  @override
  void initState() {
    initPrimaryData();
    setDefaultValues();
    ac = new AnimationController(vsync: this, duration: const Duration(milliseconds: 200));
    scaleTween = new Tween<double>(begin: 0, end: 1.0).animate(ac);
    ac.addListener(() {
      setState(() {
      });
    });
    ac.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            renderHeader(context),
            Expanded(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Container(
                      color: ColorUtil.insideBackground,
                      child: ListView(
                        children: renderPrimaryColumn(context)
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: ListView(
                      children: renderSecondaryColumn(context),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


  void initPrimaryData() {
    primary = new List();
    // primary
    Map<String, dynamic> data = widget.dataSource[widget.root];
    generateColumn(primary, data);
    currentPrimary = primary[0].value;
    getSecondaryData(primary[0].value);
  }

  void setDefaultValues() {
    selected = List();
    selected = List<String>.generate(
      widget.value.length,
          (index) => widget.value[index],
      growable: true,
    );
    text = new List();
    selected.forEach((item) {
      text.add(getLabelByValue(item));
    });
    widget.onChanged(selected, text);
  }
  
  void getSecondaryData(String root) {
    secondary = new List();
    Map<String, dynamic> data = widget.dataSource[root];
    generateColumn(secondary, data);
    setState(() {});
  }

  void generateColumn (List<CatalogPickerItem> columns,
      Map<String, dynamic> dataSource) {
    dataSource.forEach((String key, value) {
      columns.add(new CatalogPickerItem(key, value));
    });
  }
  
  List<Widget> renderPrimaryColumn(BuildContext context) {
    return primary.map((CatalogPickerItem item) {
      Color color = currentPrimary == item.value ? Colors.white : ColorUtil.insideBackground;
      return GestureDetector(
        onTap: () {
          setState(() {
            if (currentPrimary == item.value) return;
            currentPrimary = item.value;
            getSecondaryData(currentPrimary);
            ac.reset();
            ac.forward();
          });
        },
        child: Container(
          decoration: BoxDecoration(
            color: color,
            border: Border(
              bottom: BorderSide(
                width: 0.5,
                color: ColorUtil.insideBackground
              )
            )
          ),
          alignment: Alignment.center,
          height: 40,
          child: Container(
            alignment: Alignment.centerLeft,
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Text(item.label,
                    overflow: TextOverflow.ellipsis,
                  )
                ),
                currentPrimary == item.value ? Positioned(
                  left: 0,
                  top: 0,
                  bottom: 0,
                  child: ScaleTransition(
                    scale: scaleTween,
                    child: Container(
                      width: 3,
                      color: Theme.of(context).primaryColor,
                  ),
                )): Gaps.empty,
              ],
            ),
          )
        ),
      );
    }).toList();
  }

  List<Widget> renderSecondaryColumn(BuildContext context) {
    return secondary.map((CatalogPickerItem item) {
      bool isSelected = findIndex(item.value) >= 0;
      return Material(
        color: Colors.white,
        child: InkWell(
          onTap: () {
            onTapSecondaryItem(item.value);
          },
          child: Container(
            height: 40,
            padding: EdgeInsets.only(left: 10, right: 10),
            alignment: Alignment.centerLeft,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Text(item.label,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                    color: isSelected ? Theme.of(context).primaryColor : ColorUtil.regularText
                  ),),
                ),
                isSelected ? Icon(Icons.check, size: 16, color: Theme.of(context).primaryColor,) : Gaps.empty
              ],
            ),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 0.5,
                  color: Theme.of(context).dividerColor
                )
              )
            ),
          ),
        ),
      );
    }).toList();
  }

  void onTapSecondaryItem(String item) {
    int index = findIndex(item);
    if (index >= 0) {
      selected.removeAt(index);
    }
    else {
      if (widget.limit == null || widget.limit == 0 || selected.length < widget.limit) {
        selected.add(item);
      }
      else {
        if (widget.limit != null && widget.limit > 0 && widget.onExceed != null) {
          widget.onExceed();
        }
        return;
      }
    }
    text = new List();
    selected.forEach((item) {
      text.add(getLabelByValue(item));
    });
    widget.onChanged(selected, text);
    setState(() {});
  }
  
  int findIndex(String item) {
    for (int i = 0; i < selected.length; ++i) {
      if (item == selected[i]) return i;
    }
    return -1;
  }

  Widget renderHeader(BuildContext context) {
    return Container(
      color: ColorUtil.insideBackground,
      padding: EdgeInsets.only(left: 10),
      height: 50,
      child: Row(
        children: <Widget>[
          Text(I18n.getCatalogPickerChoseText(widget.locale), style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500
            )
          ),
          Text('（${selected != null ? selected.length : 0}${widget.limit != null && widget.limit > 0 ? "/" + widget.limit.toString() : ""}）',
            style: TextStyle(
              fontSize: 12,
              color: Theme.of(context).primaryColor
            ),
          ),
          Expanded(child: renderTags())
        ],
      ),
    );
  }

  Widget renderTags () {
    return Container(
      height: 32,
      child: ListView(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: selected.map((item) {
          String label = getLabelByValue(item);
          return _Tag(
            label: label,
            onClosed: () {
              int index = findIndex(item);
              if (index >= 0) {
                selected.removeAt(index);
                text = new List();
                selected.forEach((item) {
                  text.add(getLabelByValue(item));
                });
                widget.onChanged(selected, text);
              }
              setState(() {});
            },
          );
        }).toList()
      ),
    );
  }

  String getLabelByValue(String value) {
    for (int i = 0; i < primary.length; ++i) {
      String root = primary[i].value;
      Map<String, dynamic> data = widget.dataSource[root];
      List<String> keys = data.keys.toList();
      for (int j = 0; j < keys.length; ++j) {
        String key = keys[j];
        if (key == value) return data[key];
      }
    }
    return "";
  }

  @override
  void dispose() {
    ac.dispose();
    super.dispose();
  }

}

class _Tag extends StatelessWidget {

  final String label;

  final VoidCallback onClosed;

  const _Tag({
    Key key,
    this.label,
    this.onClosed
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        this.onClosed();
      },
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.only(left: 10, right: 10),
        margin: EdgeInsets.only(right: 10),
        alignment: Alignment.center,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(label,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
              color: Theme.of(context).primaryColor
            ),),
            Icon(
              Icons.close,
              size: 10,
              color: Theme.of(context).primaryColor,
            ),
          ],
        ),
      ),
    );
  }


}