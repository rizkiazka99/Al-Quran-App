import 'dart:async';

import 'package:alquranapp/modules/widget/custom_snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class EmailVerificationController extends GetxController {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  Timer? timer;

  RxBool _isEmailVerified = false.obs;

  bool get isEmailVerified => _isEmailVerified.value;

  set isEmailVerified(bool isEmailVerified) =>
      this._isEmailVerified.value = isEmailVerified;

  @override
  void onInit() {
    super.onInit();

    isEmailVerified = firebaseAuth.currentUser!.emailVerified;

    if(isEmailVerified == false) {
      sendVerificationEmail();

      timer = Timer.periodic(
        Duration(seconds: 3), 
        (timer) => checkEmailVerified()
      );
    }
  }

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }

  Future sendVerificationEmail() async {
    try {
      final user = firebaseAuth.currentUser!;
      await user.sendEmailVerification();
    } catch(error) {
      customSnackbar('Terjadi Kesalahan!', error.toString());
    }
  }

  Future checkEmailVerified() async {
    await firebaseAuth.currentUser!.reload();
    isEmailVerified = firebaseAuth.currentUser!.emailVerified;

    if (isEmailVerified == true) {
      timer!.cancel();
    }
  }
}