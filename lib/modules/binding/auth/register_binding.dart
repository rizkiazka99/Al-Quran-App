import 'package:alquranapp/modules/controller/auth/register_controller.dart';
import 'package:get/get.dart';

class RegisterBinding extends Bindings {

  @override
  void dependencies() {
    Get.lazyPut<RegisterController>(() => RegisterController());
  }
}