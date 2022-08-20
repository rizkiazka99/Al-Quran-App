import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmedPasswordController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  final emailFormKey = GlobalKey<FormState>();
  final passwordFormKey = GlobalKey<FormState>();
  final confirmedPasswordFormKey = GlobalKey<FormState>();
  final nameFormKey = GlobalKey<FormState>();

  var autoValidateEmail = AutovalidateMode.disabled;
  var autoValidatePassword = AutovalidateMode.disabled;
  var autoValidateConfirmedPassword = AutovalidateMode.disabled;
  var autoValidateName = AutovalidateMode.disabled;

  String errorMessage = '';

  RxBool _isPasswordNotVisible = true.obs;
  RxBool _isConfirmedPasswordNotVisible = true.obs;

  bool get isPasswordNotVisible => _isPasswordNotVisible.value;
  bool get isConfirmedPasswordNotVisible => _isConfirmedPasswordNotVisible.value;

  set isPasswordNotVisible(bool isPasswordNotVisible) =>
      this._isPasswordNotVisible.value = isPasswordNotVisible;
  set isConfirmedPasswordNotVisible(bool isConfirmedPasswordNotVisible) =>
      this._isConfirmedPasswordNotVisible.value = isConfirmedPasswordNotVisible;

  void showAndHidePassword() {
    isPasswordNotVisible = !isPasswordNotVisible;
  }

  void showAndHideConfirmedPassword() {
    isConfirmedPasswordNotVisible = !isConfirmedPasswordNotVisible;
  }

  signup(BuildContext context) async {
    
  }
}