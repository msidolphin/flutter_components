import 'package:flutter/cupertino.dart';

class FlatMargin extends EdgeInsets {

  FlatMargin(double p1, [double p2, double p3, double p4])
      : super.fromLTRB((p4 != null ? p4 : (p2 != null ? p2 : (p3 != null ? p3 : p1))),
      p1,
      (p3 != null ? p2 : (p2 != null ? p2 : p1)),
      (p3 != null ? p3 : p1));

}