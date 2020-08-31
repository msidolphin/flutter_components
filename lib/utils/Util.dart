import 'package:url_launcher/url_launcher.dart';

import '../model/IdLabel.dart';

typedef Compare<T> = bool Function(T item);

class Util {

  static bool isNotEmpty(value) {
    return !isEmpty(value);
  }

  static bool isEmpty(value) {
    if (value == null) return true;
    if (value is String) return value.isEmpty;
    if (value is List) return value.isEmpty;
    if (value is Map) return value.isEmpty;
    if (value is Set) return value.isEmpty;
    return false;
  }

  /// key == null or key is empty
  /// {"0": 1, "1": 2}
  /// key != null and key is not empty
  /// {"key[0]": 1, "key[1]": 2}
  static Map<String, T> listToMap<T>(List<T> list, {String key = ""}) {
    Map<String, T> map = new Map();
    if (list == null) return map;
    if (key == null) key = "";
    key = key.trim();
    for (int i = 0; i < list.length; ++i) {
      final value = list[i];
      if (value is Map) {
        value.keys.forEach((k) {
          map['$key${key.isEmpty ? "" : "["}$i${key.isEmpty ? "" : "]"}' + ".$k"] = value[k];
        });
      } else {
        map['$key${key.isEmpty ? "" : "["}$i${key.isEmpty ? "" : "]"}'] = value;
      }
    }
    return map;
  }

  static Map<String, dynamic> idLabelToMap(List<IdLabel> list, {String root = "0"}) {
    Map<String, dynamic> data = new Map();
    Map<String, dynamic> root = new Map();
    data['0'] = root;
    list.forEach((item) {
      root[item.id] = item.label;
    });
    return data;
  }

  static List<T> filter<T>(List<T> list, Compare<T> compare) {
    List<T> newList = new List();
    list.forEach((it) {
      if (compare(it)) newList.add(it);
    });
    return newList;
  }

  static void launchUrl(String path) async {
    if (await canLaunch(path)) {
      await launch(path);
    }
  }

}