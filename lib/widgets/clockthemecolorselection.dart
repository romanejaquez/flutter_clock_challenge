import 'package:clock_challenge/helpers/utils.dart';
import 'package:clock_challenge/services/clockthemeservice.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ClockThemeColorSelection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    ClockThemeService cService = Provider.of<ClockThemeService>(context, listen: false);

    List<Widget> options = [
      Container(
        margin: const EdgeInsets.all(10),
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
      Container(
        margin: const EdgeInsets.all(10),
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
      Container(
        margin: const EdgeInsets.all(10),
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

    return MediaQuery.of(context).orientation == Orientation.portrait ?
     Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: options
            ),
            padding: const EdgeInsets.all(10),
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
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.5),
            borderRadius: BorderRadius.circular(50)
          ),
        )
      ]
    );
  }

}