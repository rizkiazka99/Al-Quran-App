import 'package:alquranapp/core/values/colors.dart';
import 'package:alquranapp/modules/controller/auth/login_controller.dart';
import 'package:alquranapp/modules/widget/authentication_button.dart';
import 'package:alquranapp/modules/widget/authentication_form.dart';
import 'package:alquranapp/router/router_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginController controller = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              AuthenticationForm(
                formKey: controller.emailFormKey, 
                autovalidateMode: controller.autoValidateEmail, 
                controller: controller.emailController,
                hintText: 'E-mail',
                obscureText: false,
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
                obscureText: controller.isNotVisible, 
                suffixIcon: IconButton(
                  onPressed: () {
                    controller.showAndHidePassword();
                  },
                  icon: Icon(
                    controller.isNotVisible == true ? Icons.visibility :
                        Icons.visibility_off,
                    color: contextGrey,
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Password tidak boleh kosong";
                  }
                },
              )),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AuthenticationTextButton(
                    onTap: () {}, 
                    buttonText: 'Lupa Password?'
                  ),
                ],
              ),
              const SizedBox(height: 12),
              AuthenticationButton(
                onPressed: () {
                  controller.login(context);
                }, 
                buttonText: 'Login'
              ),
              const SizedBox(height: 12),
              Text(
                'Belum punya akun?',
                style: GoogleFonts.lato(
                  fontSize: 15
                ),
              ),
              const SizedBox(height: 8),
              AuthenticationButton(
                onPressed: () {
                  Get.toNamed(RegisterScreenViewRoute);
                }, 
                buttonText: 'Register'
              ),
              const SizedBox(height: 12),
              Text(
                'Atau',
                style: GoogleFonts.lato(
                  fontSize: 15
                ),
              ),
              const SizedBox(height: 8),
              AuthenticationTextButton(
                onTap: () {
                  Get.toNamed(HomeScreenViewRoute);
                }, 
                buttonText: 'Masuk Tanpa Akun'
              )
            ],
          ),
        ),
      ),
    );
  }
}