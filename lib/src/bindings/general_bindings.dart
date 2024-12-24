import 'package:fampay/src/controller/fampay_controller.dart';
import 'package:fampay/src/data/repository/fampay_repo.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../services/api_service.dart';

class GeneralBindings extends Bindings {
  @override
  Future<void> dependencies() async {
    // Controller 
    Get.put(
    FamxPayController(
      repository: FamxPayRepository(
        apiService: FamxPayApiService(client: http.Client()),
      ),
    ));
  }
}
