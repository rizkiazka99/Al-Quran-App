import 'package:alquranapp/modules/binding/home_binding.dart';
import 'package:alquranapp/modules/binding/surah_content_binding.dart';
import 'package:alquranapp/modules/view/home_screen.dart';
import 'package:alquranapp/modules/view/surah_content.dart';
import 'package:alquranapp/router/router_page.dart';
import 'package:get/get.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: HomeScreenViewRoute, 
      page: () => HomeScreen(),
      binding: HomeBinding()
    ),
    GetPage(
      name: SurahContentViewRoute, 
      page: () => SurahContentScreen(),
      binding: SurahContentBinding()
    )
  ];
}