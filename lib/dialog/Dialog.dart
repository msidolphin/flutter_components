import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Dialog {

  static Future<T> show<T>({
    @required BuildContext context,
    bool barrierDismissible = true,
    @required Widget child,
    DialogTransition transaction = DialogTransition.slide,
    Duration duration = const Duration(milliseconds: 550),
  }) {
    final ThemeData theme = Theme.of(context, shadowThemeOnly: true);
    FocusScope.of(context).unfocus();
    return showGeneralDialog(
      context: context,
      pageBuilder: (BuildContext buildContext, Animation<double> animation, Animation<double> secondaryAnimation) {
        final Widget pageChild = Builder(builder: (BuildContext context) {
          return child;
        });
        return SafeArea(
          child: Builder(
              builder: (BuildContext context) {
                return theme != null
                    ? Theme(data: theme, child: pageChild)
                    : pageChild;
              }
          ),
        );
      },
      barrierDismissible: barrierDismissible,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black45,
      transitionDuration: duration,
      transitionBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
        Widget widget = child;
        switch(transaction) {
          case DialogTransition.slide:
            widget = SlideTransition(
              position: Tween<Offset>(
                  begin: const Offset(0.0, 0.3),
                  end: Offset.zero
              ).animate(CurvedAnimation(
                parent: animation,
                curve: animation.status != AnimationStatus.forward ? Curves
                    .easeOutBack : ElasticOutCurve(0.85),
              )),
              child: child,
            );
            break;
          case DialogTransition.scale:
            widget = Transform.scale(
              scale: animation.value,
              child: Opacity(
                opacity: animation.value,
                child: child,
              ),
            );
            break;
          case DialogTransition.endDrawer:
            widget = SlideTransition(
              transformHitTests: false,
              position: new Tween<Offset>(
                begin: const Offset(1.0, 0.0),
                end: Offset.zero,
              ).animate(
                CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeInOut,
                ),
              ),
              child: child,
            );
            break;
          case DialogTransition.drawer:
            widget = SlideTransition(
              transformHitTests: false,
              position: new Tween<Offset>(
                begin: const Offset(-1.0, 0.0),
                end: Offset.zero,
              ).animate(
                CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeInOut,
                ),
              ),
              child: child,
            );
            break;
        }
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light,
          child: FadeTransition(
            opacity: CurvedAnimation(
              parent: animation,
              curve: Curves.easeOut,
            ),
            child: widget
          ),
        );
      }
    );
  }

  static void close(BuildContext context) {
    Navigator.of(context).pop();
  }

}

enum DialogTransition {
  slide,
  scale,
  endDrawer,
  drawer
}