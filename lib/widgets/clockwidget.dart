// represents the animation for each individual digit
// represented as a series of blocks with animations
import 'package:clock_challenge/helpers/clocktheme.dart';
import 'package:clock_challenge/helpers/digitalnumbersides.dart';
import 'package:clock_challenge/helpers/utils.dart';
import 'package:clock_challenge/services/clockthemeservice.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ClockWidget extends StatefulWidget {
  final bool isTimeIndicator;
  final bool isTimeEllapsing;
  final ValueNotifier<int>? widgetNumber;

  const ClockWidget({Key? key, this.widgetNumber, this.isTimeIndicator = false, this.isTimeEllapsing = true}) : super(key: key);
  
  @override
  ClockWidgetState createState() => ClockWidgetState();
}

class ClockWidgetState extends State<ClockWidget> {
  static const double digitalWidthHeight = 40.0;
  static const int fastDuration = 100;
  static const int slowDuration = 500;

  

  // this is the mapping that reprents which digits get to have a side displayed
  // based on the composition of the digit widget
  // i.e. number 0 gets the top, bottom, top left, top right, bottom left and bottom right container displayed
  // while number one only gets the center top and center bottom container displayed
  Map<DigitalNumberSides, List<int>> digitalNumberSidesMapping = {
    DigitalNumberSides.topHorizontal: [0, 2, 3, 5, 6, 7, 8, 9],
    DigitalNumberSides.centerHorizontal: [2, 3, 4, 5, 6, 8, 9],
    DigitalNumberSides.bottomHorizontal: [0, 2, 3, 5, 6, 8, 9],
    DigitalNumberSides.topRight: [0, 2, 3, 4, 7, 8, 9],
    DigitalNumberSides.bottomRight: [0, 3, 4, 5, 6, 7, 8, 9],
    DigitalNumberSides.topLeft: [0, 4, 5, 6, 8, 9],
    DigitalNumberSides.bottomLeft: [0, 2, 6, 8],
    DigitalNumberSides.centerTop: [1],
    DigitalNumberSides.centerBottom: [1],
  };

