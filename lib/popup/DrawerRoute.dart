import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'PopupPlacement.dart';


class DrawerRoute extends PopupRoute  {

  DrawerAnimation widget;

  AnimationController _animationController;

  BuildContext context;

  Widget child;

  PopupPlacement placement;


  DrawerRoute({
    @required this.child,
    this.placement = PopupPlacement.bottom
  });

  @override
  Color get barrierColor => null;

  @override
  String get barrierLabel => null;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    this.widget = DrawerAnimation(
      context,
      child: child,
      placement: placement,
    );
    this._animationController = new AnimationController(
        vsync: this.widget._state,
        duration: Duration(milliseconds: 300)
    );
    this.widget._state.controller = _animationController;
    return this.widget;
  }

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => Duration(milliseconds: 300);

  @override
  bool didPop(result) {
    AnimationController controller = this.widget._state.controller;
    if (controller.status == AnimationStatus.completed
        || controller.status == AnimationStatus.forward)  {
      controller.reverse();
    }
    return super.didPop(result);
  }

  void close () {
    Navigator.of(context).pop();
  }

  @override
  bool get barrierDismissible => false;


}

class DrawerAnimation extends StatefulWidget {

  Widget child;

  _DrawerAnimationState _state;

  BuildContext context;

  AnimationController animationController;

  PopupPlacement placement;


  DrawerAnimation(this.context, {
    @required this.child,
    this.placement = PopupPlacement.bottom}
      ) {
    this._state =  _DrawerAnimationState(
        this.context,
        placement: this.placement,
        child: child
    );
  }

  @override
  State<StatefulWidget> createState() {
    return this._state;
  }



}

class _DrawerAnimationState extends State<DrawerAnimation>
    with TickerProviderStateMixin {

  GlobalKey boxKey = GlobalKey();

  AnimationController controller;

  Animation<double> translateAnimation;

  Animation<double> opacityAnimation;

  Animation<double> containerOpacityAnimation;

  BuildContext context;

  Widget child;

  PopupPlacement placement;


  _DrawerAnimationState(
      this.context,{
        @required this.child,
        this.placement
      }
      );

  @override
  Widget build(BuildContext context) {
    double x = getX();
    double y = getY();
    return Stack(
      children: <Widget>[
        // mask
//        GestureDetector(
//          onTap: () {
////            Navigator.of(context).pop();
//          },
//          child: Opacity(
//            opacity: opacityAnimation != null ? opacityAnimation.value : 0,
//            child: Container(
//              height: MediaQuery.of(context).size.height,
//              width: MediaQuery.of(context).size.width,
//              color: Colors.black,
//            ),
//          ),
//        ),
        Container(
          child: SafeArea(
            child: Transform.translate(
                offset: Offset(0, 0),
                child: Material(
                  type: MaterialType.transparency,
                  child: Container(
                      key: boxKey,
                      child: child
                  ),
                )
            ),
          ),
        )
      ],
    );
  }


  @override
  void initState() {
    super.initState();
    this.initAnimation();
  }

  @override
  void dispose() {
    // fix _debugLifecycleState != _ElementLifecycle.defunct
    if(controller.status == AnimationStatus.forward || controller.status == AnimationStatus.reverse)
    {
      controller.notifyStatusListeners(AnimationStatus.dismissed);
    }
    controller.dispose();
    super.dispose();
  }

  double getX () {
    if (translateAnimation == null) return 10000;
    switch (placement) {
      case PopupPlacement.top:
        return 0;
      case PopupPlacement.right:
        return translateAnimation.value;
      case PopupPlacement.bottom:
        return 0;
      case PopupPlacement.left:
        return -translateAnimation.value;
    }
    return 0;
  }

  double getY () {
    if (translateAnimation == null) return 10000;
    switch (placement) {
      case PopupPlacement.top:
        return -translateAnimation.value;
      case PopupPlacement.right:
        return 0;
      case PopupPlacement.bottom:
        return translateAnimation.value;
      case PopupPlacement.left:
        return 0;
    }
    return translateAnimation.value;
  }

  void initAnimation () {
    opacityAnimation = new Tween<double>(
        begin: 0,
        end: 0.4
    ).animate(controller)..addListener(() {
    });
    containerOpacityAnimation = new Tween<double>(
      begin: 0,
      end: 1
    ).animate(controller)..addListener(() {});
    // 等待组件build完成
    WidgetsBinding.instance.addPostFrameCallback((time) {
      bool isVertical = placement == PopupPlacement.top || placement == PopupPlacement.bottom;
      double height = boxKey.currentContext.size.height;
      double width = boxKey.currentContext.size.width;
      double screenHeight = MediaQuery.of(context).size.height;
      double screenWidth = MediaQuery.of(context).size.width;
      double statusBarHeight = MediaQuery.of(context).padding.top;
      double begin = isVertical ?
      (placement == PopupPlacement.top ? screenHeight : height)
          : width;
      double end = placement == PopupPlacement.top ? screenHeight - height : 0;
      switch(placement) {
        case PopupPlacement.top:
          begin = height;
          end = 0;
          break;
        case PopupPlacement.bottom:
          begin = screenHeight + statusBarHeight;
          end = screenHeight - height - statusBarHeight;
          break;
        case PopupPlacement.right:
          begin = screenWidth;
          end = screenWidth - width;
          break;
        case PopupPlacement.left:
          begin = width;
          end = 0;
          break;
      }
      translateAnimation = new Tween<double>(
          begin: begin,
          end: end
      ).animate(controller)..addListener(() {
        setState(() {
        });
      });
      if (controller.status != AnimationStatus.completed) {
        controller.forward();
      }
    });
  }

}