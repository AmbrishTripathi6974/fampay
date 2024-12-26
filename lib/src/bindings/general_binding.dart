import 'package:fampay/src/controllers/contextual_card_controller.dart';
import 'package:get/get.dart';

class GeneralBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(ContextualCardController());
  }
}