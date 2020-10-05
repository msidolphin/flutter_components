import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide CloseButton, BackButton;
import 'package:flutter/services.dart';
import '../utils/ColorUtil.dart';
import '../utils/Gaps.dart';

import '../utils/Ui.dart';
import 'BackButton.dart';

// 默认标题栏高度为44 TabBar高度为46 所以如果导航栏底部有TabBar的话高度应该设置为90
const double DEFAULT_APP_BAR_HEIGHT = 44;

class NavigatorBar extends StatefulWidget implements PreferredSizeWidget {

  final String title; // string
  final Widget navigator; // 自定义导航栏
  final Widget leading;
  final double height;
  final List<Widget> actions;
  final Widget bottom;
  final bool automaticallyImplyLeading;
  final Color backgroundColor;
  final Color titleColor;
  final bool withShadow;
  final bool loading;

  const NavigatorBar({
    Key key,
    this.title,
    this.navigator,
    this.leading,
    this.height = DEFAULT_APP_BAR_HEIGHT,
    this.actions,
    this.bottom,
    this.automaticallyImplyLeading = true,
    this.backgroundColor = Colors.white,
    this.titleColor = ColorUtil.title,
    this.withShadow = false,
    this.loading = false
  }) : assert(title != null || navigator != null), super(key: key);


  @override
  State<StatefulWidget> createState() {
    return NavigatorBarState(
      title: title,
      navigator: navigator,
      leading: leading,
      height: height,
      actions: actions,
      bottom: bottom,
      automaticallyImplyLeading: automaticallyImplyLeading,
      backgroundColor: backgroundColor,
      titleColor: titleColor,
      withShadow: withShadow,
      loading: loading
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);

}

class NavigatorBarState extends State<NavigatorBar>  {

  final GlobalKey key = new GlobalKey();
  final String title; // string
  final Widget navigator;
  final Widget leading;
  final double height;
  final List<Widget> actions;
  final Widget bottom;
  final bool automaticallyImplyLeading;
  final Color backgroundColor;
  final Color titleColor;
  final bool withShadow;
  bool loading;
  double navigatorPaddingRight = 0;

   NavigatorBarState({
    this.title,
    this.navigator,
    this.leading,
    this.height = DEFAULT_APP_BAR_HEIGHT,
    this.actions,
    this.bottom,
    this.automaticallyImplyLeading = true,
    this.backgroundColor = Colors.white,
    this.titleColor = ColorUtil.title,
    this.withShadow = true,
    this.loading = false
  }) : assert(title != null || navigator != null);

  void toggleLoading() {
    setState(() {
      loading = !loading;
    });
  }

  void showLoading() {
    setState(() {
      loading = true;
    });
  }

  void hideLoading() {
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _renderNavigator(context);
  }

  PreferredSizeWidget _renderNavigator(BuildContext context) {
    if (navigator != null) {
      final ModalRoute<dynamic> parentRoute = ModalRoute.of(context);
      final bool canPop = parentRoute?.canPop ?? false;
      return _renderAppBar(context, Container(
        padding: EdgeInsets.only(left: canPop ? 0 : kMinInteractiveDimension, right: kMinInteractiveDimension),
        child: navigator
      ));
    }
    return _renderAppBar(context,
        Container(
          padding: EdgeInsets.only(right: navigatorPaddingRight),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
            ..._renderTitleLeading(),
              Text(
                this.title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        )
    );
  }

  List<Widget> _renderTitleLeading () {
    if (loading) {
      return [
        CupertinoActivityIndicator(),
        Gaps.hGap8
      ];
    } else {
      return [Gaps.empty];
    }
  }

  Widget _renderAppBar(BuildContext context, Widget title) {

    return PreferredSize(
      preferredSize: Size.fromHeight(height),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: withShadow && !Ui.isDarkMode(context) ? <BoxShadow>[
            BoxShadow(color: ColorUtil.web("#000", 0.06), blurRadius: 3, offset: Offset(0, 1))
          ] : [],
        ),
        child: AppBar(
            key: key,
            /// 影响状态栏文字颜色 目前暂不支持夜间模式 所以给个日间模式就行了
            brightness: Ui.isDarkMode(context) ? Brightness.dark : Brightness.light,
            textTheme: Theme.of(context).textTheme,
            leading: automaticallyImplyLeading ? _NavigatorLeading(
              leading: leading,
              automaticallyImplyLeading: automaticallyImplyLeading
            ) : leading,
            centerTitle: true,
            backgroundColor: Ui.isDarkMode(context) ? Theme.of(context).scaffoldBackgroundColor: backgroundColor,
            title: title,
            elevation: 0,
            actions: this.actions,
            bottom: this.bottom
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }


}


// ignore: must_be_immutable
class _NavigatorLeading extends StatelessWidget {

  final bool useCloseButton;
  final bool hasDrawer;
  Widget leading;
  final bool automaticallyImplyLeading;

  _NavigatorLeading({
    this.useCloseButton = false,
    this.hasDrawer = false,
    this.leading,
    this.automaticallyImplyLeading = true
  });

  @override
  Widget build(BuildContext context) {
    final ModalRoute<dynamic> parentRoute = ModalRoute.of(context);
    final bool canPop = parentRoute?.canPop ?? false;
    final Color iconColor = Theme.of(context).textTheme.title.color;
    if (leading == null && this.automaticallyImplyLeading) {
      if (hasDrawer) {
        leading = IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () => _handleDrawerButton(context),
          tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
        );
      } else {
        if (canPop)
          leading = useCloseButton ? CloseButton() : BackButton(color: iconColor);
      }
    }
    return leading != null ? leading : Gaps.empty;
  }

  void _handleDrawerButton(BuildContext context) {
    Scaffold.of(context).openDrawer();
  }

}
