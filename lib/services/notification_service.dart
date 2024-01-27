import 'dart:async';
import 'dart:ui';

import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:logger/logger.dart';


Logger logger = Logger();

@pragma('vm:entry-point')
  void onStart(ServiceInstance serviceInstance) async{
    DartPluginRegistrant.ensureInitialized();
    if(serviceInstance is AndroidServiceInstance){

      serviceInstance.on('setAsForeground').listen((event) {
        serviceInstance.setAsForegroundService();
      });

      serviceInstance.on('setAsBackground').listen((event) {
        serviceInstance.setAsBackgroundService();
      });
    }

    serviceInstance.on('stopService').listen((event) {
      serviceInstance.stopSelf();
    });

    Timer.periodic(const Duration(seconds: 1),(timer) async{
      if(serviceInstance is AndroidServiceInstance){
        if(await serviceInstance.isForegroundService()){
          serviceInstance.setForegroundNotificationInfo(
            title: "My_Battery_Lives_v2", 
            content: "it is living"
          );
          logger.i("foreground service is running");
        }
      }
    });

  }

class NotificationService {

  Future<void> intializeService() async{
    final service = FlutterBackgroundService();

    await service.configure(
      iosConfiguration: IosConfiguration(),
      androidConfiguration: AndroidConfiguration(
        onStart: onStart, 
        isForegroundMode: true,
        autoStart: false),
      );
  }

}