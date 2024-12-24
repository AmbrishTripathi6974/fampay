import '../../services/api_service.dart';

class FamxPayRepository {
  final FamxPayApiService apiService;

  FamxPayRepository({required this.apiService});

  Future<Map<String, dynamic>> fetchFamxPayData() async {
    try {
      final data = await apiService.getFamxPayData();
      return data;
    } catch (e) {
      // Log the error for debugging
      print('Error in FamxPayRepository: $e');
      throw Exception('Error in FamxPayRepository: $e');
    }
  }
}
