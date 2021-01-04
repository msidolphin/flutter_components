import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

void prefetch () {
  compute((message) {
    rootBundle.loadString("packages/flutter_components/picker/data/china_area.json");
  }, 'china-area');
}
