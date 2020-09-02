import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_components/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'assets/svg/ResultPageSvgLib.dart';
import 'assets/svg/ResultPageSvgLib.dart';
import 'utils/Gaps.dart';
import 'utils/Util.dart';

class ResultPage extends StatelessWidget {

  final String title;

  final String subtitle;

  final ResultPageType type;



  const ResultPage({Key key,
    this.title,
    this.subtitle,
    this.type = ResultPageType.success
  }) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 32, horizontal: 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(54),
            ),
            child: SvgPicture.string(ResultPageSvgLib.RESULT_PAGE_ICONS[type.index]),
          ),
          SizedBox(height: 24,),
          Util.isNotEmpty(title) ? Text(title, style: TextStyle(
              color: ThemeColorUtil.titleTextColor(context),
              fontSize: 18
          ),) :  Gaps.empty,
          SizedBox(height: 8,),
          Util.isNotEmpty(subtitle) ?  Text(subtitle, style: TextStyle(
            color: ThemeColorUtil.subTitleTextColor(context),
            fontSize: 13,
          ),
            textAlign: TextAlign.center,) : Gaps.empty,
        ],
      ),

    );
  }

}

enum ResultPageType {
   success,
   warning,
   info,
   error,
   waited
}