import 'package:flutter/cupertino.dart';
import 'package:flutter_components/widgets.dart';
import '../widget/TitleWidget.dart';

class ColorView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10,),
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TitleWidget(
                title: "Color 色彩",
              ),
              TitleWidget(title: "主色（用于标识品牌颜色）",),
              ColorItem(
                title: "主题色",
                color: ThemeColorUtil.primaryColor(context),
                subtitle: "#409BFF",
              ),
              Container(
                width: 330,
                height: 60,
                decoration: BoxDecoration(
                    gradient: ThemeColorUtil.primaryLineGradientColor(context),
                    borderRadius: BorderRadius.circular(8)
                ),
                child: ColorItem(
                  title: "渐变色，对角线渐变",
                  subtitle: "#409BFF ~ #1677FF",
                  isBottom: false,
                ),
              ),

            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TitleWidget(title: "辅助色（用于标识状态的按钮等）",),
              ColorItem(
                color: ThemeColorUtil.numberTextColor(context),
                title: "辅助按钮",
                subtitle: "#FF8F1F",
              ),
              ColorItem(
                color: ThemeColorUtil.assistButtonColor(context),
                title: "辅助按钮",
                subtitle: "#FF8F1F",
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TitleWidget(title: "中性色（用于文本、背景和边框颜色，通过运用不同的中性色来表现层次结构）",),
              ColorItem(
                color: ThemeColorUtil.titleTextColor(context),
                title: "标题色 主文字色/正文",
                subtitle: "#333333",
              ),
              ColorItem(
                color: ThemeColorUtil.subTitleTextColor(context),
                title: "副文本用色",
                subtitle: "#999999",
              ),
              ColorItem(
                color: ThemeColorUtil.disableTextColor(context),
                title: "暗文字/失效",
                subtitle: "#CCCCCC",
              ),
              ColorItem(
                color: ThemeColorUtil.backGroundColor(context),
                title: "卡片色",
                subtitle: "#FFFFFFFF",
                textColor: Color(0xff333333),
              ),
              ColorItem(
                color: ThemeColorUtil.innerBackGroundColor(context),
                title: "卡片内背景色",
                subtitle: "#F7F7F7",
                textColor: Color(0xff333333),
              ),
              ColorItem(
                color: ThemeColorUtil.dividerColor(context),
                title: "分隔线",
                subtitle: "#EEEEEE",
                textColor: Color(0xff333333),
              ),
              ColorItem(
                color: ThemeColorUtil.globalBackGroundColor(context),
                title: "全局背景色",
                subtitle: "#F4F4F4",
                textColor: Color(0xff333333),
              ),
              ColorItem(
                color: ThemeColorUtil.primaryColor(context),
                title: "按钮边框1",
                subtitle: "#409BFF",
              ),
              ColorItem(
                color: ThemeColorUtil.subTitleTextColor(context),
                title: "按钮边框2",
                subtitle: "#999999",
              )
            ],
          ),
          SizedBox(height: 20,)
        ],
      ),
    );
  }

}


class ColorItem extends StatelessWidget {

  final String title;

  final String subtitle;

  final Color textColor;

  final Color color;

  final bool isBottom;


  const ColorItem({Key key,
    this.title = "标题",
    this.subtitle = "颜色值",  this.color, this.textColor = const Color(0xffffffff), this.isBottom = true,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 200,
      padding: EdgeInsets.only(left: 20),
      margin: isBottom ?  EdgeInsets.only(bottom: 10) : EdgeInsets.all(0),
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(title, style: TextStyle(
            color: textColor,
            fontSize: 15,
            fontWeight: FontWeight.w500
          ),),
          SizedBox(height: 2,),
          Text(subtitle, style: TextStyle(
              color: textColor,
              fontSize: 15,
              fontWeight: FontWeight.w500
          ),),
        ],
      ),
    );
  }

}