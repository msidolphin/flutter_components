import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomSheetRoute<T> extends PopupRoute<T> {
  BottomSheetRoute({
    @required this.child,
    this.barrierLabel,
    RouteSettings settings,
  }) : super(settings: settings);

  final Widget child;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 300);

  @override
  bool get barrierDismissible => true;

  @override
  final String barrierLabel;

  @override
  Color get barrierColor => Colors.black45;

  AnimationController _animationController;

  @override
  AnimationController createAnimationController() {
    assert(_animationController == null);
    _animationController = AnimationController(vsync: navigator.overlay, duration: Duration(milliseconds: 300));
//        BottomSheet.createAnimationController(navigator.overlay);
    return _animationController;
  }

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    Widget bottomSheet = new MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: BottomSheetLayout(
          this,
          this.child,
        )
    );
    return bottomSheet;
  }
}


class BottomSheetLayout extends StatelessWidget {

  final BottomSheetRoute route;
  final Widget child;


  BottomSheetLayout(this.route, this.child);

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      child: new AnimatedBuilder(
        animation: route.animation,
        builder: (BuildContext context, Widget child) {
          return new ClipRect(
            child: new CustomSingleChildLayout(
              delegate: new _BottomSheetLayout(route.animation.value,
                  contentHeight: 300),
              child: Container(
                  color: Colors.transparent,
                  padding: EdgeInsets.only(left: 0, right: 0),
                  child: this.child
              ),
            ),
          );
        },
      ),
    );
  }

}

class _BottomSheetLayout extends SingleChildLayoutDelegate {
  _BottomSheetLayout(this.progress, {this.contentHeight});

  final double progress;
  final double contentHeight;

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    return new BoxConstraints(
      minWidth: constraints.maxWidth,
      maxWidth: constraints.maxWidth,
      minHeight: 0.0,
      maxHeight: double.infinity,
    );
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    double height = size.height - childSize.height * progress;
    return new Offset(0.0, height);
  }

  @override
  bool shouldRelayout(_BottomSheetLayout oldDelegate) {
    return progress != oldDelegate.progress;
  }
}
