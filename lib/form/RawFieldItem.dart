import 'package:flutter/cupertino.dart';
import '../list/ListTile.dart';

class RawFieldItem extends StatelessWidget {

  final Widget child;

  final double verticalPadding;

  final bool isLast;

  final Widget leading;

  final Widget trailing;

  final VoidCallback onPressed;

  const RawFieldItem({
    Key key,
    @required this.child,
    this.verticalPadding = 0,
    this.isLast = false,
    this.leading,
    this.trailing,
    this.onPressed
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return $ListTile(
      onTap: this.onPressed,
      leading: leading,
      trailing: trailing,
      dense: true,
      isLast: isLast,
      contentPadding: EdgeInsets.only(left: 15, right: 0),
      minVerticalPadding: verticalPadding,
      title: Container(
        padding: EdgeInsets.only(right: 15),
        child: child
      ),
    );
  }

}