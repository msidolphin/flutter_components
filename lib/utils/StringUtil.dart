typedef bool Callback(Object e);

class StringUtil {

  static bool isBlank(String target) {
    return target == null || target.trim() == "";
  }

  static bool isNotBlank(String target) {
    return !isBlank(target);
  }

  static List<String> filter(List<String> list, Callback callback) {
    List<String> newList = [];
    list.forEach((e) {
      if (callback(e)) {
        newList.add(e);
      }
    });
    return newList;
  }



}