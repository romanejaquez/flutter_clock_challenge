import 'package:clock_challenge/helpers/clocktheme.dart';
import 'package:clock_challenge/helpers/utils.dart';
import 'package:clock_challenge/services/clockthemeservice.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DigitalClockBg extends StatelessWidget {
  const DigitalClockBg({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    
    return Consumer<ClockThemeService>(
      builder: (context, service, child) {
        ClockTheme theme = Utils.getTheme();
        return Stack(
          children: [
            Container(
              color: theme.color1,
              width: MediaQuery.of(context).size.width
            ),
            Container(
              decoration: BoxDecoration(
                color: theme.color2,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(50),
                  bottomRight: Radius.circular(50)
                ),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 30,
                    color: theme.colorShadow!,
                    offset: Offset.zero
                  )
                ]
              ),
              width: MediaQuery.of(context).size.width * 0.8
            ),
            Container(
              decoration: BoxDecoration(
                color: theme.color3,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(50),
                  bottomRight: Radius.circular(50)
                ),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 30,
                    color: theme.colorShadow!,
                    offset: Offset.zero
                  )
                ],
              ),
              width: MediaQuery.of(context).size.width * 0.6
            ),
            Container(
              decoration: BoxDecoration(
                color: theme.color4,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 30,
                    color: theme.colorShadow!,
                    offset: Offset.zero
                  )
                ],
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(50),
                  bottomRight: Radius.circular(50)
                )
              ),
              width: MediaQuery.of(context).size.width * 0.4
            ),
            Container(
              decoration: BoxDecoration(
                color: theme.color5,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(50),
                  bottomRight: Radius.circular(50)
                ),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 30,
                    color: theme.colorShadow!,
                    offset: Offset.zero
                  )
                ]
              ),
              width: MediaQuery.of(context).size.width * 0.2
            )
          ]
        );
      }
    );
  }

}