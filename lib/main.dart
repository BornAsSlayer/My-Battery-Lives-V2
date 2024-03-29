import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'services/notification_service.dart';
import 'screens/home.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  NotificationService notificationService = NotificationService();

  await Permission.notification.isDenied.then(
    (value){
      if(value){
        Permission.notification.request();
      }
    }
  );

  await notificationService.intializeService();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Battery Lives',
      theme: ThemeData( 
        colorScheme: const ColorScheme.light(),
        useMaterial3: true,
      ),
      home: const Home(),
    );
  }
}