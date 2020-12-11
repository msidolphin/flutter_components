import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../i18n/i18n.dart';
import '../picker/theme/PickerTheme.dart';
import 'package:uuid/uuid.dart';
import '../utils/ThemeColorUtil.dart';
import '../utils/Ui.dart';
import 'PickerRoute.dart';
import 'layout/PickerTitile.dart';
import 'model/PickerColumn.dart';
import 'model/PickerItem.dart';

typedef OnPickerValueChanged(List<String> value, List<String> text);

class Picker {

  static void showAreaPicker(BuildContext context, {
    List<String> value,
    int level = 3,
    OnPickerValueChanged onConfirm,
    PickerTheme theme = PickerTheme.Default,
    FlatLocale locale = FlatLocale.zh_cn
  }) async {
    String data = await rootBundle.loadString("packages/flutter_components/picker/data/china_area.json");
    Map<String, dynamic> jsonData = json.decode(data);
    show(
        context,
        dataSource: jsonData,
        level: level,
        root: '86',
        onConfirm: onConfirm,
        value: value
    );
  }

  static void show(BuildContext context, {
    @required Map<String, dynamic> dataSource,
    @required int level,
    String root = '0',
    String title = "",
    List<String> value,
    OnPickerValueChanged onConfirm,
    PickerTheme theme = PickerTheme.Default,
    FlatLocale locale = FlatLocale.zh_cn,
    bool useCupertinoStyle
  }) {
    assert(level != null);
    assert(dataSource != null);
    List<String> values = [];
    List<String> texts = [];
    FocusScope.of(context).unfocus();
    double height = theme.pickerHeight;
    if (theme.title != null || theme.showTitle) {
      height += theme.titleHeight;
    }
    final pickerWidget = _create(
        value: value,
        dataSource: dataSource,
        level: level,
        root: root,
        onChanged: (value, text) {
          values = value;
          texts = text;
        }
    );
    final pickerHeader = PickerTitle(
      locale: locale,
      pickerTheme: theme,
      onConfirm: () {
        if (onConfirm != null) {
          onConfirm(values, texts);
        }
        Navigator.pop(context);
      },
      onCancel: () {
        Navigator.pop(context);
      },
      title: title,
    );
    final picker = Material(
      child: Container(
        height: height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            pickerHeader,
            Expanded(
                child: pickerWidget
            )
          ],
        ),
      ),
    );
    if (useCupertinoStyle == null) {
      Ui.showBottomSheet(context, builder: (context, controller) {
        return picker;
      });
    } else if (useCupertinoStyle) {
      Ui.showCupertinoBottomSheet(context, builder: (context, controller) {
        return picker;
      });
    } else {
      Ui.showMaterialBottomSheet(context, builder: (context, controller) {
        return picker;
      });
    }
  }

  static Widget _create({
    List<String> value,
    Map<String, dynamic> dataSource,
    int level,
    OnPickerValueChanged onChanged,
    String root = '0'
  }) {
    return _PickerWidget(
      value: value,
      dataSource: dataSource,
      level: level,
      onChanged: onChanged,
      root: root,
    );
  }

}

// ignore: must_be_immutable
class _PickerWidget extends StatefulWidget {

  List<String> value;

  Map<String, dynamic> dataSource;

  final int level;

  final OnPickerValueChanged onChanged;

  final String root; // 根节点id

  final PickerTheme pickerTheme;


  _PickerWidget({
    this.root = "0",
    this.level,
    this.onChanged,
    this.value,
    @required this.dataSource,
    this.pickerTheme = PickerTheme.Default
  });

  @override
  State<StatefulWidget> createState() {
    return new _PickerWidgetState(
      value: value,
      dataSource: dataSource,
      root: root,
      level: level,
      pickerTheme: pickerTheme,
      onChanged: onChanged
    );
  }

}

class _PickerWidgetState extends State<_PickerWidget> {

  final PickerTheme pickerTheme;

  final int level;

  final OnPickerValueChanged onChanged;

  final String root; // 根节点id

  List<String> value;

  List<PickerColumn> columns;

  Map<String, FixedExtentScrollController> controllerMap;

  List<FixedExtentScrollController> controllerList;

  Map<String, dynamic> dataSource;

  Map<int, String> keyMap;

  Uuid _uuid;

  List<String> _text;

