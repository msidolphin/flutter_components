import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_components/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../widget/TitleWidget.dart';

class NoticeBarView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListView(
        children: <Widget>[
          TitleWidget(title: 'NoticeBar 通告栏',),
          Container(
            padding: EdgeInsets.only(left: 15),
            child: Text('在导航栏下方，一般用作系统提醒、活动提醒等通知。',
              style: TextStyle(
                fontSize: 14,
                color: ThemeColorUtil.bodyTextColor(context)
              ),
            ),
          ),
          TitleWidget(title: '长度不足',),
          NoticeBar(
            child: Text('请下单后6小时内付款，超时未付款订单将自动取消。'),
          ),
          TitleWidget(title: '循环滚动',),
          NoticeBar(
            child: Text('服务器将在今日0点－2点进行系统升级，升级期间将暂停服务，敬请谅解。'),
          ),
          TitleWidget(title: '带图标',),
          NoticeBar(
            icon: FaIcon(FontAwesomeIcons.volumeUp, color: Color(0xFFFF8F1F), size: 14),
            child: Text('服务器将在今日0点－2点进行系统升级，升级期间将暂停服务，敬请谅解。'),
          ),
          TitleWidget(title: '可关闭',),
          NoticeBar(
            icon: FaIcon(FontAwesomeIcons.volumeUp, color: Color(0xFFFF8F1F), size: 14), //Icon(Icons.comment, color: Color(0xFFFF8F1F), size: 20,),
            closeable: true,
            child: Text('服务器将在今日0点－2点进行系统升级，升级期间将暂停服务，敬请谅解。'),
          ),
          TitleWidget(title: '不滚动',),
          NoticeBar(
            isScrollable: false,
            closeable: true,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('1.  只有已取消和已完成的订单可以被删除；'),
                  Text('2. 订单被彻底删除后将无法找回或还原，更无法进行查看、评价、晒单和申请售后等操作，彻底删除操作请谨慎！')
                ],
              ),
            )
          )
        ],
      ),
    );
  }


}