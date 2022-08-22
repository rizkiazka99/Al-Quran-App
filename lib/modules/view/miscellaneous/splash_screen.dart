import 'dart:async';

import 'package:alquranapp/core/values/colors.dart';
import 'package:alquranapp/router/router_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 3), () {
        if (firebaseAuth.currentUser != null) {
          Get.offNamed(HomeScreenViewRoute);
        } else {
          Get.offNamed(LoginScreenViewRoute);
        }
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          colors: [contextBlue, contextGreen, contextBlueLight]
        )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: Image.asset(
                        'assets/img/logo_vertical.png',
                        height: 200,
                        width: 200,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      alignment: FractionalOffset.bottomCenter,
                      child: const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.lightGreen)
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      )
    );
  }
}