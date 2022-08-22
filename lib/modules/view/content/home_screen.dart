import 'package:alquranapp/core/utils/capitalize_first_letter.dart';
import 'package:alquranapp/core/values/colors.dart';
import 'package:alquranapp/core/values/fonts.dart';
import 'package:alquranapp/data/models/new_api/surah_response.dart';
import 'package:alquranapp/modules/controller/content/home_controller.dart';
import 'package:alquranapp/modules/controller/content/surah_content_controller.dart';
import 'package:alquranapp/modules/widget/content_divider.dart';
import 'package:alquranapp/modules/widget/skeleton_loader.dart';
import 'package:alquranapp/router/router_page.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


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
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        title: Obx(() => controller.enableSearchBar == false ?
            Image.asset(
              'assets/img/logo_horizontal.png',
              height: 40,
              width: 200,
            ) : SizedBox(
            height: 45,
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    controller.enableSearchBar = !controller.enableSearchBar;
                    print('enableSearchBar: ${controller.enableSearchBar}');
                  },
                  child: const Icon(
                    Icons.arrow_back,
                    size: 25,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 1.2,
                  child: TextFormField(
                    controller: controller.searchController,
                    onChanged: (value) {
                      controller.runFilter(value);
                    },
                    decoration: InputDecoration(
                      hintText: 'Cari Surah',
                      hintStyle: h6(color: Colors.white),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Colors.white,
                          width: 2
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Colors.white,
                          width: 2
                        )
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Colors.white,
                          width: 2
                        )
                      ),
                      suffixIcon:
                        InkWell(
                          onTap: () {
                            controller.searchController.clear();
                          },
                          child: const Icon(
                            Icons.close,
                            size: 25,
                            color: Colors.white
                          ),
                        )
                      )
                    ),
                  )
              ],
            ),
          )
        ),
        actions: [
          Obx(() => controller.enableSearchBar == false ? InkWell(
            onTap: () {
              controller.enableSearchBar = !controller.enableSearchBar;
              print('enableSearchBar: ${controller.enableSearchBar}');
            },
            child: const Icon(
              Icons.search,
              size: 25,
            ),
          ) : const SizedBox.shrink()),
          const SizedBox(width: 12),
          InkWell(
            onTap: () async {
              await controller.firebaseAuth.signOut().then((value) => 
                Get.offAllNamed(LoginScreenViewRoute)
              );
            },
            child: const Icon(
              Icons.logout,
              size: 25,
            ),
          )
        ],
      ),
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            controller: controller.scrollController,
            physics: const BouncingScrollPhysics(),
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Assalamualaikum,',
                    style: h3(),
                  ),
                  const SizedBox(height: 4),
                  Obx(() {
                    if (controller.currentTime >= 11) {
                      return Text(
                        "Good Afternoon 🌞",
                        style: h4(),
                      );
                    } else if (controller.currentTime > 11 &&
                        controller.currentTime >= 16) {
                      return Text(
                        "Good Evening 🌆",
                        style: h4(),
                      );
                    } else if (controller.currentTime > 11 &&
                        controller.currentTime >= 20) {
                      return Text(
                        "Good Night 🌙",
                        style: h4(),
                      );
                    } else if (controller.currentTime < 11) {
                      return Text(
                        "Good Morning ☀️",
                        style: h4(),
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  }),                
                  const SizedBox(height: 12),
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
        ),
      ),
    );
  }
}
