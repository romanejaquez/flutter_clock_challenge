import 'package:clock_challenge/helpers/utils.dart';
import 'package:flutter/material.dart';

class ClockAnimationService extends ChangeNotifier {

  Map<ClockThemes, IconData> animationThemes = {
    ClockThemes.valentine: Icons.favorite,
    ClockThemes.blue: Icons.ac_unit,
    ClockThemes.fuchsia: Icons.trip_origin
  };

  bool showClockAnimation = false;
  IconData? themeIcon = Icons.ac_unit;

  void setClockAnimationTheme(ClockThemes clockTheme) {
    resetAnimation();
    
    if (animationThemes.containsKey(clockTheme)) {
      showClockAnimation = true;
      themeIcon = animationThemes[clockTheme];
    }
    else {
      showClockAnimation = false;
      themeIcon = null;
    }

    notifyListeners();
  }

  void resetAnimation() {
    showClockAnimation = false;
    themeIcon = null;
    notifyListeners();
  }

}