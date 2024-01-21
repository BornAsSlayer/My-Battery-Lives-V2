import 'package:flutter/material.dart';

class BatteryStatusWidget extends StatefulWidget {
  const BatteryStatusWidget({super.key});

  @override
  State<BatteryStatusWidget> createState() => _BatteryStatusWidgetState();
}

class _BatteryStatusWidgetState extends State<BatteryStatusWidget> {
  bool switchValue = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text("enable 85 percentage battery warning?",
        style: TextStyle( fontFamily: 'Sometypemono Regular'),
        ),
        const SizedBox(width: 20),
        Switch(value: switchValue, 
        onChanged: (bool value) { 
          setState(() {
            switchValue = value;
          });
        },
        )
      ],
    );
  }
}