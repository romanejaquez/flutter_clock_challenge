import 'package:clock_challenge/services/clockanimationservice.dart';
import 'package:clock_challenge/services/clockthemeservice.dart';
import 'package:clock_challenge/widgets/clockthemeanimationwrapper.dart';
import 'package:clock_challenge/widgets/digitalclock.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
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
      home: Stack(
        children: [
          const DigitalClock(),
          ClockThemeAnimationWrapper(),
        ]
      )
    );
  }
}




