import 'package:get/get.dart';
import '../models/contextual_card_model.dart';
import '../services/api_service.dart';

class ContextualCardController extends GetxController {
  var cards = <ContextualCardModel>[].obs;
  var isLoading = true.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCards();
  }

  Future<void> fetchCards() async {
    try {
      isLoading.value = true;
      var fetchedCards = await ApiService.getCards();
      cards.value = fetchedCards;
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
