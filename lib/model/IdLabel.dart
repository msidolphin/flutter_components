class IdLabel {

  String _id;
  String _label;

  IdLabel({String id, String label}) {
    this._id = id;
    this._label = label;
  }

  String get id => _id;
  set id(String value) => _id = id;
  String get label => _label;
  set label(String label) => _label = label;

  IdLabel.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _label = json['label'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value'] = this._id;
    data['label'] = this._label;
    return data;
  }

  @override
  String toString() {
    return 'IdLabel{_id: $_id, _label: $_label}';
  }

}