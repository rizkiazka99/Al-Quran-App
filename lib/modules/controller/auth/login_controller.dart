import 'package:alquranapp/router/router_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginController extends GetxController {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final emailFormKey = GlobalKey<FormState>();
  final passwordFormKey = GlobalKey<FormState>();
  var autoValidateEmail = AutovalidateMode.disabled;
  var autoValidatePassword = AutovalidateMode.disabled;
  String errorMessage = '';

  RxBool _isNotVisible = true.obs;
  bool get isNotVisible => _isNotVisible.value;
  set isNotVisible(bool isNotVisible) =>
      this._isNotVisible.value = isNotVisible;

  void showAndHidePassword() {
    isNotVisible = !isNotVisible;
  }

  login(BuildContext context) async {
    final isEmailValid = emailFormKey.currentState!.validate();
    final isPasswordValid = passwordFormKey.currentState!.validate();

    try {
      if (isEmailValid && isPasswordValid) {
        await firebaseAuth.signInWithEmailAndPassword(
          email: emailController.text, 
          password: passwordController.text
        ).then((value) => Get.offAllNamed(HomeScreenViewRoute));
      } else if (!isEmailValid) {
        autoValidateEmail = AutovalidateMode.always;
      } else if (!isPasswordValid) {
        autoValidatePassword = AutovalidateMode.always;
      } else {
        autoValidateEmail = AutovalidateMode.always;
        autoValidatePassword = AutovalidateMode.always;
      }
    } catch (error) {
      print('Firebase Exception: $error');
      switch (error) {
        case "ERROR_EMAIL_ALREADY_IN_USE":
        case "account-exists-with-different-credential":
        case "email-already-in-use":
          errorMessage = "E-mail ini sudah digunakan pengguna lain";
          break;
        case "ERROR_WRONG_PASSWORD":
        case "wrong-password":
          errorMessage = "E-mail atau password salah.";
          break;
        case "ERROR_USER_NOT_FOUND":
        case "user-not-found":
          errorMessage = "E-mail ini tidak terdaftar";
          break;
        case "ERROR_USER_DISABLED":
        case "user-disabled":
          errorMessage = "Akun sudah dinonaktifkan";
          break;
        case "ERROR_TOO_MANY_REQUESTS":
        case "operation-not-allowed":
          errorMessage = "Terlalu banyak request untuk masuk ke akun ini";
          break;
        case "ERROR_OPERATION_NOT_ALLOWED":
        case "operation-not-allowed":
          errorMessage = "Masalah server, mohon coba beberapa saat lagi";
          break;
        case "ERROR_INVALID_EMAIL":
        case "invalid-email":
          errorMessage = "E-mail tidak valid";
          break;
        default:
          errorMessage = "Login gagal, mohon coba lagi";
          break;
      }
      print('Error: $errorMessage');
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