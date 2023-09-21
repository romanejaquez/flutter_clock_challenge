import 'package:clock_challenge/helpers/clocktheme.dart';
import 'package:flutter/material.dart';

class Utils {

  static ClockThemes clockTheme = ClockThemes.leaf;

  static Map<ClockThemes, ClockTheme> themes = {
    ClockThemes.leaf : ClockTheme(
      shadow1: const Color(0xFF0A340C).withOpacity(0.2),
      shadow2: Colors.green,
      main: const Color(0xFF4CAF50),
      color1: const Color(0xFF102310),
      color2: const Color(0xFF1E4620),
      color3: const Color(0xFF2D6930),
      color4: const Color(0xFF3D8C40),
      color5: const Color(0xFF4DAF50),
      colorShadow: const Color(0xFF0A340C).withOpacity(0.5)
    ),
    ClockThemes.ring : ClockTheme(
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
    ClockThemes.flutter : ClockTheme(
      shadow1: const Color(0xFF00557B).withOpacity(0.2),
      shadow2: const Color(0xFF00B1FF),
      color1: const Color(0xFF00354D),
      color2: const Color(0xFF00557B),
      color3: const Color(0xFF0076AA),
      color4: const Color(0xFF008FCE),
      color5: const Color(0xFF00B1FF),
      main: const Color(0xFF00B1FF),
      colorShadow: const Color(0xFF00354D).withOpacity(0.5)
    ),
    ClockThemes.heart : ClockTheme(
      shadow1: const Color(0xFF880C0C).withOpacity(0.2),
      shadow2: const Color(0xFFCC1515),
      color1: const Color(0xFF880C0C),
      color2: const Color(0xFFAC0E0E),
      color3: const Color(0xFFCC1515),
      color4: const Color(0xFFE61B1B),
      color5: const Color(0xFFFD2A2A),
      main: const Color(0xFFFD2A2A),
      colorShadow: const Color(0xFF880C0C).withOpacity(0.5)
    ),
    ClockThemes.firebase : ClockTheme(
      shadow1: const Color(0xFFB63A00).withOpacity(0.2),
      shadow2: const Color(0xFF9A5103),
      color1: const Color(0xFFD67A18),
      color2: const Color(0xFFDB862A),
      color3: const Color(0xFFEA9A44),
      color4: const Color(0xFFF8B064),
      color5: const Color(0xFFFFCC95),
      main: const Color(0xFFFF7D19),
      colorShadow: const Color(0xFFEE5700).withOpacity(0.5)
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
  firebase,
  flutter,
  heart,
  leaf,
  ring
}