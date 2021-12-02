import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: DigitalClock()
    );
  }
}


// This is the wrapper class around my digital clock
class DigitalClockWidget extends StatefulWidget {
  String? hours;
  String? minutes;
  String? seconds;
  bool? isTimeEllapsing = false;

  DigitalClockWidget({this.hours, this.minutes, this.seconds, this.isTimeEllapsing = true});

  @override
  DigitalClockWidgetState createState() => DigitalClockWidgetState();
}

class DigitalClockWidgetState extends State<DigitalClockWidget> {
  ValueNotifier<int> vNumber1 = ValueNotifier<int>(0);
  ValueNotifier<int> vNumber2 = ValueNotifier<int>(0);
  ValueNotifier<int> vNumber3 = ValueNotifier<int>(0);
  ValueNotifier<int> vNumber4 = ValueNotifier<int>(0);
  ValueNotifier<int> vNumber5 = ValueNotifier<int>(0);
  ValueNotifier<int> vNumber6 = ValueNotifier<int>(0);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    // parsing the digits out of the provided inputs
    var firstHourDigit = widget.hours![0];
    var secondHourDigit = widget.hours![1];
    var thirdValue = widget.minutes![0];
    var fourthValue = widget.minutes![1];
    var fifthValue = widget.seconds![0];
    var sixthValue = widget.seconds![1];

    // want to test how the seconds work?
    // comment the above two lines and parse the seconds' value off the widget property and do the following
    // for the third and fourth value:
    // var thirdValue = widget.seconds[0];
    // var fourthValue = widget.seconds[1];

    vNumber1.value = int.parse(firstHourDigit);
    vNumber2.value = int.parse(secondHourDigit);
    vNumber3.value = int.parse(thirdValue);
    vNumber4.value = int.parse(fourthValue);
    vNumber5.value = int.parse(fifthValue);
    vNumber6.value = int.parse(sixthValue);

