import 'package:alquranapp/modules/controller/content/surah_content_controller.dart';
import 'package:get/get.dart';

class SurahContentBinding extends Bindings {

  @override
  void dependencies() {
    Get.lazyPut<SurahContentController>(() => SurahContentController());
  }
}