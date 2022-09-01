import 'dart:async';

import 'package:alquranapp/modules/widget/custom_snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class EmailVerificationController extends GetxController {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  Timer? timer;

  RxBool _isEmailVerified = false.obs;
  RxBool _canResendEmail = false.obs;
  RxInt _remainingWaitingTime = 30.obs;

  bool get isEmailVerified => _isEmailVerified.value;
  bool get canResendEmail => _canResendEmail.value;
  int get remainingWaitingTime => _remainingWaitingTime.value;

  set isEmailVerified(bool isEmailVerified) =>
      this._isEmailVerified.value = isEmailVerified;
  set canResendEmail(bool canResendEmail) =>
      this._canResendEmail.value = canResendEmail;
  set remainingWaitingTime(int remainingWaitingTime) =>
      this._remainingWaitingTime.value = remainingWaitingTime;

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

      canResendEmail = false;
      await Future.delayed(Duration(seconds: remainingWaitingTime));
      canResendEmail = true;
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