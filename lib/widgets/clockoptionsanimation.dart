import 'dart:async';

import 'package:clock_challenge/helpers/utils.dart';
import 'package:clock_challenge/services/clockanimationservice.dart';
import 'package:clock_challenge/services/clockthemeservice.dart';
import 'package:flutter/material.dart';
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
  Map<ClockThemes, SMITrigger> triggers = {};
  Timer themeSwitcher = Timer(Duration.zero, () {});
  int themeIndex = 0;

  @override
  void initState() {
    super.initState();

    animation = RiveAnimation.asset('./assets/anims/clockchallenge.riv',
      fit: BoxFit.fitHeight,
      onInit: onRiveInit,
    );

    themeSwitcher = Timer.periodic(const Duration(seconds: 30), (timer) {
      triggerThemeChange();
    });
  }

  void triggerThemeChange() {
    if (themeIndex < ClockThemes.values.length) {
      var currentTheme = ClockThemes.values.firstWhere((t) => t.index == themeIndex);
      context.read<ClockThemeService>().updateTheme(currentTheme);
      context.read<ClockAnimationService>().setClockAnimationTheme(currentTheme);
      triggers[currentTheme]!.fire();
      themeIndex++;
    }
    else {
      themeIndex = 0;
    }
  }

  @override
  void dispose() {
    themeSwitcher.cancel();
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
    return animation;
  }
}