import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:solarcontrol/contexts/globalContext.dart';

Widget ControlWidget(context) {
  globalContext gl = globalContext();

  return Container(
    child: JoyStick(),
  );
}

class JoyStick extends StatefulWidget {
  JoyStick({Key? key}) : super(key: key);

  @override
  State<JoyStick> createState() => _JoyStickState();
}

class _JoyStickState extends State<JoyStick> {
  Offset localOffset = new Offset(0, 0);
  bool isPanned = false;
  @override
  Widget build(BuildContext context) {
    var diameter = MediaQuery.of(context).size.width * 0.65;
    var maxDistance = sqrt(pow(diameter / 2, 2) + pow(diameter / 2, 2)) / 2;
    var miniJoyDiameter = diameter * 0.3;
    var miniJoyRadius = miniJoyDiameter / 2;
    return Center(
      child: Listener(
          child: Container(
              width: diameter,
              height: diameter,
              decoration: BoxDecoration(
                  gradient: RadialGradient(
                    center: Alignment(0, 0),
                    radius: 0.6,
                    colors: <Color>[
                      Color(0xFF303030), // yellow sun
                      Color(0xFF222222), // blue sky
                    ],
                    stops: <double>[0.3, 1.0],
                  ),
                  shape: BoxShape.circle,
                  color: Colors.cyan[900]),
              child: Center(
                child: Transform.translate(
                  offset: localOffset,
                  child: Container(
                    width: miniJoyDiameter,
                    height: miniJoyDiameter,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          center: Alignment(0, 0),
                          radius: 0.6,
                          colors: <Color>[
                            Color(0xFFAAAAAA),
                            Color(0xFFFFFFFF),
                          ],
                          stops: <double>[0.1, 1.0],
                        )),
                  ),
                ),
              )),
          onPointerDown: (data) {
            setState(() {
              isPanned = true;
            });
          },
          onPointerMove: (data) {
            print(localOffset);
            setState(() {
              var lo = new Offset((data.localPosition.dx - diameter / 2),
                  (data.localPosition.dy - diameter / 2));

              localOffset = new Offset(
                lo.distance.clamp(0, maxDistance) * cos(lo.direction),
                lo.distance.clamp(0, maxDistance) * sin(lo.direction),
              );
            });
          },
          onPointerUp: (data) {
            setState(() {
              isPanned = false;
              localOffset = new Offset(0, 0);
            });
          }),
    );
  }
}
