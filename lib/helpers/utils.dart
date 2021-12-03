import 'package:clock_challenge/helpers/clocktheme.dart';
import 'package:flutter/material.dart';

class Utils {

  static ClockThemes clockTheme = ClockThemes.green;

  static Map<ClockThemes, ClockTheme> themes = {
    ClockThemes.green : ClockTheme(
      shadow1: const Color(0xFF0A340C).withOpacity(0.2),
      shadow2: Colors.green,
      main: Colors.green,
      color1: const Color(0xFF102310),
      color2: const Color(0xFF1E4620),
      color3: const Color(0xFF2D6930),
      color4: const Color(0xFF3D8C40),
      color5: const Color(0xFF4DAF50),
      colorShadow: const Color(0xFF0A340C).withOpacity(0.5)
    ),
    ClockThemes.fuchsia : ClockTheme(
      shadow1: const Color(0xFF6E0A4B).withOpacity(0.2),
      shadow2: const Color(0xFFE342AB),
      color1: const Color(0xFF6E0A4B),
      color2: const Color(0xFFAA1B78),
      color3: const Color(0xFFCC2191),
      color4: const Color(0xFFE342AB),
      color5: const Color(0xFFFA4DBE),
      main: const Color(0xFFFA4DBE),
      colorShadow: const Color(0xFF6E0A4B).withOpacity(0.5)
    ),
    ClockThemes.blue : ClockTheme(
      shadow1: const Color(0xFF00557B).withOpacity(0.2),
      shadow2: const Color(0xFF00B1FF),
      color1: const Color(0xFF00354D),
      color2: const Color(0xFF00557B),
      color3: const Color(0xFF0076AA),
      color4: const Color(0xFF008FCE),
      color5: const Color(0xFF00B1FF),
      main: const Color(0xFF00B1FF),
      colorShadow: const Color(0xFF00354D).withOpacity(0.5)
    )
  };

  static ClockTheme getTheme() {
    return themes[clockTheme]!;
  }

  static Color getColorFromTheme(ClockThemes theme) {
    return themes[theme]!.main!;
  }
}

enum ClockThemes {
  green,
  blue,
  fuchsia
}