import 'package:http/http.dart' as http;
import 'dart:convert';

class FamxPayApiService {
  static const String baseUrl = 'https://polyjuice.kong.fampay.co';
  static const String endpoint = '/mock/famapp/feed/home_section/';
  
  final http.Client client;

  FamxPayApiService({required this.client});

  Future<Map<String, dynamic>> getFamxPayData() async {
    try {
      final queryParameters = {
        'slugs': 'famx-paypage',
      };

      final uri = Uri.parse(baseUrl + endpoint).replace(
        queryParameters: queryParameters,
      );

      final headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        // Add any required auth headers here
      };

      final response = await client.get(uri, headers: headers);

      if (response.statusCode == 200) {
        final decodedResponse = json.decode(response.body);
        
        // Check if the response has sections
        if (decodedResponse['sections'] != null && 
            decodedResponse['sections'] is List &&
            decodedResponse['sections'].isNotEmpty) {
          
          // Find the famx-paypage section
          final famxPaySection = decodedResponse['sections'].firstWhere(
            (section) => section['slug'] == 'famx-paypage',
            orElse: () => null,
          );

          if (famxPaySection != null) {
            return famxPaySection;
          } else {
            throw Exception('famx-paypage section not found in response');
          }
        } else {
          throw Exception('No sections found in response');
        }
      } else {
        throw Exception('Failed to load FamxPay data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching FamxPay data: $e');
    }
  }
}