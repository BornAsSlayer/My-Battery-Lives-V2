import 'package:flutter/material.dart';
import 'package:my_battery_lives_v2/widgets/battery_status_widget.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            "My Battery Lives",
            style: TextStyle(
              fontFamily: 'Sometypemono regular',
            ),
          ),
        ),
      ),
      body: const Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 250),
            BatteryStatusWidget(),
          ],
        ),
      ),
    );
  }
}
