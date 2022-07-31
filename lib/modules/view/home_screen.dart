import 'package:alquranapp/data/models/surah_response.dart';
import 'package:alquranapp/modules/controller/home_controller.dart';
import 'package:alquranapp/modules/widget/skeleton_loader.dart';
import 'package:alquranapp/modules/widget/time_greeter.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class HomeScreen extends GetView<HomeController> {
  HomeController controller = Get.find<HomeController>();

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
                  const TimeGreeter(),
                  Obx(() => controller.surahLoading == true ? Builder(
                    builder: (context) => Column(
                      children: List.generate(5, (index) => const SkeletonLoader()),
                    ),
                  ) : Builder(
                    builder: (context) {
                      SurahResponse? surah = controller.surahData;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: List.generate(surah!.data.length + 1, (index) => 
                            index < surah.data.length ? Text(
                          surah.data[index].englishName
                        ) : const Padding(
                          padding: EdgeInsets.symmetric(vertical: 32),
                          child: SkeletonLoader(),
                        )),
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
