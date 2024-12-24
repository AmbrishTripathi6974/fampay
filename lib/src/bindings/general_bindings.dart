import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';

import '../controller/fampay_controller.dart';
import '../data/repository/fampay_repo_impl.dart';
import '../services/api_service.dart';
import '../services/background_service.dart';
import '../services/cache_service.dart';
import '../services/retry_service.dart';

class GeneralBindings extends Bindings {
  @override
  Future<void> dependencies() async {
    // Initialize SharedPreferences
    final prefs = await SharedPreferences.getInstance();

    // Create services
    final apiService = FamxPayApiService(client: http.Client());
    final cacheService = FamxPayCacheService(prefs: prefs);
    final retryService = RetryService(
      policy: RetryPolicy(
        maxAttempts: 3,
        initialDelay: const Duration(seconds: 1),
        backoffFactor: 2.0,
        maxDelay: const Duration(seconds: 10),
      ),
    );

    // Create repository
    final repository = FamxPayRepositoryImpl(
      apiService: apiService,
      cacheService: cacheService,
      retryService: retryService,
    );

    // Create background service
    final workmanager = Workmanager();
    final backgroundService = BackgroundService(
      repository: repository,
      workmanager: workmanager,
    );

    // Register Controller
    Get.put(
      FamxPayController(
        repository: repository,
        backgroundService: backgroundService,
      ),
    );
  }
}
