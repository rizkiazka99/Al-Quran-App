import 'package:alquranapp/core/utils/capitalize_first_letter.dart';
import 'package:alquranapp/core/values/colors.dart';
import 'package:alquranapp/data/models/new_api/surah_response.dart';
import 'package:alquranapp/modules/controller/content/home_controller.dart';
import 'package:alquranapp/modules/controller/content/surah_content_controller.dart';
import 'package:alquranapp/modules/view/auth/email_verification_screen.dart';
import 'package:alquranapp/modules/view/auth/register_screen.dart';
import 'package:alquranapp/modules/widget/content_divider.dart';
import 'package:alquranapp/modules/widget/search_bar.dart';
import 'package:alquranapp/modules/widget/skeleton_loader.dart';
import 'package:alquranapp/router/router_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class MainPage extends StatelessWidget {
  MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const EmailVerificationScreen();
          } else {
            return const RegisterScreen();
          }
        },
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeController controller = Get.find<HomeController>();
  SurahContentController surahContentController = Get.put(SurahContentController());

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
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          titleSpacing: 0,
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Image.asset(
            'assets/img/logo_horizontal.png',
            height: 40,
            width: 200,
          ), 
          actions: [
            Obx(() => controller.enableSearchBar == false ? InkWell(
              onTap: () {
                controller.enableSearchBar = !controller.enableSearchBar;
              },
              child: const Icon(
                Icons.search,
                size: 25,
              ),
            ) : InkWell(
              onTap: () {
                controller.enableSearchBar = !controller.enableSearchBar;
              },
              child: const Icon(
                Icons.clear,
                size: 25,
              ),
            )),
            const SizedBox(width: 12),
            controller.firebaseAuth.currentUser != null ? InkWell(
              onTap: () async {
                await controller.firebaseAuth.signOut().then((value) => 
                  Get.offAllNamed(LoginScreenViewRoute)
                );
              },
              child: const Icon(
                Icons.logout,
                size: 25,
              ),
            ) : const SizedBox.shrink()
          ],
        ),
        body: SafeArea(
          child: Stack(
            children: [
            Container(
              margin: const EdgeInsets.only(top: 15),
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: SearchBar(
                textController: controller.searchController, 
                onChanged: (value) {
                  controller.runFilter(value);
                }, 
                onTap: () {
                  controller.searchController.clear();
                }
              ),
            ),
            Obx(() => Container(
              margin: controller.enableSearchBar == false ? const EdgeInsets.only(top: 0) :
                  const EdgeInsets.only(top: 70),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
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
              child: SingleChildScrollView(
                controller: controller.scrollController,
                physics: const BouncingScrollPhysics(),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      controller.firebaseAuth.currentUser != null ? Text(
                        'Assalamualaikum,',
                        style: GoogleFonts.lato(
                          fontSize: 24,
                          fontWeight: FontWeight.bold
                        )
                      ) : const SizedBox.shrink(),
                      const SizedBox(height: 4),
                      controller.firebaseAuth.currentUser != null ? Text(
                        controller.firebaseAuth.currentUser!.displayName!,
                        style: GoogleFonts.lato(
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                        ),
                      ) : const SizedBox.shrink(),               
                      controller.firebaseAuth.currentUser != null ? 
                          const SizedBox(height: 30) : const SizedBox.shrink(),
                      Obx(() {
                        if (controller.surahLoading == true) {
                          return Builder(
                            builder: (context) {
                              return Column(
                                children: List.generate(5, (index) => const SkeletonLoader()),
                              );
                            },
                          );
                        } else {
                          if (controller.searchController.text.isEmpty) {
                            return Builder(
                              builder: (context) {
                                SurahResponse? surah = controller.surahData;
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: List.generate(surah!.data.length, (index) => 
                                      InkWell(
                                        onTap: () {
                                          surahContentController.currentSurahNumber = 
                                              surah.data[index].nomor;
                                          surahContentController.getSurahContent();
                                          Get.toNamed(SurahContentViewRoute);
                                        },
                                      child: Container(
                                        padding: const EdgeInsets.all(8),
                                        margin: const EdgeInsets.only(bottom: 8),
                                        width: MediaQuery.of(context).size.width,
                                        height: MediaQuery.of(context).size.height / 9,
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Expanded(
                                                  flex: 1,
                                                  child: Text(
                                                    surah.data[index].nomor.toString(),
                                                    style: GoogleFonts.lato(
                                                      fontSize: 16
                                                    )
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 3,
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        surah.data[index].namaLatin,
                                                        style: GoogleFonts.lato(
                                                          fontSize: 16,
                                                          fontWeight: FontWeight.bold
                                                        )
                                                      ),
                                                      const SizedBox(height: 12),
                                                      Text(
                                                        surah.data[index].tempatTurun.capitalizeFirstLetter(),
                                                        style: GoogleFonts.lato(
                                                          fontSize: 14
                                                        )
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: Text(
                                                    surah.data[index].nama,
                                                    style: GoogleFonts.lato(
                                                      fontSize: 25,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                    textAlign: TextAlign.right,
                                                  )
                                                )
                                              ],
                                            ),
                                            const SizedBox(height: 18),
                                            const ContentDivider()
                                          ],
                                        ),
                                      ),
                                    )
                                  ),
                                );
                              },
                            );
                          } else if (controller.surahList.isEmpty) {
          
                          } else {
                            return Builder(
                              builder: (context) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: List.generate(controller.surahList.length, (index) => 
                                  InkWell(
                                    onTap: () {
                                      surahContentController.currentSurahNumber = 
                                        controller.surahList[index].nomor;
                                      surahContentController.getSurahContent();
                                      Get.toNamed(SurahContentViewRoute);
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(8),
                                      margin: const EdgeInsets.only(bottom: 8),
                                      width: MediaQuery.of(context).size.width,
                                      height: MediaQuery.of(context).size.height / 9,
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                flex: 1,
                                                child: Text(
                                                  controller.surahList[index].nomor.toString(),
                                                  style: GoogleFonts.lato(
                                                    fontSize: 16
                                                  )
                                                ),
                                              ),
                                              Expanded(
                                                flex: 3,
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      controller.surahList[index].namaLatin,
                                                      style: GoogleFonts.lato(
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.bold
                                                      )
                                                    ),
                                                    const SizedBox(height: 12),
                                                    Text(
                                                      controller.surahList[index].tempatTurun.capitalizeFirstLetter(),
                                                      style: GoogleFonts.lato(
                                                        fontSize: 14
                                                      )
                                                    )                                          
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: Text(
                                                  controller.surahList[index].nama,
                                                  style: GoogleFonts.lato(
                                                    fontSize: 25,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  textAlign: TextAlign.right,
                                                )
                                              )
                                            ],
                                          ),
                                          const SizedBox(height: 18),
                                          const ContentDivider()
                                        ],
                                      ),
                                    ),
                                  )
                                ),
                              );
                            });
                          }
                          return const SizedBox.shrink();
                        }
                      })
                    ],
                  ),
                ),
              ),
            )),
          ]),
        ),
      ),
    );
  }
}
