
// This is the wrapper class around my digital clock
import 'package:clock_challenge/helpers/clocktheme.dart';
import 'package:clock_challenge/helpers/utils.dart';
import 'package:clock_challenge/widgets/clockthemecolorselection.dart';
import 'package:clock_challenge/widgets/clockwidget.dart';
import 'package:clock_challenge/widgets/digitalclockoptions.dart';
import 'package:flutter/material.dart';

class DigitalClockWidget extends StatefulWidget {
  final String? hours;
  final String? minutes;
  final String? seconds;
  final bool? isTimeEllapsing;

  const DigitalClockWidget({Key? key, this.hours, this.minutes, this.seconds, this.isTimeEllapsing = true}) : super(key: key);

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

    ClockTheme clockTheme = Utils.getTheme();
    
    // parsing the digits out of the provided inputs
    var firstHourDigit = widget.hours![0];
    var secondHourDigit = widget.hours![1];
    var thirdValue = widget.minutes![0];
    var fourthValue = widget.minutes![1];
    var fifthValue = widget.seconds![0];
    var sixthValue = widget.seconds![1];

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
            child: //MediaQuery.of(context).orientation == Orientation.portrait ?
             Stack(
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
            // child: Padding(
            //   padding: const EdgeInsets.all(30.0),
            //   child: Column(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       Row(
            //         children: [
            //           ClockWidget(widgetNumber: vNumber1),
            //           ClockWidget(widgetNumber: vNumber2)
            //         ]
            //       ),
            //       Row(
            //         children: [
            //           ClockWidget(widgetNumber: vNumber3),
            //           ClockWidget(widgetNumber: vNumber4)
            //         ],
            //       ),
            //       Row(
            //         children: [
            //           ClockWidget(widgetNumber: vNumber5),
            //           ClockWidget(widgetNumber: vNumber6)
            //         ],
            //       )
            //     ],
            //   ),
            // )
          ),
        ),
        // Padding(
        //   padding: const EdgeInsets.all(40.0),
        //   child: Align(
        //     alignment: Alignment.bottomCenter,
        //     child: DigitalClockOptions()
        //   ),
        // ),
        // Padding(
        //   padding: const EdgeInsets.all(40.0),
        //   child: Align(
        //     alignment: Alignment.bottomCenter,
        //     child: DigitalClockOptions()
        //   ),
        // ),
      ],
    );
  }
}
