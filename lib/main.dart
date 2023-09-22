import 'package:clock_challenge/services/clockanimationservice.dart';
import 'package:clock_challenge/services/clockthemeservice.dart';
import 'package:clock_challenge/widgets/clockoptionsanimation.dart';
import 'package:clock_challenge/widgets/clockthemeanimationwrapper.dart';
import 'package:clock_challenge/widgets/digitalclock.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

void main() async {

  await initializeDateFormatting('cs_CZ', null);
  tz.initializeTimeZones();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ClockThemeService()
        ),
        ChangeNotifierProvider(
          create: (_) => ClockAnimationService()
        )
      ],
      child: const MyApp()
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Clock',
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        
        return child!;
      },
      home: Stack(
        children: [
          const Positioned(
            left: -90,
            top: 0,
            bottom: 0,
            right: 0,
            child: DigitalClock()
          ),
          ClockThemeAnimationWrapper(),
          Center(
            child: Transform.scale(
              scale: 1.125,
              alignment: Alignment.center,
              child: const ClockOptionsAnimation()
            )
          ),
        ]
      )
    );
  }
}




