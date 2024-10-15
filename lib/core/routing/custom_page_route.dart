import 'package:flutter/material.dart';

class CustomPageRoute extends PageRouteBuilder {
  CustomPageRoute({
    required this.child,
    required this.axisDirection,
    RouteSettings? settings,
  }) : super(
          settings: settings,
          transitionDuration: const Duration(
            milliseconds: 300,
          ),
          pageBuilder: (
            context,
            animation,
            secondaryAnimation,
          ) =>
              child,
        );

  Widget child;
  AxisDirection axisDirection;
  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: getBeginOffset(),
        end: Offset.zero,
      ).animate(animation),
      child: child,
    );
  }

  Offset getBeginOffset() {
    switch (axisDirection) {
      case AxisDirection.up:
        return const Offset(0, 1);
      case AxisDirection.down:
        return const Offset(0, -1);
      case AxisDirection.left:
        return const Offset(-1, 0);
      case AxisDirection.right:
        return const Offset(1, 0);
    }
  }
}
