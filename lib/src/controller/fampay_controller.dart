import 'package:get/get.dart';
import '../data/repository/fampay_repo.dart';

class FamxPayController extends GetxController {
  final FamxPayRepository repository;

  FamxPayController({required this.repository});

  var isLoading = true.obs;
  var famxPayData = {}.obs;
  RxnString longPressedCardId = RxnString(); // Updated to handle string IDs

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
