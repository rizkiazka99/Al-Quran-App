import 'package:alquranapp/core/values/colors.dart';
import 'package:alquranapp/modules/controller/auth/register_controller.dart';
import 'package:alquranapp/modules/widget/authentication_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../widget/authentication_form.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  RegisterController controller = Get.find<RegisterController>();

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
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.all(32),
                    child: Image.asset(
                      'assets/img/logo_horizontal.png',
                      height: 50,
                      width: 200
                    )
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: MediaQuery.of(context).size.height / 8,
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(32),
                          topRight: Radius.circular(32)
                        ),
                        color: paleBlueLight,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(0, 3)
                          )
                        ]
                      ),
                      child: Column(
                        children: [
                          AuthenticationForm(
                            formKey: controller.nameFormKey, 
                            autovalidateMode: controller.autoValidateName, 
                            controller: controller.nameController,
                            hintText: 'Nama',
                            obscureText: false,
                            focusedColor: contextGreen,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Nama tidak boleh kosong';
                              } 
                            }
                          ),
                          const SizedBox(height: 8),
                          AuthenticationForm(
                            formKey: controller.emailFormKey, 
                            autovalidateMode: controller.autoValidateEmail, 
                            controller: controller.emailController,
                            hintText: 'E-mail',
                            obscureText: false,
                            focusedColor: contextGreen,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'E-mail tidak boleh kosong';
                              } else if (!value.contains('@')) {
                                return 'Format e-mail salah';
                              } else if (!value.contains('.')) {
                                return 'Format e-mail salah';
                              }
                            }
                          ),
                          const SizedBox(height: 8),
                          Obx(() => AuthenticationForm(
                            formKey: controller.passwordFormKey, 
                            autovalidateMode: controller.autoValidatePassword, 
                            controller: controller.passwordController,
                            hintText: 'Password',
                            obscureText: controller.isPasswordNotVisible, 
                            focusedColor: contextGreen,
                            suffixIcon: IconButton(
                              onPressed: () {
                                controller.showAndHidePassword();
                              },
                              icon: Icon(
                                controller.isPasswordNotVisible == true ? Icons.visibility :
                                    Icons.visibility_off,
                                color: contextGrey,
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Password tidak boleh kosong";
                              } else if (value.length < 8) {
                                return "Password harus memiliki minimal 8 karakter";
                              }
                            },
                          )),
                          const SizedBox(height: 8),
                          Obx(() => AuthenticationForm(
                            formKey: controller.confirmedPasswordFormKey, 
                            autovalidateMode: controller.autoValidateConfirmedPassword, 
                            controller: controller.confirmedPasswordController,
                            hintText: 'Konfirmasi Password',
                            obscureText: controller.isConfirmedPasswordNotVisible, 
                            focusedColor: contextGreen,
                            suffixIcon: IconButton(
                              onPressed: () {
                                controller.showAndHideConfirmedPassword();
                              },
                              icon: Icon(
                                controller.isConfirmedPasswordNotVisible == true ? Icons.visibility :
                                    Icons.visibility_off,
                                color: contextGrey,
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Konfirmasi Password tidak boleh kosong";
                              } else if (value != controller.passwordController.text) {
                                return "Password tidak terkonfirmasi";
                              } else if (value.length < 8) {
                                return "Password harus memiliki minimal 8 karakter";
                              }
                            },
                          )),
                          const SizedBox(height: 12),
                          AuthenticationButton(
                            onPressed: () {
                              controller.signup(context);
                            }, 
                            buttonText: 'Register'
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}