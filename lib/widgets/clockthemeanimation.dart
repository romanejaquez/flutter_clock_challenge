import 'dart:math';

import 'package:clock_challenge/services/clockanimationservice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class ClockThemeAnimation extends StatefulWidget {

  @override
  State<ClockThemeAnimation> createState() => _ClockThemeAnimationState();
}

class _ClockThemeAnimationState extends State<ClockThemeAnimation> with TickerProviderStateMixin {
  AnimationController? controller;
  
  List<AnimationController> controllers = [];
  List<Widget> animatedItems = [];
  
  @override 
  void initState() {
    super.initState();
  }

  void processContent(Widget? icon) {
    animatedItems = [];

    if (icon != null) {
      for(var i = 0; i < 30; i++) {

        int nextInt = (Random().nextInt(5) + 5);
        AnimationController controller = AnimationController(
        duration: Duration(seconds: nextInt),
        vsync: this)..repeat();

        double iconSize = Random().nextDouble() * 100 + 60;
        double opacity = Random().nextDouble() * 0.5 + 0.25;
        var transitionWidget = FadeTransition(
          opacity: Tween<double>(begin: 1, end: 0)
          .animate(CurvedAnimation(parent: controller, curve: Curves.easeInOut)),
          child: SlideTransition(
              position: Tween(
                begin: Offset(i * 1.0, -1.0), 
                end: Offset(i * 1.0, nextInt * 1.5)).animate(
                  CurvedAnimation(parent: controller,
                  curve: Curves.linear
                )
              ),
              child: Opacity(
                opacity: opacity,
                child: SizedBox(
                  child: icon,
                  width: iconSize, height: iconSize
                ),
              )
          ),
        );

        animatedItems.add(transitionWidget);
        controllers.add(controller);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    ClockAnimationService cService = Provider.of<ClockAnimationService>(context);
    processContent(cService.themeIcon);

    return Stack(
      children: animatedItems,
    );
  }

  @override 
  void dispose() {
    controllers.forEach((element) {
      element.dispose();
    });
    super.dispose();
  }
}