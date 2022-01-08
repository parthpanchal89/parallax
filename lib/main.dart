import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Parallax(),
    );
  }
}

class Parallax extends StatelessWidget {
  final ScrollController vcontroller = ScrollController();
  final ScrollController hcontroller = ScrollController();

  Parallax({Key? key}) : super(key: key);

  void move() {
    Future.delayed(const Duration(milliseconds: 500), () {
      hcontroller.animateTo(Get.width * 0.05,
          duration: const Duration(seconds: 1), curve: Curves.ease);
      vcontroller.animateTo(Get.height * 0.025,
          duration: const Duration(seconds: 1), curve: Curves.ease);
    });
    accelerometerEvents.listen((AccelerometerEvent event) {
      hcontroller.animateTo(
        Get.width * 0.1 + (event.x.toInt() * Get.width * 0.01),
        duration: const Duration(milliseconds: 500),
        curve: Curves.decelerate,
      );
      vcontroller.animateTo(
        Get.height * 0.1 + (event.y.toInt() * Get.height * 0.01),
        duration: const Duration(milliseconds: 500),
        curve: Curves.decelerate,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    move();
    return Scaffold(
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        controller: vcontroller,
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          controller: hcontroller,
          scrollDirection: Axis.horizontal,
          child: Image(
            image: const NetworkImage(
                "https://images.unsplash.com/photo-1641495773329-0cd802ebdc52?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=764&q=80"),
            height: Get.height * 1.2,
            width: Get.width * 1.2,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
