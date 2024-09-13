import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: const MainApp(),
    theme: ThemeData(
      colorSchemeSeed: Colors.purple,
    ),
  ));
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  //circular
  double topLeft = 0;
  double topRight = 0;
  double bottomRight = 0;
  double bottomLeft = 0;

  //elliptical
  double topLeftX = 0;
  double topLeftY = 0;
  double topRightX = 0;
  double topRightY = 0;
  double bottomRightX = 0;
  double bottomRightY = 0;
  double bottomLeftX = 0;
  double bottomLeftY = 0;

  bool circular = false;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    const widthFactor = 0.4;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Border Radius Previewer'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: circular
                ? circularRadius(width, height, widthFactor)
                : ellipticalRadius(width, height, widthFactor),
          ),
        ),
      ),
    );
  }

  List<Widget> ellipticalRadius(width, height, widthFactor) {
    return [
      Stack(
        children: [
          Container(
            width: height * widthFactor,
            height: height * widthFactor,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 2),
            ),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: height * widthFactor,
            height: height * widthFactor,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: const [Colors.purple, Colors.blue],
                begin: topLeft <= 0.5 ? Alignment.topLeft : Alignment.topRight,
                end: bottomRight <= 0.5
                    ? Alignment.bottomRight
                    : Alignment.bottomLeft,
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.elliptical(topLeftX * 1000, topLeftY * 1000),
                topRight: Radius.elliptical(topRightX * 1000, topRightY * 1000),
                bottomRight:
                    Radius.elliptical(bottomRightX * 1000, bottomRightY * 1000),
                bottomLeft:
                    Radius.elliptical(bottomLeftX * 1000, bottomLeftY * 1000),
              ),
            ),
          ),
        ],
      ),
      const SizedBox(height: 16),
      const Text('Top Left X / Top Left Y'),
      Row(
        children: [
          Slider.adaptive(
            onChanged: (value) => setState(() => topLeftX = value),
            value: topLeftX,
          ).width(width * widthFactor / 2),
          Slider.adaptive(
            onChanged: (value) => setState(() => topLeftY = value),
            value: topLeftY,
          ).width(width * widthFactor / 2),
        ],
      ),
      const SizedBox(height: 16),
      const Text('Top Right X / Top Right Y'),
      Row(
        children: [
          Slider.adaptive(
            value: topRightX,
            onChanged: (value) => setState(() => topRightX = value),
          ).width(width * widthFactor / 2),
          Slider.adaptive(
            onChanged: (value) => setState(() => topRightY = value),
            value: topRightY,
          ).width(width * widthFactor / 2),
        ],
      ),
      const SizedBox(height: 16),
      const Text('Bottom Left X / Bottom Left Y'),
      Row(
        children: [
          Slider.adaptive(
            value: bottomLeftX,
            onChanged: (value) => setState(() => bottomLeftX = value),
          ).width(width * widthFactor / 2),
          Slider.adaptive(
            onChanged: (value) => setState(() => bottomLeftY = value),
            value: bottomLeftY,
          ).width(width * widthFactor / 2),
        ],
      ),
      const SizedBox(height: 16),
      const Text('Bottom Right X / Bottom Right Y'),
      Row(
        children: [
          Slider.adaptive(
            value: bottomRightX,
            onChanged: (value) => setState(() => bottomRightX = value),
          ).width(width * widthFactor / 2),
          Slider.adaptive(
            onChanged: (value) => setState(() => bottomRightY = value),
            value: bottomRightY,
          ).width(width * widthFactor / 2),
        ],
      ),
    ];
  }

  List<Widget> circularRadius(width, height, widthFactor) {
    return [
      AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: height * widthFactor,
        height: height * widthFactor,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: const [Colors.purple, Colors.blue],
            begin: topLeft <= 0.5 ? Alignment.topLeft : Alignment.topRight,
            end: bottomRight <= 0.5
                ? Alignment.bottomRight
                : Alignment.bottomLeft,
          ),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(topLeft * 1000),
            topRight: Radius.circular(topRight * 1000),
            bottomRight: Radius.circular(bottomRight * 1000),
            bottomLeft: Radius.circular(bottomLeft * 1000),
          ),
        ),
      ),
      const SizedBox(height: 16),
      const Text('Top Left / Top Right'),
      Row(
        children: [
          Slider.adaptive(
            onChanged: (value) => setState(() => topLeft = value),
            value: topLeft,
          ).width(width * widthFactor / 2),
          Slider.adaptive(
            onChanged: (value) => setState(() => topRight = value),
            value: topRight,
          ).width(width * widthFactor / 2),
        ],
      ),
      const SizedBox(height: 16),
      const Text('Bottom Left / Bottom Right'),
      Row(
        children: [
          Slider.adaptive(
            value: bottomLeft,
            onChanged: (value) => setState(() => bottomLeft = value),
          ).width(width * widthFactor / 2),
          Slider.adaptive(
            onChanged: (value) => setState(() => bottomRight = value),
            value: bottomRight,
          ).width(width * widthFactor / 2),
        ],
      ),
    ];
  }
}

extension WidgetUtils on Widget {
  SizedBox width(double width) {
    return SizedBox(width: width, child: this);
  }
}
