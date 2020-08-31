import 'package:flutter/widgets.dart';
import '../list/AbstractListItem.dart';

// ignore: must_be_immutable
class FieldContainerItem extends AbstractListItem {

  final Widget child;

  FieldContainerItem({@required this.child});

  @override
  State<StatefulWidget> createState() {
    return _FieldContainerItemState();
  }


}

class _FieldContainerItemState extends State<FieldContainerItem> {

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: widget.child,
    );
  }


}