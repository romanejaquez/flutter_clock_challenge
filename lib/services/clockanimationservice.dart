import 'package:clock_challenge/helpers/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ClockAnimationService extends ChangeNotifier {

  Map<ClockThemes, Widget> animationThemes = {
    ClockThemes.heart: SvgPicture.asset('./assets/imgs/heart.svg', color: Colors.white),
    ClockThemes.flutter: SvgPicture.asset('./assets/imgs/flutter.svg', color: Colors.white),
    ClockThemes.ring: SvgPicture.asset('./assets/imgs/ring.svg', color: Colors.white),
    ClockThemes.firebase: SvgPicture.asset('./assets/imgs/firebase.svg', color: Colors.white),
    ClockThemes.leaf: SvgPicture.asset('./assets/imgs/leaf.svg', color: Colors.white),
  };

  bool showClockAnimation = false;
  Widget? themeIcon;

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