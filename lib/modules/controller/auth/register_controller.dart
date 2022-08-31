import 'package:alquranapp/modules/widget/custom_snackbar.dart';
import 'package:alquranapp/router/router_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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

  Future<void> userSetup(String name, String email) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    String uid = auth.currentUser!.uid.toString();
    CollectionReference users = FirebaseFirestore.instance.collection('users');
  
    users.doc(uid).collection('personal_info').add({
      'name' : name,
      'email' : email
    });
  }

  signup(BuildContext context) async {
    try {
      final isNameValid = nameFormKey.currentState!.validate();
      final isEmailValid = emailFormKey.currentState!.validate();
      final isPasswordValid = passwordFormKey.currentState!.validate();
      final isConfirmedPasswordValid = confirmedPasswordFormKey.currentState!.validate();

      if (isNameValid && isEmailValid & isPasswordValid && isConfirmedPasswordValid) {
        await firebaseAuth.createUserWithEmailAndPassword(
          email: emailController.text, 
          password: passwordController.text
        ).then((value) {
          User? updateUser = firebaseAuth.currentUser;
          updateUser!.updateDisplayName(nameController.text);
          userSetup(nameController.text, emailController.text);
          Get.offAllNamed(EmailVerificationViewRoute);
        });
      } else if (!isNameValid) {
        autoValidateName = AutovalidateMode.always;
      } else if (!isEmailValid) {
        autoValidateEmail = AutovalidateMode.always;
      } else if (!isPasswordValid) {
        autoValidatePassword = AutovalidateMode.always;
      } else if (!isConfirmedPasswordValid) {
        autoValidateConfirmedPassword = AutovalidateMode.always;
      } else {
        autoValidateName = AutovalidateMode.always;
        autoValidateEmail = AutovalidateMode.always;
        autoValidatePassword = AutovalidateMode.always;
        autoValidateConfirmedPassword = AutovalidateMode.always;
      }
    } on FirebaseAuthException catch(error) {
      switch (error.code) {
        case "ERROR_EMAIL_ALREADY_IN_USE":
        case "account-exists-with-different-credential":
        case "email-already-in-use":
          errorMessage = "E-mail telah dipakai oleh pengguna lain";
          break;
        case "weak-password":
          errorMessage =
              "Password anda terlalu lemah";
          break;
        case "ERROR_INVALID_EMAIL":
        case "invalid-email":
          errorMessage = "Email address is invalid.";
          break;
        default:
          errorMessage = "Sign up failed. Please try again.";
          break;
      }
      return customSnackbar('Ups!', errorMessage);     
    }
  }
}