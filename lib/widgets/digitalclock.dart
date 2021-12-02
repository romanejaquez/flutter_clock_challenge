import 'dart:async';
import 'package:clock_challenge/widgets/digitalclockwidget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
        Stack(
          children: [
          Container(
            color: const Color(0xFF102310),
            width: MediaQuery.of(context).size.width
          ),
          Container(
            decoration: const BoxDecoration(
              color: Color(0xFF1E4620),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(50),
                bottomRight: Radius.circular(50)
              )
            ),
            width: MediaQuery.of(context).size.width * 0.8
          ),
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFF2D6930),
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(50),
                bottomRight: Radius.circular(50)
              ),
              boxShadow: [
                BoxShadow(
                  blurRadius: 30,
                  color: const Color(0xFF0A340C).withOpacity(0.5),
                  offset: Offset.zero
                )
              ],
            ),
            width: MediaQuery.of(context).size.width * 0.6
          ),
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFF3D8C40),
              boxShadow: [
                BoxShadow(
                  blurRadius: 30,
                  color: const Color(0xFF0A340C).withOpacity(0.5),
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
              color: const Color(0xFF4DAF50),
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(50),
                bottomRight: Radius.circular(50)
              ),
              boxShadow: [
                BoxShadow(
                  blurRadius: 30,
                  color: const Color(0xFF0A340C).withOpacity(0.5),
                  offset: Offset.zero
                )
              ]
            ),
            width: MediaQuery.of(context).size.width * 0.2
          )
        ]
      ),
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

