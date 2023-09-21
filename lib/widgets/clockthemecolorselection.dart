import 'package:clock_challenge/helpers/utils.dart';
import 'package:clock_challenge/services/clockanimationservice.dart';
import 'package:clock_challenge/services/clockthemeservice.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ClockThemeColorSelection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    ClockAnimationService animService = Provider.of<ClockAnimationService>(context, listen: false);

    return Consumer<ClockThemeService>(
      builder: (context, cService, child) {
        List<Widget> options = [
          AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              border: Border.all(
                color: Utils.clockTheme == ClockThemes.leaf ? Utils.getColorFromTheme(ClockThemes.leaf) : Colors.transparent,
                width: 3
              ),
              borderRadius: BorderRadius.circular(50)
            ),
            child: ClipOval(
              child: Material(
                color: Utils.getColorFromTheme(ClockThemes.leaf),
                child: InkWell(
                  highlightColor: Colors.white.withOpacity(0.1),
                  splashColor: Colors.white.withOpacity(0.3),
                  onTap: () {
                    cService.updateTheme(ClockThemes.leaf);
                    animService.setClockAnimationTheme(ClockThemes.leaf);
                  },
                  child: const SizedBox(
                    width: 30,
                    height: 30,
                  ),
                )
              ),
            ),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              border: Border.all(
                color: Utils.clockTheme == ClockThemes.ring ? Utils.getColorFromTheme(ClockThemes.ring) : Colors.transparent, 
                width: 3
              ),
              borderRadius: BorderRadius.circular(50)
            ),
            child: ClipOval(
              child: Material(
                color: Utils.getColorFromTheme(ClockThemes.ring),
                child: InkWell(
                  highlightColor: Colors.white.withOpacity(0.1),
                  splashColor: Colors.white.withOpacity(0.3),
                  onTap: () {
                    cService.updateTheme(ClockThemes.ring);
                    animService.setClockAnimationTheme(ClockThemes.ring);

                  },
                  child: const SizedBox(
                    width: 30,
                    height: 30,
                  ),
                )
              ),
            ),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              border: Border.all(
                color: Utils.clockTheme == ClockThemes.flutter ? Utils.getColorFromTheme(ClockThemes.flutter) : Colors.transparent,
                width: 3
              ),
              borderRadius: BorderRadius.circular(50)
            ),
            child: ClipOval(
              child: Material(
                color: Utils.getColorFromTheme(ClockThemes.flutter),
                child: InkWell(
                  highlightColor: Colors.white.withOpacity(0.1),
                  splashColor: Colors.white.withOpacity(0.3),
                  onTap: () {
                    cService.updateTheme(ClockThemes.flutter);
                    animService.setClockAnimationTheme(ClockThemes.flutter);
                  },
                  child: const SizedBox(
                    width: 30,
                    height: 30,
                    child: Icon(Icons.ac_unit, color: Colors.white, size: 20),
                  ),
                )
              ),
            ),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              border: Border.all(
                color: Utils.clockTheme == ClockThemes.heart ? Utils.getColorFromTheme(ClockThemes.heart) : Colors.transparent,
                width: 3
              ),
              borderRadius: BorderRadius.circular(50)
            ),
            child: ClipOval(
              child: Material(
                color: Utils.getColorFromTheme(ClockThemes.heart),
                child: InkWell(
                  highlightColor: Colors.white.withOpacity(0.1),
                  splashColor: Colors.white.withOpacity(0.3),
                  onTap: () {
                    cService.updateTheme(ClockThemes.heart);
                    animService.setClockAnimationTheme(ClockThemes.heart);
                  },
                  child: const SizedBox(
                    width: 30,
                    height: 30,
                    child: Icon(Icons.favorite, color: Colors.white, size: 20),
                  ),
                )
              ),
            ),
          ),
        ];

        Widget colorSelection = MediaQuery.of(context).orientation == Orientation.portrait ?
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: options
                  ),
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(50)
                  ),
                )
              ]
          ) :
          Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(right: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: options
              ),
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                borderRadius: BorderRadius.circular(50)
              ),
            )
          ]
        );

        return AnimatedScale(
          scale: cService.showColorSelection ? 1 : 0.8, 
          duration: const Duration(milliseconds: 250),
          child:  AnimatedOpacity(
            opacity: cService.showColorSelection ? 1 : 0,
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,
            child: colorSelection,
          )
        );
      }
    );
  }

}