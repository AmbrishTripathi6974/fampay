import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/contextual_card_model.dart';

class ApiService {
  static Future<List<ContextualCardModel>> getCards() async {
    final url = Uri.parse(
        'https://polyjuice.kong.fampay.co/mock/famapp/feed/home_section/?slugs=famx-paypage');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      print("API Response: $data");

      // Check the structure of hc_groups
      if (data is List) {
        List<ContextualCardModel> cards = [];
        for (var group in data) {
          // Ensure hc_groups exists and is a list
          if (group['hc_groups'] is List) {
            // Iterate through each hc_group and parse the cards
            for (var hcGroup in group['hc_groups']) {
              if (hcGroup['cards'] is List) {
                cards.add(ContextualCardModel.fromJson(hcGroup));
              }
            }
          }
        }
        return cards;
      } else {
        throw Exception('Unexpected API response format');
      }
    } else {
      throw Exception('Failed to load cards');
    }
  }
}
