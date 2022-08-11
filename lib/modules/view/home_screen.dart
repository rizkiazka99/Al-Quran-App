import 'package:alquranapp/core/utils/capitalize_first_letter.dart';
import 'package:alquranapp/core/values/colors.dart';
import 'package:alquranapp/core/values/fonts.dart';
//import 'package:alquranapp/data/models/surah_response.dart';
import 'package:alquranapp/modules/controller/home_controller.dart';
import 'package:alquranapp/modules/controller/surah_content_controller.dart';
import 'package:alquranapp/modules/widget/content_divider.dart';
import 'package:alquranapp/modules/widget/skeleton_loader.dart';
import 'package:alquranapp/router/router_page.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../data/models/new_api/surah_response.dart';

class HomeScreen extends GetView<HomeController> {
  HomeController controller = Get.find<HomeController>();
  SurahContentController surahContentController = Get.put(SurahContentController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  Obx(() => controller.surahLoading == true ? Builder(
                    builder: (context) => Column(
                      children: List.generate(5, (index) => const SkeletonLoader()),
                    ),
                  ) : Builder(
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
                                            style: h5(),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 3,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                surah.data[index].namaLatin,
                                                style: h5(),
                                              ),
                                              const SizedBox(height: 12),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    flex: 3,
                                                    child: Text(
                                                      surah.data[index].arti,
                                                      style: h6(),
                                                      maxLines: 1,
                                                      overflow: TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 2,
                                                    child: Text(
                                                      surah.data[index].tempatTurun.capitalizeFirstLetter(),
                                                      style: h6(),
                                                    ),
                                                  )
                                                ],
                                              )                                          
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Text(
                                            surah.data[index].nama,
                                            style: h5()
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
                  ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