  _PickerWidgetState({
    this.value,
    @required this.dataSource,
    this.root = "0",
    this.level,
    this.onChanged,
    this.pickerTheme = PickerTheme.Default
  }) {
    _uuid = new Uuid();
    createPickerColumn(value);
  }

  @override
  void initState() {
    super.initState();
  }

  List<PickerColumn> createPickerColumn (List<String> value, {bool setState = false }) {
    if (value == null) value = [];
    if (!setState) {
      // 初始化
      controllerMap = new Map();
      controllerList = [];
    }
    List<int> index = [];
    List<String> $value = [];
    List<PickerColumn> columns = [];
    String pid = this.root;
    for (int i = 0; i < level; ++i) {
      PickerColumn pickerView = new PickerColumn();
      List<PickerItem> column = [];
      String key = getKey(i);
      Map<String, dynamic> data = dataSource[pid];
      generateColumn(column, data, key);
      pickerView.items = column;
      columns.add(pickerView);
      pid = value.length > i ? value[i] : column[0].value;
      $value.add(pid);
      int idx = _getIndex(pid, column);
      if (!setState) {
        FixedExtentScrollController controller = new FixedExtentScrollController(
            initialItem: idx
        );
        controllerMap[key] = controller;
        controllerList.add(controller);
      }
      index.add(idx);
    }
    this.value = $value;
    this.columns = columns;
    this._text = getText();
    if (!setState && this.onChanged != null) {
      this.onChanged(this.value, _text); // 防止不选择直接点击确定
    }
    return columns;
  }

  String getKey(int level) {
    if (keyMap == null) keyMap = new Map();
    String key = keyMap[level];
    if (key == null) {
      key = _uuid.v4();
      keyMap[level] = key;
    }
    return key;
  }

  List<String> getText() {
    List<String> text = [];
    for (int i = 0; i < this.level; ++i) {
      for (int j = 0; j < this.columns[i].items.length; ++j) {
        if (this.columns[i].items[j].value == this.value[i]) {
          text.add(this.columns[i].items[j].label);
        }
      }
    }
    return text;
  }

  void generateColumn (List<PickerItem> columns,
      Map<String, dynamic> dataSource,
      String id) {
    dataSource.forEach((String key, value) {
      columns.add(new PickerItem(key, value.toString(), id));
    });
  }

  int _getIndex (String value, List<PickerItem> items) {
    for (int i = 0; i < items.length; ++i) {
      if (value == items[i].value) return i;
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    return render();
  }

  Widget renderColumn (List<PickerItem> column, index) {
    return Expanded(
      flex: 1,
      child: Container(
//        padding: EdgeInsets.all(8.0), // 每列之间的间隙
        height: pickerTheme.pickerHeight,
        decoration: BoxDecoration(color: ThemeColorUtil.backGroundColor(context)),
        child: CupertinoPicker.builder(
          useMagnifier: true,
          magnification: 1.05,
          backgroundColor: ThemeColorUtil.backGroundColor(context),
          scrollController: this.controllerList[index],
          itemExtent: pickerTheme.itemHeight,
          onSelectedItemChanged: (int index) {
            PickerItem item = column[index];
            int level = getLevelByColumnKey(item.key);
            // 下级列归零
            List<String> values = this.value.sublist(0, level);
            values.add(item.value);
            for (int i = level + 1; i < controllerList.length; ++i) {
              controllerList[i].jumpTo(0);
            }
            setState(() {
              createPickerColumn(values, setState: true);
              if (this.onChanged != null) {
                this.onChanged(this.value, this._text);
              }
            });
          },
          childCount: column.length,
          itemBuilder: (context, index) {
            return Container(
              height: 36,
              padding: EdgeInsets.only(left: 4, right: 4),
              alignment: Alignment.center,
              child: new Text(
                column[index].label,
                overflow: TextOverflow.ellipsis,
                style: Ui.isDarkMode(context) ? pickerTheme.itemTextStyle.copyWith(
                  color: Colors.white
                ) : pickerTheme.itemTextStyle
              ),
            );
          }
        ),
      ),
    );
  }

  int getLevelByColumnKey (String key) {
    FixedExtentScrollController controller = controllerMap[key];
    return controllerList.indexOf(controller);
  }

  Widget render () {
    List<PickerColumn> columns = this.columns;
    List<Widget> picker = [];
    for (int i = 0; i < columns.length; ++i) {
      picker.add(renderColumn(columns[i].items, i));
    }
    return Row(
      children: picker,
    );
  }

}