  // this mapping is to whether turn on or off one of the digit sides
  Map<DigitalNumberSides, bool> digitalNumberSideVisible = {
    DigitalNumberSides.topHorizontal: false,
    DigitalNumberSides.centerHorizontal: false,
    DigitalNumberSides.centerTop: false,
    DigitalNumberSides.centerBottom: false,
    DigitalNumberSides.bottomHorizontal: false,
    DigitalNumberSides.topRight: false,
    DigitalNumberSides.bottomRight: false,
    DigitalNumberSides.topLeft: false,
    DigitalNumberSides.bottomLeft: false
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
      if (mounted) {
        setState(() {
          digitalNumberSideVisible[side] =
              digitalNumberSidesMapping[side]!.contains(widget.widgetNumber!.value);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    return Consumer<ClockThemeService>(
      builder: (context, service, child) {
        ClockTheme clockTheme = Utils.getTheme();
        BoxDecoration numberBoxDecoration = BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(50),
            boxShadow: [
              BoxShadow(
                blurRadius: 20, 
                color: clockTheme.shadow1!, 
                offset: Offset.zero),
              BoxShadow(
                blurRadius: 20, 
                color: clockTheme.shadow2!, 
                offset: Offset.zero
              )
            ],
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.white, Colors.white.withOpacity(0.5)]));

        Widget digitSidesContainer =
            Container(width: 40, height: 120, decoration: numberBoxDecoration);

        Widget digitHorizontalContainer =
            Container(height: 40, decoration: numberBoxDecoration);

        return widget.isTimeIndicator
        ? Container(
            width: digitalWidthHeight,
            height: 200,
            margin: const EdgeInsets.all(10),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AnimatedContainer(
                    width: !widget.isTimeEllapsing ? digitalWidthHeight : 0,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.bounceOut,
                    child: Container(
                      width: digitalWidthHeight,
                      height: digitalWidthHeight,
                      decoration: numberBoxDecoration),
                  ),
                  AnimatedContainer(
                    width: widget.isTimeEllapsing ? digitalWidthHeight : 0,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.bounceOut,
                    child: Container(
                      width: digitalWidthHeight,
                      height: digitalWidthHeight,
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
                                    DigitalNumberSides.topHorizontal]!
                                ? digitalWidthHeight
                                : 0.0,
                            duration: Duration(
                                milliseconds: digitalNumberSideVisible[
                                        DigitalNumberSides.topHorizontal]!
                                    ? slowDuration
                                    : fastDuration),
                            curve: Curves.bounceOut,
                            child: digitHorizontalContainer)),
                    Align(
                        alignment: Alignment.center,
                        child: AnimatedContainer(
                            height: digitalNumberSideVisible[
                                    DigitalNumberSides.centerHorizontal]!
                                ? digitalWidthHeight
                                : 0.0,
                            duration: Duration(
                                milliseconds: digitalNumberSideVisible[
                                        DigitalNumberSides.centerHorizontal]!
                                    ? slowDuration
                                    : fastDuration),
                            curve: Curves.bounceOut,
                            child: digitHorizontalContainer)),
                    Align(
                        alignment: Alignment.bottomCenter,
                        child: AnimatedContainer(
                            height: digitalNumberSideVisible[
                                    DigitalNumberSides.bottomHorizontal]!
                                ? digitalWidthHeight
                                : 0.0,
                            duration: Duration(
                                milliseconds: digitalNumberSideVisible[
                                        DigitalNumberSides.bottomHorizontal]!
                                    ? slowDuration
                                    : fastDuration),
                            curve: Curves.bounceOut,
                            child: digitHorizontalContainer)),
                    Align(
                        alignment: Alignment.topRight,
                        child: AnimatedContainer(
                            width: digitalNumberSideVisible[
                                    DigitalNumberSides.topRight]!
                                ? digitalWidthHeight
                                : 0.0,
                            duration: Duration(
                                milliseconds: digitalNumberSideVisible[
                                        DigitalNumberSides.topRight]!
                                    ? slowDuration
                                    : fastDuration),
                            curve: Curves.bounceOut,
                            child: digitSidesContainer)),
                    Align(
                        alignment: Alignment.bottomRight,
                        child: AnimatedContainer(
                            width: digitalNumberSideVisible[
                                    DigitalNumberSides.bottomRight]!
                                ? digitalWidthHeight
                                : 0.0,
                            duration: Duration(
                                milliseconds: digitalNumberSideVisible[
                                        DigitalNumberSides.bottomRight]!
                                    ? slowDuration
                                    : fastDuration),
                            curve: Curves.bounceOut,
                            child: digitSidesContainer)),
                    Align(
                        alignment: Alignment.topCenter,
                        child: AnimatedContainer(
                            width: digitalNumberSideVisible[
                                    DigitalNumberSides.centerTop]!
                                ? digitalWidthHeight
                                : 0.0,
                            duration: Duration(
                                milliseconds: digitalNumberSideVisible[
                                        DigitalNumberSides.centerTop]!
                                    ? slowDuration
                                    : fastDuration),
                            curve: Curves.bounceOut,
                            child: digitSidesContainer)),
                    Align(
                        alignment: Alignment.bottomCenter,
                        child: AnimatedContainer(
                            width: digitalNumberSideVisible[
                                    DigitalNumberSides.centerBottom]!
                                ? digitalWidthHeight
                                : 0.0,
                            duration: Duration(
                                milliseconds: digitalNumberSideVisible[
                                        DigitalNumberSides.centerBottom]!
                                    ? slowDuration
                                    : fastDuration),
                            curve: Curves.bounceOut,
                            child: digitSidesContainer)),
                    Align(
                        alignment: Alignment.topLeft,
                        child: AnimatedContainer(
                            width: digitalNumberSideVisible[
                                    DigitalNumberSides.topLeft]!
                                ? digitalWidthHeight
                                : 0.0,
                            duration: Duration(
                                milliseconds: digitalNumberSideVisible[
                                        DigitalNumberSides.topLeft]!
                                    ? slowDuration
                                    : fastDuration),
                            curve: Curves.bounceOut,
                            child: digitSidesContainer)),
                    Align(
                        alignment: Alignment.bottomLeft,
                        child: AnimatedContainer(
                            width: digitalNumberSideVisible[
                                    DigitalNumberSides.bottomLeft]!
                                ? digitalWidthHeight
                                : 0.0,
                            duration: Duration(
                                milliseconds: digitalNumberSideVisible[
                                        DigitalNumberSides.bottomLeft]!
                                    ? slowDuration
                                    : fastDuration),
                            curve: Curves.bounceOut,
                            child: digitSidesContainer))
                  ]));
            },
          );
        }
      );
    }
}
