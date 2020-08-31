part of 'ViewportUtil.dart';

extension ViewportUtilExtension on num {

  num get w => ViewportUtil().setWidth(this);

  num get h => ViewportUtil().setHeight(this);

}