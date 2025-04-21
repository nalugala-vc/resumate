import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:resumate_flutter/features/auth/viewmodel/auth_controller.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(SignInController());
    Get.lazyPut(() => SignUpController());
  }
}
