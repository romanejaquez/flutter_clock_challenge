
import 'package:clock_challenge/helpers/utils.dart';
import 'package:flutter/material.dart';

class ClockThemeService extends ChangeNotifier {
    
    bool showColorSelection = false;

    void updateTheme(ClockThemes theme) {
      Utils.clockTheme = theme;
      notifyListeners();
    }

    void toggleColorSelection() {
      showColorSelection = !showColorSelection;
      notifyListeners();
    }
}