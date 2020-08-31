import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

part 'ViewportUtilExtension.dart';

class ViewportUtil {

  static void init(BuildContext context) {
    ScreenUtil.init(context, width: 750, height: 1334);
  }

  static ViewportUtil of(BuildContext context) {
    ScreenUtil.init(context, width: 750, height: 1334);
    return ViewportUtil();
  }

  double setWidth(int width) {
    return ScreenUtil().setWidth(width);
  }

  double setHeight(int height) {
    return ScreenUtil().setHeight(height);
  }

  static double statusBarHeight(BuildContext context) {
    return MediaQuery.of(context).padding.top;
  }

}