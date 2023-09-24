import 'dart:async';

import 'package:clock_challenge/helpers/utils.dart';
import 'package:clock_challenge/services/clockanimationservice.dart';
import 'package:clock_challenge/services/clockthemeservice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';

class ClockOptionsAnimation extends StatefulWidget {

  const ClockOptionsAnimation({Key? key}) : super(key: key);

  @override
  State<ClockOptionsAnimation> createState() => _ClockOptionsAnimationState();
}

class _ClockOptionsAnimationState extends State<ClockOptionsAnimation> {

  late StateMachineController ctrl;
  late RiveAnimation animation;
  AnimationController? qrcodeAnimCtrl;
  Map<ClockThemes, SMITrigger> triggers = {};
  Timer themeSwitcher = Timer(Duration.zero, () {});
  int themeIndex = 0;
  double valueTarget = 0.0;
  Timer qrcodeDelay = Timer(Duration.zero, () {});

  @override
  void initState() {
    super.initState();

    animation = RiveAnimation.asset('./assets/anims/clockchallenge.riv',
      fit: BoxFit.fitHeight,
      onInit: onRiveInit,
    );

    themeSwitcher = Timer.periodic(const Duration(seconds: 15), (timer) {
      triggerThemeChange();
    });
  }

  void triggerThemeChange() {
    if (themeIndex < ClockThemes.values.length) {
      var currentTheme = ClockThemes.values.firstWhere((t) => t.index == themeIndex);
      context.read<ClockThemeService>().updateTheme(currentTheme);
      context.read<ClockAnimationService>().setClockAnimationTheme(currentTheme);
      triggers[currentTheme]!.fire();
      
      setState(() {
        themeIndex++;
        valueTarget = themeIndex == ClockThemes.firebase.index ? 0.0 : 1.0;
      });
    }
    else {
      setState(() {
        themeIndex = 0;
      });
    }
  }

  void triggerSelectedTheme(ClockThemes theme) {
    context.read<ClockThemeService>().updateTheme(theme);
      context.read<ClockAnimationService>().setClockAnimationTheme(theme);
      triggers[theme]!.fire();

    if (qrcodeAnimCtrl != null) {
      qrcodeAnimCtrl!.reset();
      qrcodeAnimCtrl!.stop(canceled: true);
      qrcodeDelay.cancel();
    }
    

    setState(() {
      themeIndex = theme.index;

      if (theme == ClockThemes.firebase) {
        if (qrcodeAnimCtrl != null) {
          qrcodeAnimCtrl!.forward();
        }
        
        valueTarget = themeIndex == ClockThemes.firebase.index ? 0.0 : 1.0;
      }
    });
  }

  @override
  void dispose() {
    themeSwitcher.cancel();
    qrcodeDelay.cancel();
    qrcodeAnimCtrl!.dispose();
    ctrl.dispose();
    super.dispose();
  }

  void onRiveInit(Artboard ab) {
    ctrl = StateMachineController.fromArtboard(ab, 'clockchallenge')!;
    ab.addController(ctrl);

    for(var theme in ClockThemes.values) {
      triggers[theme] = ctrl.findSMI(theme.name) as SMITrigger;
    }

    setState(() {
      triggerThemeChange();
    });
  }
  
  @override
  Widget build(BuildContext context) {

    return Stack(
      clipBehavior: Clip.none,
      children: [
        SizedBox(
          width: MediaQuery.sizeOf(context).height,
          height: MediaQuery.sizeOf(context).height,
          child: animation),

        // buttons

        // firebase
        Positioned(
          right: 250,
          top: 170,
          child: GestureDetector(
            onTap: () {
              triggerSelectedTheme(ClockThemes.firebase);
            },
            child: Container(
              color: Colors.transparent,
              width: 120, height: 120,
            ),
          )
        ),

        // flutter
        Positioned(
          right: 140,
          top: 300,
          child: GestureDetector(
            onTap: () {
              triggerSelectedTheme(ClockThemes.flutter);
            },
            child: Container(
              color: Colors.transparent,
              width: 120, height: 120,
            ),
          )
        ),

        // heart
        Positioned(
          right: 100,
          top: 480,
          child: GestureDetector(
            onTap: () {
              triggerSelectedTheme(ClockThemes.heart);
            },
            child: Container(
              color: Colors.transparent,
              width: 120, height: 120,
            ),
          )
        ),

        // leaf
        Positioned(
          right: 140,
          top: 650,
          child: GestureDetector(
            onTap: () {
              triggerSelectedTheme(ClockThemes.leaf);
            },
            child: Container(
              color: Colors.transparent,
              width: 120, height: 120,
            ),
          )
        ),

        // ring
        Positioned(
          right: 250,
          bottom: 160,
          child: GestureDetector(
            onTap: () {
              triggerSelectedTheme(ClockThemes.ring);
            },
            child: Container(
              color: Colors.transparent,
              width: 120, height: 120,
            ),
          )
        ),


          Positioned(
            bottom: 0,
            left: 0, right: 0,
            child: Container(
              margin: const EdgeInsets.only(bottom: 80),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('./assets/imgs/qrhintsparky.png',
                    width: 150, height: 150,
                    fit: BoxFit.contain
                  ),
                  Image.asset('./assets/imgs/f3_1_qrcode.png',
                    width: 180, height: 180,
                    fit: BoxFit.contain
                  )
                ],
              ),
              height: 300,
              padding: const EdgeInsets.all(30),
              color: Colors.white,
            ),
          ).animate(
            target: valueTarget,
            onComplete: (controller) {
              qrcodeAnimCtrl = controller;
              qrcodeDelay = Timer(10.seconds, () {
                controller.reverse().whenComplete(() {
                  valueTarget = 0.0;
                  controller.reset();
                });
              });
            },
          ).slideY(
            begin: 1, end: 0,
            duration: 1.seconds,
            curve: Curves.easeInOut,
        )
      ]
    );
  }
}