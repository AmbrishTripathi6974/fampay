import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/contextual_card_model.dart';

class ApiService {
  static Future<List<ContextualCardModel>> getCards() async {
    final url = Uri.parse('https://polyjuice.kong.fampay.co/mock/famapp/feed/home_section/?slugs=famx-paypage');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      var data = json.decode(response.body) as List;
      return data.map((json) => ContextualCardModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load cards');
    }
  }
}
