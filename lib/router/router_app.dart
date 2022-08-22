import 'package:alquranapp/modules/binding/auth/login_binding.dart';
import 'package:alquranapp/modules/binding/auth/register_binding.dart';
import 'package:alquranapp/modules/binding/content/home_binding.dart';
import 'package:alquranapp/modules/binding/content/surah_content_binding.dart';
import 'package:alquranapp/modules/view/auth/login_screen.dart';
import 'package:alquranapp/modules/view/auth/register_screen.dart';
import 'package:alquranapp/modules/view/content/home_screen.dart';
import 'package:alquranapp/modules/view/content/surah_content.dart';
import 'package:alquranapp/modules/view/miscellaneous/splash_screen.dart';
import 'package:alquranapp/router/router_page.dart';
import 'package:get/get.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: SplashScreenViewRoute, 
      page: () => SplashScreen()
    ),
    GetPage(
      name: LoginScreenViewRoute, 
      page: () => LoginScreen(),
      binding: LoginBinding()
    ),
    GetPage(
      name: RegisterScreenViewRoute, 
      page: () => RegisterScreen(),
      binding: RegisterBinding()
    ),
    GetPage(
      name: HomeScreenViewRoute, 
      page: () => HomeScreen(),
      binding: HomeBinding()
    ),
    GetPage(
      name: SurahContentViewRoute, 
      page: () => SurahContentScreen(),
      binding: SurahContentBinding()
    ),
  ];
}