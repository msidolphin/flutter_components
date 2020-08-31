import 'PickerItem.dart';

class PickerColumn {

  List<PickerItem> _items;

  List<PickerItem> get items => _items;

  set items(List<PickerItem> value) {
    _items = value;
  }

  @override
  String toString() {
    return 'PickerColumn{_items: $_items}';
  }


}