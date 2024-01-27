import 'dart:async';

import 'package:battery_plus/battery_plus.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';

class BatteryService{
  final Battery _battery = Battery();
  StreamSubscription <BatteryState>? batteryStateSubscription;
  final StreamController<BatteryState> batteryStateStreamController = StreamController();

  BatteryService(){
    batteryStateSubscription = _battery.onBatteryStateChanged.listen((BatteryState state) {
      batteryStateStreamController.add(state);
    });
  }

  final Logger _logger = Logger(
    printer: SimplePrinter()
  );

  Stream<BatteryState> getBatteryStateStream(){
    return batteryStateStreamController.stream;
  }

  void batteryStatusStreamDispose(){
    batteryStateStreamController.close();
    batteryStateSubscription?.cancel();
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