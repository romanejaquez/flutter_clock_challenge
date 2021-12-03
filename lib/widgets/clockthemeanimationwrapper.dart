import 'package:clock_challenge/services/clockanimationservice.dart';
import 'package:clock_challenge/widgets/clockthemeanimation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ClockThemeAnimationWrapper extends StatefulWidget {
  @override
  State<ClockThemeAnimationWrapper> createState() => _ClockThemeAnimationWrapperState();
}

class _ClockThemeAnimationWrapperState extends State<ClockThemeAnimationWrapper> {
  @override
  Widget build(BuildContext context) {
    
    return Consumer<ClockAnimationService>(
      builder: (context, animService, child) {
        return ClockThemeAnimation();
      }
    );
  }
}