import 'package:alquranapp/data/backend/firebase.dart';
import 'package:alquranapp/router/router_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

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
          userSetup(nameController.text);
          /*nameController.clear();
          emailController.clear();
          passwordController.clear();
          confirmedPasswordController.clear();*/
          Get.offAllNamed(LoginScreenViewRoute);
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
      return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'Ups!',
              style: GoogleFonts.lato(
                fontSize: 18,
                fontWeight: FontWeight.bold
              ),
            ),
            content: Text(
              errorMessage,
              style: GoogleFonts.lato(
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Get.back();
                },
                child: Center(
                  child: Text(
                    'Kembali',
                    style: GoogleFonts.lato(
                      fontSize: 20, 
                      fontWeight: FontWeight.bold
                    ),
                  ),
                )
              )
            ],
          );
        }
      );      
    }
  }
}