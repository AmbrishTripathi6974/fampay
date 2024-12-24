import 'package:http/http.dart' as http;
import 'dart:convert';

class FamxPayApiService {
  static const String baseUrl = 'https://polyjuice.kong.fampay.co';
  static const String endpoint = '/mock/famapp/feed/home_section/';

  final http.Client client;

  FamxPayApiService({required this.client});

  Future<Map<String, dynamic>> getFamxPayData() async {
    final queryParameters = {'slugs': 'famx-paypage'};
    final uri = Uri.parse(baseUrl + endpoint).replace(queryParameters: queryParameters);

    try {
      // Sending GET request
      final response = await client.get(uri, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      });

      // Log response details for debugging
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      // Handling HTTP status codes
      if (response.statusCode == 200) {
        final List<dynamic> decodedResponse = json.decode(response.body);

        // Validate and parse the response
        if (decodedResponse.isNotEmpty) {
          final famxPaySection = decodedResponse.firstWhere(
            (section) => section['slug'] == 'famx-paypage',
            orElse: () => null,
          );

          if (famxPaySection != null) {
            return famxPaySection;
          } else {
            throw Exception('famx-paypage section not found in response.');
          }
        } else {
          throw Exception('No sections found in response.');
        }
      } else {
        throw Exception('Failed to load data: HTTP ${response.statusCode}');
      }
    } catch (error) {
      // Logging the error
      print('Error fetching FamxPay data: $error');
      throw Exception('Failed to fetch data. Please check your connection or try again later.');
    }
  }
}
