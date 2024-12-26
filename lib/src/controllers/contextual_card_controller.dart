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

  void fetchCards() async {
    isLoading(true);
    try {
      final response = await ApiService.getCards();
      cards.assignAll(response);
    } catch (e) {
      errorMessage(e.toString());
    } finally {
      isLoading(false);
    }
  }

  void dismissCard(int cardId) {
    cards.removeWhere((group) =>
        group.cards.any((card) => card.title.hashCode == cardId));
  }
}
