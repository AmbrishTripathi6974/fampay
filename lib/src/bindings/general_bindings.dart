import 'package:fampay/src/controller/fampay_controller.dart';
import 'package:get/get.dart';

class GeneralBindings extends Bindings {
  @override
  Future<void> dependencies() async {
    // Controller
    Get.put(FamxPayController());
  }
}
