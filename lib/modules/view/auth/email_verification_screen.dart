import 'package:alquranapp/core/values/colors.dart';
import 'package:alquranapp/modules/controller/auth/email_verification_controller.dart';
import 'package:alquranapp/modules/view/content/home_screen.dart';
import 'package:alquranapp/modules/widget/authentication_button.dart';
import 'package:alquranapp/modules/widget/custom_snackbar.dart';
import 'package:alquranapp/router/router_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';


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
        return const HomeScreen();
      } else {
        return WillPopScope(
          onWillPop: () {
            controller.firebaseAuth.signOut();
            Navigator.popUntil(
              context, 
              ModalRoute.withName(SplashScreenViewRoute)
            );
            return Future.value(false);
          },
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                colors: [contextBlue, contextGreen, contextBlueLight]
              )
            ),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              extendBodyBehindAppBar: true,
              appBar: AppBar(
                automaticallyImplyLeading: false,
                title: Text(
                  'Verifikasi Email',
                  style: GoogleFonts.lato(
                    fontWeight: FontWeight.bold
                  ),
                ),
                elevation: 0,
                backgroundColor: Colors.transparent,
              ),
              body: SafeArea(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(32),
                      topRight: Radius.circular(32)
                    ),
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'E-mail verifikasi telah dikirim ke ${controller.firebaseAuth.currentUser!.email}.\n Silahkan cek e-mail anda.',
                        style: GoogleFonts.lato(
                          fontSize: 25,
                          fontWeight: FontWeight.bold
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 15),
                      AuthenticationButton(
                        onPressed: () {
                          if (controller.canResendEmail == true) {
                            controller.sendVerificationEmail();
                            customSnackbar('Sukses!', 'E-mail verifikasi telah dikirim ulang');
                          } else {
                            Obx(() => customSnackbar(
                              'Ups!', 
                              'Mohon tunggu ${controller.remainingWaitingTime} detik sebelum meminta pengiriman ulang e-mail verifikasi'
                            ));
                          }
                        }, 
                        buttonText: 'Kirim Ulang'
                      ),
                      const SizedBox(height: 15),
                      AuthenticationTextButton(
                        onTap: () async {
                          await controller.firebaseAuth.signOut().then((value) => 
                            Get.offAllNamed(SplashScreenViewRoute)
                          );
                        }, 
                        buttonText: 'Batal',
                        buttonColor: Colors.green,
                        fontSize: 20,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }
    });
  }
}