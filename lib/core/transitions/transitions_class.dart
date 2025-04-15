import 'package:flutter/material.dart';

class CustomPageRoute extends PageRouteBuilder {
  final Widget page;
  final TransitionType transitionType;

  CustomPageRoute({
    required this.page,
    this.transitionType = TransitionType.fade,
  }) : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            switch (transitionType) {
              case TransitionType.slide:
                const begin = Offset(1.0, 0.0); // Slide from the right
                const end = Offset.zero;
                const curve = Curves.easeInOut;

                var tween = Tween(begin: begin, end: end)
                    .chain(CurveTween(curve: curve));
                var offsetAnimation = animation.drive(tween);

                return SlideTransition(
                  position: offsetAnimation,
                  child: child,
                );
              case TransitionType.scale:
                return ScaleTransition(
                  scale: animation,
                  child: child,
                );
              case TransitionType.fade:
              return FadeTransition(
                  opacity: animation,
                  child: child,
                );
            }
          },
        );
}

enum TransitionType { fade, slide, scale }
