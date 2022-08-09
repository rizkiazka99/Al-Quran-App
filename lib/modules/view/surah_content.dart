import 'package:alquranapp/core/values/fonts.dart';
import 'package:alquranapp/data/models/new_api/surah_content_response.dart';
import 'package:alquranapp/modules/controller/surah_content_controller.dart';
import 'package:alquranapp/modules/widget/content_divider.dart';
import 'package:alquranapp/modules/widget/skeleton_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SurahContentScreen extends GetView<SurahContentController> {
  SurahContentController controller = Get.find<SurahContentController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Obx(() => controller.surahContentLoading == true ? Builder(
              builder: (context) => Column(
                children: List.generate(5, (index) => const SkeletonLoader()),
              )
            ) : Column(
              children: [
                Text(
                  controller.surahContentData!.data.namaLatin,
                  style: h5(),
                ),
                const SizedBox(height: 12),
                Text(
                  controller.surahContentData!.data.audio,
                  style: h5(),
                ),
                const SizedBox(height: 12),
                Builder(
                  builder: (context) {
                    SurahContentResponse? surahContent = controller.surahContentData;
                    return Column(
                      children: List.generate(surahContent!.data.ayat.length, (index) => Container(
                        margin: const EdgeInsets.only(left: 8, right: 8, bottom: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              surahContent.data.ayat[index].ar,
                              style: h5(),
                              textAlign: TextAlign.end,
                            ),
                            const SizedBox(height: 12),
                            Text(
                              surahContent.data.ayat[index].idn,
                              style: h6(),
                              textAlign: TextAlign.end,
                            ),
                            const SizedBox(height: 12),
                            const ContentDivider()
                          ],
                        ),
                      ))
                    );
                  }
                ),
              ],
            ))
          )
        ),
      ),
    );
  }
}