import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/contextual_card_model.dart';
import '../services/api_service.dart'; // Add this import

class ContextualCardController extends GetxController {
  var cards = <ContextualCardModel>[].obs;
  var isLoading = true.obs;
  var errorMessage = ''.obs;
  final dismissedCardIds = <int>{}.obs; // Add this set to track dismissed cards

  @override
  void onInit() {
    super.onInit();
    loadDismissedCards(); // Load dismissed card IDs on initialization
    fetchCards();
  }

  Future<void> fetchCards() async {
    try {
      isLoading.value = true;
      var fetchedCards = await ApiService.getCards();

      // Filter out permanently dismissed cards
      cards.value = fetchedCards.where((cardGroup) {
        return cardGroup.cards.every((card) => !dismissedCardIds.contains(card.id));
      }).toList();
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> dismissCard(int cardId) async {
    dismissedCardIds.add(cardId); // Mark card as dismissed
    cards.value = cards.where((cardGroup) {
      return cardGroup.cards.any((card) => card.id != cardId);
    }).toList(); // Remove the card from the list
    await saveDismissedCards();
  }

  Future<void> remindLater(int cardId) async {
    // Just remove the card temporarily from the list
    cards.value = cards.where((cardGroup) {
      return cardGroup.cards.any((card) => card.id != cardId);
    }).toList();
  }

  Future<void> saveDismissedCards() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('dismissedCards', dismissedCardIds.map((id) => id.toString()).toList());
  }

  Future<void> loadDismissedCards() async {
    final prefs = await SharedPreferences.getInstance();
    final storedDismissedIds = prefs.getStringList('dismissedCards') ?? [];
    dismissedCardIds.addAll(storedDismissedIds.map(int.parse));
  }
}
