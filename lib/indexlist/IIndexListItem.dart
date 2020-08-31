import 'package:azlistview/azlistview.dart';

class IIndexListItem extends ISuspensionBean {

  String name;
  String tagIndex;
  String pinyin;
  String namePinyin;
  bool isLast;

  IIndexListItem({
    this.name,
    this.tagIndex,
    this.pinyin,
    this.isLast = false
  });

  IIndexListItem.fromJson(Map<String, dynamic> json)
      : name = json['name'] == null ? "" : json['name'];

  Map<String, dynamic> toJson() => {
    'name': name,
    'tagIndex': tagIndex,
    'pinyin': pinyin,
    'isShowSuspension': isShowSuspension,
    "isLast": isLast
  };

  @override
  String getSuspensionTag() => tagIndex;

  @override
  String toString() {
    return 'IIndexListItem{name: $name, tagIndex: $tagIndex, namePinyin: $pinyin, isLast: $isLast}';
  }


}