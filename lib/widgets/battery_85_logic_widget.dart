import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Battery85Switch extends StatefulWidget {
  const Battery85Switch({super.key});

  @override
  State<Battery85Switch> createState() => _Battery85SwitchState();
}

class _Battery85SwitchState extends State<Battery85Switch> {
  late SharedPreferences _preferences;
  late bool switchValue = false;

  @override
  void initState() {
    super.initState();
    _storeSwitchValue();
  }

  Future<void> _storeSwitchValue() async {
    _preferences = await SharedPreferences.getInstance();
    setState(() {
      switchValue = _preferences.getBool('switch') ?? false;
    });
  }

  void setSwitchValue(bool switchV){
    setState(() {
      switchValue=switchV;
      _preferences.setBool('switch', switchValue);
    });
  }

  @override
  Widget build(BuildContext context) {
    return 
      Switch(
        value: switchValue, 
        onChanged: (bool value) { 
          setSwitchValue(value);
        },
      );
  }
}