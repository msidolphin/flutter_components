import 'package:flutter/cupertino.dart';

import 'DrawerRoute.dart';
import 'PopupPlacement.dart';

class Popup {

  static show (BuildContext context, {
    @required Widget child,
    PopupPlacement placement = PopupPlacement.bottom
  }) {
    DrawerRoute route = DrawerRoute(
      child: child,
      placement: placement
    );
    Navigator.of(context).push(route);
  }

  static close (BuildContext context) {
    Navigator.of(context).pop();
  }

}