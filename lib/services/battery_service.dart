import 'dart:async';

import 'package:battery_plus/battery_plus.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';

class BatteryService{
  final Battery _battery = Battery();
  BatteryState? batteryState;
  StreamSubscription <BatteryState>? batteryStateSubscription;

  final Logger _logger = Logger(
    printer: SimplePrinter()
  );

  String batteryStatus(){
    _battery.onBatteryStateChanged.listen((BatteryState state) {
      batteryState = state;
    });
    return '$batteryState';
  }

  String batteryStatusText(){
    _battery.onBatteryStateChanged.listen((BatteryState state) {
      batteryState = state;
    });
    String state = '$batteryState';
    if(state == 'BatteryState.connectedNotcharging'){
      return 'Connected, Not Charging';
    }else if(state == 'BatteryState.discharging'){
      return 'Not Charging';
    }else if(state == 'BatteryState.charging'){
      return 'Charging';
    }else{
      return 'null';
    }
  }

  Future<int> getBatteryPercentage() async{
    try {
      final int batteryLevel = await _battery.batteryLevel;
      return batteryLevel;
    } on PlatformException catch (e) {
      _logger.e('error getting Battery percentage : ${e.message}');
      return -1;
    }
  }
}