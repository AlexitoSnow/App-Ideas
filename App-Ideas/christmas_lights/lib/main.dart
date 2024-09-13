import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  Map<MaterialColor, Color> colors = {};
  bool lightsOn = true;
  bool start = true;
  Timer? timer;
  int items = 0;
  int count = 0;

  @override
  void initState() {
    super.initState();
    items = Random().nextInt(5);
    count = Random().nextInt(10);
    colors = {
      Colors.red: Colors.redAccent,
      Colors.green: Colors.lightGreen,
      Colors.blue: Colors.lightBlue,
      Colors.amber: Colors.amberAccent,
    };

    timer = Timer.periodic(const Duration(milliseconds: 900), (Timer t) {
      setState(() {
        lightsOn = !lightsOn;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text('Christmas Lights'),
          actions: [
            Switch(
              value: start,
              onChanged: (value) => setState(() {
                start = !start;
              }),
              activeColor: Colors.green,
              inactiveTrackColor: Colors.red,
            )
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              items,
              (i) {
                return LightsRow(
                    count: count,
                    colors: colors,
                    start: start,
                    lightsOn: i.isEven ? lightsOn : !lightsOn);
              },
            ),
          ).spacing(20),
        ),
      ),
    );
  }
}

extension Spacing on Column {
  Column spacing(double spacing) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      key: key,
      mainAxisAlignment: mainAxisAlignment,
      textBaseline: textBaseline,
      mainAxisSize: mainAxisSize,
      textDirection: textDirection,
      verticalDirection: verticalDirection,
      children: List.generate(
        children.length * 2 - 1,
        (i) {
          return i.isEven ? children[i ~/ 2] : SizedBox(height: spacing);
        },
      ),
    );
  }
}

class LightsRow extends StatelessWidget {
  const LightsRow({
    super.key,
    required this.colors,
    required this.start,
    required this.lightsOn,
    this.count = 10,
  });

  final Map<MaterialColor, Color> colors;
  final bool start;
  final bool lightsOn;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(
        count,
        (i) {
          int index = i % colors.length;
          return ChristmasLight(
            on: start
                ? i.isEven
                    ? lightsOn
                    : !lightsOn
                : false,
            mainColor: colors.keys.elementAt(index),
            lightColor: colors.values.elementAt(index),
          );
        },
      ),
    );
  }
}

class ChristmasLight extends StatefulWidget {
  const ChristmasLight({
    super.key,
    this.size = 100,
    required this.on,
    required this.mainColor,
    required this.lightColor,
  });

  final double size;
  final bool on;
  final MaterialColor mainColor;
  final Color lightColor;

  @override
  State<ChristmasLight> createState() => _ChristmasLightState();
}

class _ChristmasLightState extends State<ChristmasLight> {
  @override
  Widget build(BuildContext context) {
    final radius = widget.size / 2;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: widget.size,
      height: widget.size,
      decoration: BoxDecoration(
          color: widget.mainColor[widget.on ? 500 : 900]!,
          boxShadow: !widget.on
              ? []
              : [
                  BoxShadow(
                    blurRadius: 10,
                    spreadRadius: 5,
                    color: widget.lightColor,
                  ),
                ],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(radius),
            bottomRight: Radius.circular(radius),
          )),
    );
  }
}
