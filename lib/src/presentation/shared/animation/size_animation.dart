import 'package:flutter/material.dart';
import 'dart:math' as math;
class SizeAnimationToRight extends PageRouteBuilder {
  final Widget page;
  final RouteSettings? routeSettings;
  SizeAnimationToRight({required this.page, this.routeSettings})
      : super(
            settings: routeSettings,
            pageBuilder: (context, animation, anotherAnimation) => page,
            transitionDuration: const Duration(milliseconds: 1000),
            reverseTransitionDuration: const Duration(milliseconds: 200),
            transitionsBuilder: (context, animation, anotherAnimation, child) {
              animation = CurvedAnimation(
                  parent: animation,
                  curve: Curves.fastLinearToSlowEaseIn,
                  reverseCurve: Curves.fastOutSlowIn);
              return Align(
                alignment: Alignment.centerLeft,
                child: SizeTransition(
                    axis: Axis.horizontal,
                    sizeFactor: animation,
                    axisAlignment: 0,
                    child: page),
              );
            });
}

class SizeAnimationToLeft extends PageRouteBuilder {
  final Widget page;
  final RouteSettings? routeSettings;

  SizeAnimationToLeft({
    required this.page,
    this.routeSettings,
  }) : super(
          settings: routeSettings,
          pageBuilder: (context, animation, anotherAnimation) => page,
          transitionDuration: const Duration(milliseconds: 1000),
          reverseTransitionDuration: const Duration(milliseconds: 200),
          transitionsBuilder: (context, animation, anotherAnimation, child) {
            animation = CurvedAnimation(
                parent: animation,
                curve: Curves.fastLinearToSlowEaseIn,
                reverseCurve: Curves.fastOutSlowIn);
            return Align(
              alignment: Alignment.centerRight,
              child: SizeTransition(
                  axis: Axis.horizontal,
                  sizeFactor: animation,
                  axisAlignment: 0,
                  child: page),
            );
          },
        );
}


// Transition de fondu
class FadeRouteBuilder extends PageRouteBuilder {
  final Widget page;
  final RouteSettings? routeSettings;

  FadeRouteBuilder({required this.page, this.routeSettings})
      : super(
          settings: routeSettings,
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
          transitionDuration: const Duration(milliseconds: 100),
        );
}

// Transition de glissement vers le haut
class SlideUpRouteBuilder extends PageRouteBuilder {
  final Widget page;
  final RouteSettings? routeSettings;

  SlideUpRouteBuilder({required this.page, this.routeSettings})
      : super(
          settings: routeSettings,
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            var begin = const Offset(0.0, 1.0);
            var end = Offset.zero;
            var tween = Tween(begin: begin, end: end);
            var offsetAnimation = animation.drive(tween);

            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
          transitionDuration: const Duration(milliseconds: 500),
        );
}

// Transition de rotation
class RotationRouteBuilder extends PageRouteBuilder {
  final Widget page;
  final RouteSettings? routeSettings;

  RotationRouteBuilder({required this.page, this.routeSettings})
      : super(
          settings: routeSettings,
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return RotationTransition(
              turns: Tween<double>(begin: 0.0, end: 1.0).animate(
                CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeInOut,
                ),
              ),
              child: child,
            );
          },
          transitionDuration: const Duration(milliseconds: 500),
        );
}

// Transition d'échelle
class ScaleRouteBuilder extends PageRouteBuilder {
  final Widget page;
  final RouteSettings? routeSettings;

  ScaleRouteBuilder({required this.page, this.routeSettings})
      : super(
          settings: routeSettings,
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return ScaleTransition(
              scale: Tween<double>(
                begin: 0.0,
                end: 1.0,
              ).animate(
                CurvedAnimation(
                  parent: animation,
                  curve: Curves.fastOutSlowIn,
                ),
              ),
              child: child,
            );
          },
          transitionDuration: const Duration(milliseconds: 500),
        );
}






class BookPageRouteBuilder extends PageRouteBuilder {
  final Widget page;
  final RouteSettings? routeSettings;

  BookPageRouteBuilder({required this.page, this.routeSettings})
      : super(
          settings: routeSettings,
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return BookPageTransition(
              animation: animation,
              child: child,
            );
          },
          transitionDuration: const Duration(milliseconds: 1000),
          reverseTransitionDuration: const Duration(milliseconds: 1000),
        );
}

class BookPageTransition extends StatelessWidget {
  final Widget child;
  final Animation<double> animation;

  const BookPageTransition({
    super.key,
    required this.child,
    required this.animation,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (BuildContext context, Widget? child) {
        return Transform(
          alignment: Alignment.centerRight,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001) // perspective
            ..rotateY(math.pi * (1 - animation.value)),
          child: animation.value <= 0.5
              ? Container(
                  color: Colors.grey.shade200,
                  child: Center(
                    child: Text(
                      'Page précédente',
                      style: TextStyle(fontSize: 20, color: Colors.grey.shade700),
                    ),
                  ),
                )
              : child,
        );
      },
      child: child,
    );
  }
}