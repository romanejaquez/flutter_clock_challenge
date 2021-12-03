import 'package:clock_challenge/helpers/clocktheme.dart';
import 'package:clock_challenge/helpers/utils.dart';
import 'package:clock_challenge/services/clockthemeservice.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DigitalClockOptions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return Consumer<ClockThemeService>(
      builder: (context, cService, child) {
        ClockTheme clockTheme = Utils.getTheme();

        List<Widget> options = [
          Container(
            child: const Icon(Icons.timer, color: Colors.white, size: 30),
            decoration: BoxDecoration(
              boxShadow:[
                BoxShadow(color: clockTheme.shadow2!, blurRadius: 20, offset: Offset.zero)
              ]
            ),
          ),
          Container(
            child: const Icon(Icons.wb_sunny, color: Colors.white, size: 30),
            decoration: BoxDecoration(
              boxShadow:[
                BoxShadow(color: clockTheme.shadow2!, blurRadius: 20, offset: Offset.zero)
              ]
            ),
          ),
          GestureDetector(
            onTap: () {
              cService.toggleColorSelection();
            },
            child: Container(
              child: const Icon(Icons.palette, color: Colors.white, size: 30),
              decoration: BoxDecoration(
                boxShadow:[
                  BoxShadow(color: clockTheme.shadow2!, blurRadius: 20, offset: Offset.zero)
                ]
              ),
            ),
          ),
          Container(
            child: const Icon(Icons.thermostat, color: Colors.white, size: 30),
            decoration: BoxDecoration(
              boxShadow:[
                BoxShadow(color: clockTheme.shadow2!, blurRadius: 20, offset: Offset.zero)
              ]
            ),
          ),
          Container(
            child: const Icon(Icons.calendar_today, color: Colors.white, size: 30),
            decoration: BoxDecoration(
              boxShadow:[
                BoxShadow(color: clockTheme.shadow2!, blurRadius: 20, offset: Offset.zero)
              ]
            ),
          )
        ];

        return MediaQuery.of(context).orientation == Orientation.portrait ? 
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: options,
          ) :
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: options,
          );
      }
    );
  }

}