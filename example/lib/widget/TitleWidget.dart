import 'package:flutter/cupertino.dart';

class TitleWidget extends  StatelessWidget {

  final String title;

  const TitleWidget({Key key, this.title = "标题"}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
      child: Text(
        title,
        style: TextStyle(
          color: Color(0xFF354052),
          fontSize: 20,
          fontWeight: FontWeight.w500
        ),
      ),
    );
  }

}