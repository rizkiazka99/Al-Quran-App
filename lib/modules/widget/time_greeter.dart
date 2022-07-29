import 'package:alquranapp/core/values/fonts.dart';
import 'package:alquranapp/modules/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TimeGreeter extends StatefulWidget {
  const TimeGreeter({Key? key}) : super(key: key);

  @override
  State<TimeGreeter> createState() => _TimeGreeterState();
}

class _TimeGreeterState extends State<TimeGreeter> {
  HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    print(controller.currentTime);
    return Obx(() => Text(
      controller.timeCall(),
      style: h3(),
    ));
  }
}