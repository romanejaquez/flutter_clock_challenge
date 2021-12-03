import 'dart:async';
import 'package:clock_challenge/services/clockanimationservice.dart';
import 'package:clock_challenge/widgets/clockthemeanimation.dart';
import 'package:clock_challenge/widgets/clockthemeanimationwrapper.dart';
import 'package:clock_challenge/widgets/digitalclockbg.dart';
import 'package:clock_challenge/widgets/digitalclockwidget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

/// A basic digital clock.
///
/// You can do better than this!
class DigitalClock extends StatefulWidget {
  const DigitalClock({Key? key}) : super(key: key);

  @override
  _DigitalClockState createState() => _DigitalClockState();
}

class _DigitalClockState extends State<DigitalClock> {
  DateTime _dateTime = DateTime.now();
  late Timer _timer;
  late String hour;
  late String minute;
  late String second;
  bool timeIndicator = true;

  @override
  void initState() {
    super.initState();
    _updateTime();
    _updateModel();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _updateModel() {
    setState(() {
      // Cause the clock to rebuild when the model changes.
    });
  }

  void _updateTime() {
    setState(() {
      _dateTime = DateTime.now();

      _timer = Timer(
        const Duration(seconds: 1) - Duration(milliseconds: _dateTime.millisecond),
        _updateTime,
      );

      hour = DateFormat('hh')
          .format(_dateTime);
      minute = DateFormat('mm').format(_dateTime);
      second = DateFormat('ss').format(_dateTime);
      timeIndicator = !timeIndicator;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
      children: [
        const DigitalClockBg(),
        Center(
          child: DigitalClockWidget(
            hours: hour,
            minutes: minute,
            seconds: second,
            isTimeEllapsing: timeIndicator,
          )
        )
      ],
    )
    );
  }
}

