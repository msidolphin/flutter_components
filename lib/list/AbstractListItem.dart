import 'package:flutter/cupertino.dart';

// ignore: must_be_immutable
abstract class AbstractListItem extends StatefulWidget {

  final Key key;

  bool isFirst = false;

  AbstractListItem({ this.key }): super(key: key);

}