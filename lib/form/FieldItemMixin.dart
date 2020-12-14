import 'package:flutter/cupertino.dart';
import '../utils/StringUtil.dart';
import '../utils/ThemeColorUtil.dart';
import '../utils/WidgetUtil.dart';

mixin FieldItemMixin {

  Widget renderLabel (String label, double labelWidth, BuildContext context) {
    if (StringUtil.isNotBlank(label)) {
      return Container(
        width: labelWidth,
        margin: EdgeInsets.only(right: 15),
        child: Text(label, style: TextStyle(fontSize: 17, color: ThemeColorUtil.titleTextColor(context),),),
      );
    }
    return WidgetUtil.emptyWidget();
  }


}