import 'package:fampay/src/services/api_service.dart';
import 'package:get/get.dart';
import '../data/repository/fampay_repo.dart';
import 'package:http/http.dart' as http;

class FamxPayController extends GetxController {
  static FamxPayController get instance => Get.find();

  var isLoading = true.obs;
  var famxPayData = {}.obs;
  RxnString longPressedCardId = RxnString(); // Updated to handle string IDs
  final repository = Get.put(FamxPayRepository(apiService: FamxPayApiService(client: http.Client())));


  @override
  void onInit() {
    super.onInit();
    fetchFamxPayData();
  }

  void fetchFamxPayData() async {
    try {
      isLoading(true);
      final data = await repository.fetchFamxPayData();
      famxPayData.value = data;
    } catch (e) {
      print('Error in FamxPayController: $e');
      Get.snackbar('Error', 'Failed to load data. Please try again.');
    } finally {
      isLoading(false);
    }
  }

  void handleLongPress(int id) {
    longPressedCardId.value = id.toString(); // Convert int to string
  }

  void clearLongPress() {
    longPressedCardId.value = null;
  }
}
