class PickerItem {

  final dynamic key;
  final String value;
  final String label;

  PickerItem(this.value, this.label, this.key);

  @override
  String toString() {
    return 'PickerItem{key: $key, value: $value, label: $label}';
  }


}