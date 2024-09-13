import 'package:flutter/material.dart';
import 'dart:math';

import 'package:flutter/services.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key})
      : binaryController = TextEditingController(),
        decimalController = TextEditingController();
  final TextEditingController binaryController;
  final TextEditingController decimalController;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    const widthFactor = 0.6;
    return MaterialApp(
      theme: ThemeData(
        colorSchemeSeed: Colors.red,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Binary to Decimal'),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            children: [
              TextField(
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-1]')),
                ],
                controller: binaryController,
                decoration: InputDecoration(
                  labelText: 'Binary Number',
                  suffixIcon: IconButton(
                    onPressed: () {
                      binaryController.clear();
                      decimalController.clear();
                    },
                    icon: const Icon(Icons.clear),
                  ),
                ),
              ).width(width * widthFactor),
              const Text('to', textAlign: TextAlign.center).paddingAll(4),
              TextField(
                readOnly: true,
                controller: decimalController,
                decoration: InputDecoration(
                  labelText: 'Decimal Number',
                  suffixIcon: IconButton(
                    onPressed: () {
                      Clipboard.setData(ClipboardData(
                        text: decimalController.text,
                      ));
                    },
                    icon: const Icon(Icons.copy),
                  ),
                ),
              ).width(width * widthFactor),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () => binaryController.text += '0',
                    child: const Text('0'),
                  ).width(width * widthFactor / 3),
                  const SizedBox(width: 4),
                  ElevatedButton(
                    onPressed: () => binaryController.text += '1',
                    child: const Text('1'),
                  ).width(width * widthFactor / 3),
                  const SizedBox(width: 4),
                  ElevatedButton(
                    onPressed: () {
                      if (binaryController.text.isNotEmpty) {
                        binaryController.text = binaryController.text
                            .substring(0, binaryController.text.length - 1);
                      }
                    },
                    child: const Icon(Icons.backspace),
                  ).width(width * widthFactor / 3),
                ],
              ).paddingAll(4),
              ElevatedButton(
                onPressed: () {
                  // Maths mode
                  /*var resultado = 0;
                  var j = 0;
                  for (int i = binaryController.text.length - 1; i >= 0; i--) {
                    final potencia = pow(2, i);
                    resultado +=
                        int.parse(binaryController.text[j]) * potencia.toInt();
                    j++;
                  }
                  decimalController.text = resultado.toString();*/

                  // Using int.parse
                  decimalController.text =
                      int.tryParse(binaryController.text, radix: 2)?.toString() ?? '0';
                },
                child: const Text('Convert'),
              ).width(width * widthFactor),

            ],
          ),
        ),
      ),
    );
  }
}

extension WidgetUtils on Widget {
  Widget width(double width) {
    return SizedBox(
      width: width,
      child: this,
    );
  }

  Widget paddingAll(double width) {
    return Padding(
      padding: EdgeInsets.all(width),
      child: this,
    );
  }
}
