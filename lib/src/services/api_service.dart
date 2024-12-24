import 'dart:convert';
import 'package:http/http.dart' as http;
import '../data/api/constants.dart';
class ApiService {
  static Future<List<dynamic>> fetchHcGroups() async {
    try {
      final response = await http.get(Uri.parse(Constants.apiUrl));
      print("HTTP Status Code: ${response.statusCode}"); // Log status code

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print("Raw API Response: $data"); // Log raw response
        final hcGroups = data['hc_groups']; // Accessing `hc_groups`
        print("Parsed HC Groups: $hcGroups"); // Log parsed data
        return hcGroups ?? [];
      } else {
        throw Exception("Failed to load HC Groups: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching data: $e");
      rethrow;
    }
  }
}
