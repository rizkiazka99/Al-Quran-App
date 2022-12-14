import 'package:alquranapp/core/values/colors.dart';
import 'package:alquranapp/core/values/fonts.dart';
import 'package:alquranapp/data/models/new_api/surah_content_response.dart';
import 'package:alquranapp/modules/controller/content/surah_content_controller.dart';
import 'package:alquranapp/modules/widget/content_divider.dart';
import 'package:alquranapp/modules/widget/scroll_to_hide.dart';
import 'package:alquranapp/modules/widget/skeleton_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SurahContentScreen extends StatefulWidget {
  const SurahContentScreen({Key? key}) : super(key: key);

  @override
  State<SurahContentScreen> createState() => _SurahContentScreenState();
}

class _SurahContentScreenState extends State<SurahContentScreen> {
  SurahContentController controller = Get.find<SurahContentController>();

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
        extendBody: true,
        appBar: AppBar(
          title: Obx(() => controller.surahContentLoading == true ? 
              const SizedBox.shrink() : Text(
            controller.surahContentData!.data.namaLatin,
            style: GoogleFonts.lato(
              fontSize: 20,
              fontWeight: FontWeight.bold
            ),
          )),
          elevation: 0,
          backgroundColor: Colors.transparent
        ),
        body: SafeArea(
          child: Container(
            padding: const EdgeInsets.all(16),
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
              child: Obx(() => controller.surahContentLoading == true ? Builder(
                builder: (context) => Column(
                  children: List.generate(5, (index) => const SkeletonLoader()),
                )
              ) : Column(
                children: [
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
                                style: h4(),
                                textAlign: TextAlign.right,
                              ),
                              const SizedBox(height: 12),
                              Text(
                                surahContent.data.ayat[index].idn,
                                style: GoogleFonts.lato(
                                  fontSize: 14
                                ),
                                textAlign: TextAlign.justify,
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
        bottomNavigationBar: ScrollToHide(
          scrollController: controller.scrollController,
          margin: const EdgeInsets.only(bottom: 24),
          height: MediaQuery.of(context).size.height / 8,
          child: Container(
            height: MediaQuery.of(context).size.height / 8,
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3)
                )
              ]
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Obx(() => InkWell(
                    onTap: () {
                      if (controller.currentSurahNumber > 1) {
                        controller.currentSurahNumber--;
                        controller.audioPlayer.stop();
                        controller.audioPlayer.seek(const Duration(seconds: 0));
                        controller.getSurahContent();
                      } 
                    },
                    child: Icon(
                      Icons.arrow_back,
                      color: controller.currentSurahNumber > 1 ?Colors.black : contextGrey,
                    ),
                  )),
                ),
                Expanded(
                  flex: 3,
                  child: Row(
                    children: [
                      Obx(() => Slider(
                        min: 0,
                        max: controller.duration.inSeconds.toDouble(),
                        value: controller.position.inSeconds.toDouble(),
                        onChanged: (value) async {
                          final position = Duration(seconds: value.toInt());
                          await controller.audioPlayer.seek(position);
                          await controller.audioPlayer.resume();
                        }
                      )),
                      Obx(() => InkWell(
                        onTap: () async {
                          if (controller.isPlaying) {
                            await controller.audioPlayer.pause();
                          } else {
                            await controller.audioPlayer.play(
                              controller.surahContentData!.data.audio
                            );
                          }
                        },
                        child: Icon(
                          controller.isPlaying ? Icons.pause : Icons.play_arrow,
                          size: 18,
                        ),
                      )),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Obx(() => InkWell(
                    onTap: () {
                      if (controller.currentSurahNumber < 114) {
                        controller.currentSurahNumber++;
                        controller.audioPlayer.stop();
                        controller.audioPlayer.seek(const Duration(seconds: 0));
                        controller.getSurahContent();
                      } 
                    },
                    child: Icon(
                      Icons.arrow_forward,
                      color: controller.currentSurahNumber < 114 ?Colors.black : contextGrey,
                    ),
                  )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}