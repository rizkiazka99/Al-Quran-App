import 'package:alquranapp/modules/controller/auth/email_verification_controller.dart';
import 'package:alquranapp/modules/view/content/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({Key? key}) : super(key: key);

  @override
  State<EmailVerificationScreen> createState() => _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  EmailVerificationController controller = Get.find<EmailVerificationController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isEmailVerified == true) {
        print('Has the e-mail been verified: ${controller.isEmailVerified}');
        return const HomeScreen();
      } else {
        print('Has the e-mail been verified: ${controller.isEmailVerified}');
        return Scaffold(
          appBar: AppBar(
            title: const Text('Verifikasi Email'),
          ),
        );
      }
    });
  }
}