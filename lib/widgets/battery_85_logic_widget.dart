import 'package:flutter/material.dart';

class Battery85Switch extends StatefulWidget {
  const Battery85Switch({super.key});

  @override
  State<Battery85Switch> createState() => _Battery85SwitchState();
}

class _Battery85SwitchState extends State<Battery85Switch> {
  late bool switchValue = false;

  @override
  Widget build(BuildContext context) {
    return Switch(value: switchValue, 
        onChanged: (bool value) { 
          setState(() {
            switchValue = value;         
          });
        },
        );
  }
}