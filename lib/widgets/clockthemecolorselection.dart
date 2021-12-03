import 'package:clock_challenge/helpers/utils.dart';
import 'package:clock_challenge/services/clockthemeservice.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ClockThemeColorSelection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

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
                color: Utils.clockTheme == ClockThemes.green ? Utils.getColorFromTheme(ClockThemes.green) : Colors.transparent,
                width: 3
              ),
              borderRadius: BorderRadius.circular(50)
            ),
            child: ClipOval(
              child: Material(
                color: Utils.getColorFromTheme(ClockThemes.green),
                child: InkWell(
                  highlightColor: Colors.white.withOpacity(0.1),
                  splashColor: Colors.white.withOpacity(0.3),
                  onTap: () {
                    cService.updateTheme(ClockThemes.green);
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
                color: Utils.clockTheme == ClockThemes.fuchsia ? Utils.getColorFromTheme(ClockThemes.fuchsia) : Colors.transparent, 
                width: 3
              ),
              borderRadius: BorderRadius.circular(50)
            ),
            child: ClipOval(
              child: Material(
                color: Utils.getColorFromTheme(ClockThemes.fuchsia),
                child: InkWell(
                  highlightColor: Colors.white.withOpacity(0.1),
                  splashColor: Colors.white.withOpacity(0.3),
                  onTap: () {
                    cService.updateTheme(ClockThemes.fuchsia);
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
                color: Utils.clockTheme == ClockThemes.blue ? Utils.getColorFromTheme(ClockThemes.blue) : Colors.transparent,
                width: 3
              ),
              borderRadius: BorderRadius.circular(50)
            ),
            child: ClipOval(
              child: Material(
                color: Utils.getColorFromTheme(ClockThemes.blue),
                child: InkWell(
                  highlightColor: Colors.white.withOpacity(0.1),
                  splashColor: Colors.white.withOpacity(0.3),
                  onTap: () {
                    cService.updateTheme(ClockThemes.blue);
                  },
                  child: const SizedBox(
                    width: 30,
                    height: 30,
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