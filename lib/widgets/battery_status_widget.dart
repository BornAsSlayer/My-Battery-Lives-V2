import 'dart:async';

import 'package:battery_plus/battery_plus.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:my_battery_lives_v2/services/battery_service.dart';

class BatteryStatusWidget extends StatefulWidget {
  const BatteryStatusWidget({super.key});

  @override
  State<BatteryStatusWidget> createState() => _BatteryStatusWidgetState();
}

class _BatteryStatusWidgetState extends State<BatteryStatusWidget> {
  final BatteryService _batteryService = BatteryService();
  final Battery battery = Battery();
  String batteryStateNew = 'null';

  final _logger = Logger(
    printer: SimplePrinter(),
  );

  late Timer timer;
  bool switchValue = true;
  String batteryPercentage = "{Battery percentage comes here...}";

  Future<void> _callBatteryPercentageService() async{
    try{
      int result = await _batteryService.getBatteryPercentage();

      setState(() {
        batteryPercentage = 'Battery now: $result';
      });
    }catch(e){
      _logger.e('Error receiving the battery percentage: $e');
    }
  }

  @override
  void initState() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer){
      _callBatteryPercentageService();
      batteryStateNew = _batteryService.batteryStatus();

      // if(batteryState == 'BatteryState.connectedNotcharging'){
      //   batteryStateNew = 'Connected, Not Charging';
      // }else if(batteryState == 'BatteryState.discharging'){
      //   batteryStateNew = 'Not Charging';
      // }else if(batteryState == 'BatteryState.charging'){
      //   batteryStateNew = 'Charging';
      // }else{
      //   batteryStateNew = 'null';
      // } 
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('$batteryStateNew',
        style: const TextStyle( fontFamily: 'Sometypemono Regular'),
        ),
        const SizedBox(height: 5),
        Text(batteryPercentage,
        style: const TextStyle( fontFamily: 'Sometypemono Regular'),
        ),
        const SizedBox(height: 5),
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