    return Stack(
      children: [
        Transform.scale(
          scale: 0.9,
          child: Center(
            child: Stack(
              children: [
                
                Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ClockWidget(widgetNumber: vNumber1),
                        ClockWidget(widgetNumber: vNumber2),
                        ClockWidget(
                            widgetNumber: ValueNotifier<int>(0), isTimeIndicator: true, isTimeEllapsing: widget.isTimeEllapsing!,),
                        ClockWidget(widgetNumber: vNumber3),
                        ClockWidget(widgetNumber: vNumber4),
                        const SizedBox(width: 200),
                      ]
                    ),
                  ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Transform.scale(
                    scale: 0.4,
                    origin: const Offset(20.0, -10.0),
                    alignment: Alignment.bottomRight,
                    child: Row(
                      children: [
                        const SizedBox(width: 300),
                        ClockWidget(widgetNumber: vNumber5),
                        ClockWidget(widgetNumber: vNumber6),
                      ],
                    )
                  )
                )
              ],
            )
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(40.0),
          child: Align(
            alignment: Alignment.topRight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  child: const Icon(Icons.timer, color: Colors.white, size: 30),
                  decoration: BoxDecoration(
                    boxShadow:[
                      BoxShadow(color: Colors.green.withOpacity(0.6), blurRadius: 20, offset: Offset.zero)
                    ]
                  ),
                ),
                const SizedBox(width: 40),
                Container(
                  child: const Icon(Icons.wb_sunny, color: Colors.white, size: 30),
                  decoration: BoxDecoration(
                    boxShadow:[
                      BoxShadow(color: Colors.green.withOpacity(0.6), blurRadius: 20, offset: Offset.zero)
                    ]
                  ),
                ),
                const SizedBox(width: 40),
                Container(
                  child: const Icon(Icons.palette, color: Colors.white, size: 30),
                  decoration: BoxDecoration(
                    boxShadow:[
                      BoxShadow(color: Colors.green.withOpacity(0.6), blurRadius: 20, offset: Offset.zero)
                    ]
                  ),
                )
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(40.0),
          child: Align(
            alignment: Alignment.topLeft,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  child: Row(
                    children: const [
                      Icon(Icons.thermostat, color: Colors.white, size: 30),
                    ],
                  ),
                  decoration: BoxDecoration(
                    boxShadow:[
                      BoxShadow(color: Colors.green.withOpacity(0.6), blurRadius: 20, offset: Offset.zero)
                    ]
                  ),
                ),
                const SizedBox(width: 40),
                Container(
                  child: Icon(Icons.calendar_today, color: Colors.white, size: 30),
                  decoration: BoxDecoration(
                    boxShadow:[
                      BoxShadow(color: Colors.green.withOpacity(0.6), blurRadius: 20, offset: Offset.zero)
                    ]
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// represents the animation for each individual digit
// represented as a series of blocks with animations
class ClockWidget extends StatefulWidget {
  bool isTimeIndicator;
  bool isTimeEllapsing;
  ValueNotifier<int>? widgetNumber;

  ClockWidget({this.widgetNumber, this.isTimeIndicator = false, this.isTimeEllapsing = true});
  @override
  ClockWidgetState createState() => ClockWidgetState();
}

// enum representing all sides in the digit to be animated
enum DigitalNumberSides {
  TopHorizontal,
  CenterHorizontal,
  BottomHorizontal,
  TopRight,
  BottomRight,
  TopLeft,
  BottomLeft,
  CenterTop,
  CenterBottom
}

class ClockWidgetState extends State<ClockWidget> {
  static const double DIGIT_WIDTH_HEIGHT = 40.0;
  static const int FAST_DURATION = 100;
  static const int SLOW_DURATION = 500;

  static BoxDecoration numberBoxDecoration = BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(50),
      boxShadow: [
        BoxShadow(
          blurRadius: 20, 
          color: const Color(0xFF0A340C).withOpacity(0.2), 
          offset: Offset.zero),
        const BoxShadow(
          blurRadius: 20, 
          color: Colors.green, 
          offset: Offset.zero)
      ],
      gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.white, Colors.white.withOpacity(0.5)]));

  final Container digitSidesContainer =
      Container(width: 40, height: 120, decoration: numberBoxDecoration);

  final Container digitHorizontalContainer =
      Container(height: 40, decoration: numberBoxDecoration);

  // this is the mapping that reprents which digits get to have a side displayed
  // based on the composition of the digit widget
  // i.e. number 0 gets the top, bottom, top left, top right, bottom left and bottom right container displayed
  // while number one only gets the center top and center bottom container displayed
  Map<DigitalNumberSides, List<int>> digitalNumberSidesMapping = {
    DigitalNumberSides.TopHorizontal: [0, 2, 3, 5, 6, 7, 8, 9],
    DigitalNumberSides.CenterHorizontal: [2, 3, 4, 5, 6, 8, 9],
    DigitalNumberSides.BottomHorizontal: [0, 2, 3, 5, 6, 8, 9],
    DigitalNumberSides.TopRight: [0, 2, 3, 4, 7, 8, 9],
    DigitalNumberSides.BottomRight: [0, 3, 4, 5, 6, 7, 8, 9],
    DigitalNumberSides.TopLeft: [0, 4, 5, 6, 8, 9],
    DigitalNumberSides.BottomLeft: [0, 2, 6, 8],
    DigitalNumberSides.CenterTop: [1],
    DigitalNumberSides.CenterBottom: [1],
  };

  // this mapping is to whether turn on or off one of the digit sides
  Map<DigitalNumberSides, bool> digitalNumberSideVisible = {
    DigitalNumberSides.TopHorizontal: false,
    DigitalNumberSides.CenterHorizontal: false,
    DigitalNumberSides.CenterTop: false,
    DigitalNumberSides.CenterBottom: false,
    DigitalNumberSides.BottomHorizontal: false,
    DigitalNumberSides.TopRight: false,
    DigitalNumberSides.BottomRight: false,
    DigitalNumberSides.TopLeft: false,
    DigitalNumberSides.BottomLeft: false
  };

  @override
  void initState() {
    super.initState();
    onExecuteAnimations();

    // upon a number changing, trigger its corresponding animation(s)
    widget.widgetNumber!.addListener(() {
      onExecuteAnimations();
    });
  }

  void onExecuteAnimations() {
    digitalNumberSidesMapping.keys.forEach((side) {
      setState(() {
        digitalNumberSideVisible[side] =
            digitalNumberSidesMapping[side]!.contains(widget.widgetNumber!.value);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.isTimeIndicator
        ? Container(
            width: DIGIT_WIDTH_HEIGHT,
            height: 200,
            margin: const EdgeInsets.all(10),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AnimatedContainer(
                    width: !widget.isTimeEllapsing ? DIGIT_WIDTH_HEIGHT : 0,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.bounceOut,
                    child: Container(
                      width: DIGIT_WIDTH_HEIGHT,
                      height: DIGIT_WIDTH_HEIGHT,
                      decoration: numberBoxDecoration),
                  ),
                  AnimatedContainer(
                    width: widget.isTimeEllapsing ? DIGIT_WIDTH_HEIGHT : 0,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.bounceOut,
                    child: Container(
                      width: DIGIT_WIDTH_HEIGHT,
                      height: DIGIT_WIDTH_HEIGHT,
                      decoration: numberBoxDecoration)
                  )
                ]))
        : ValueListenableBuilder(
            valueListenable: widget.widgetNumber!,
            builder: (context, value, child) {
              return Container(
                  margin: const EdgeInsets.all(10),
                  width: 120,
                  height: 200,
                  color: Colors.transparent,
                  child: Stack(children: <Widget>[
                    Align(
                        alignment: Alignment.topCenter,
                        child: AnimatedContainer(
                            height: digitalNumberSideVisible[
                                    DigitalNumberSides.TopHorizontal]!
                                ? DIGIT_WIDTH_HEIGHT
                                : 0.0,
                            duration: Duration(
                                milliseconds: digitalNumberSideVisible[
                                        DigitalNumberSides.TopHorizontal]!
                                    ? SLOW_DURATION
                                    : FAST_DURATION),
                            curve: Curves.bounceOut,
                            child: digitHorizontalContainer)),
                    Align(
                        alignment: Alignment.center,
                        child: AnimatedContainer(
                            height: digitalNumberSideVisible[
                                    DigitalNumberSides.CenterHorizontal]!
                                ? DIGIT_WIDTH_HEIGHT
                                : 0.0,
                            duration: Duration(
                                milliseconds: digitalNumberSideVisible[
                                        DigitalNumberSides.CenterHorizontal]!
                                    ? SLOW_DURATION
                                    : FAST_DURATION),
                            curve: Curves.bounceOut,
                            child: digitHorizontalContainer)),
                    Align(
                        alignment: Alignment.bottomCenter,
                        child: AnimatedContainer(
                            height: digitalNumberSideVisible[
                                    DigitalNumberSides.BottomHorizontal]!
                                ? DIGIT_WIDTH_HEIGHT
                                : 0.0,
                            duration: Duration(
                                milliseconds: digitalNumberSideVisible[
                                        DigitalNumberSides.BottomHorizontal]!
                                    ? SLOW_DURATION
                                    : FAST_DURATION),
                            curve: Curves.bounceOut,
                            child: digitHorizontalContainer)),
                    Align(
                        alignment: Alignment.topRight,
                        child: AnimatedContainer(
                            width: digitalNumberSideVisible[
                                    DigitalNumberSides.TopRight]!
                                ? DIGIT_WIDTH_HEIGHT
                                : 0.0,
                            duration: Duration(
                                milliseconds: digitalNumberSideVisible[
                                        DigitalNumberSides.TopRight]!
                                    ? SLOW_DURATION
                                    : FAST_DURATION),
                            curve: Curves.bounceOut,
                            child: digitSidesContainer)),
                    Align(
                        alignment: Alignment.bottomRight,
                        child: AnimatedContainer(
                            width: digitalNumberSideVisible[
                                    DigitalNumberSides.BottomRight]!
                                ? DIGIT_WIDTH_HEIGHT
                                : 0.0,
                            duration: Duration(
                                milliseconds: digitalNumberSideVisible[
                                        DigitalNumberSides.BottomRight]!
                                    ? SLOW_DURATION
                                    : FAST_DURATION),
                            curve: Curves.bounceOut,
                            child: digitSidesContainer)),
                    Align(
                        alignment: Alignment.topCenter,
                        child: AnimatedContainer(
                            width: digitalNumberSideVisible[
                                    DigitalNumberSides.CenterTop]!
                                ? DIGIT_WIDTH_HEIGHT
                                : 0.0,
                            duration: Duration(
                                milliseconds: digitalNumberSideVisible[
                                        DigitalNumberSides.CenterTop]!
                                    ? SLOW_DURATION
                                    : FAST_DURATION),
                            curve: Curves.bounceOut,
                            child: digitSidesContainer)),
                    Align(
                        alignment: Alignment.bottomCenter,
                        child: AnimatedContainer(
                            width: digitalNumberSideVisible[
                                    DigitalNumberSides.CenterBottom]!
                                ? DIGIT_WIDTH_HEIGHT
                                : 0.0,
                            duration: Duration(
                                milliseconds: digitalNumberSideVisible[
                                        DigitalNumberSides.CenterBottom]!
                                    ? SLOW_DURATION
                                    : FAST_DURATION),
                            curve: Curves.bounceOut,
                            child: digitSidesContainer)),
                    Align(
                        alignment: Alignment.topLeft,
                        child: AnimatedContainer(
                            width: digitalNumberSideVisible[
                                    DigitalNumberSides.TopLeft]!
                                ? DIGIT_WIDTH_HEIGHT
                                : 0.0,
                            duration: Duration(
                                milliseconds: digitalNumberSideVisible[
                                        DigitalNumberSides.TopLeft]!
                                    ? SLOW_DURATION
                                    : FAST_DURATION),
                            curve: Curves.bounceOut,
                            child: digitSidesContainer)),
                    Align(
                        alignment: Alignment.bottomLeft,
                        child: AnimatedContainer(
                            width: digitalNumberSideVisible[
                                    DigitalNumberSides.BottomLeft]!
                                ? DIGIT_WIDTH_HEIGHT
                                : 0.0,
                            duration: Duration(
                                milliseconds: digitalNumberSideVisible[
                                        DigitalNumberSides.BottomLeft]!
                                    ? SLOW_DURATION
                                    : FAST_DURATION),
                            curve: Curves.bounceOut,
                            child: digitSidesContainer))
                  ]));
            },
          );
  }
}


/// A basic digital clock.
///
/// You can do better than this!
class DigitalClock extends StatefulWidget {

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
        Duration(seconds: 1) - Duration(milliseconds: _dateTime.millisecond),
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

