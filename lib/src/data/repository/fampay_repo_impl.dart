

import 'dart:async';

import 'package:fampay/src/data/repository/fampay_repo.dart';

import '../../model/fampay_model.dart';
import '../../services/api_service.dart';
import '../../services/cache_service.dart';
import '../../services/retry_service.dart';
import '../error_handler.dart';

class FamxPayRepositoryImpl implements FamxPayRepository {
  final FamxPayApiService apiService;
  final FamxPayCacheService cacheService;
  final RetryService retryService;
  final StreamController<FamxPay> _dataStreamController;

  FamxPayRepositoryImpl({
    required this.apiService,
    required this.cacheService,
    RetryService? retryService,
  }) : retryService = retryService ?? RetryService(),
       _dataStreamController = StreamController<FamxPay>.broadcast();

  Stream<FamxPay> get dataStream => _dataStreamController.stream;

  @override
  Future<FamxPay> getFamxPayData({bool forceRefresh = false}) async {
    try {
      if (!forceRefresh) {
        final cachedData = await cacheService.getCachedData();
        if (cachedData != null) {
          final famxPay = FamxPay.fromJson(cachedData);
          _dataStreamController.add(famxPay);
          return famxPay;
        }
      }

      return await retryService.retry(() async {
        final jsonData = await apiService.getFamxPayData();
        await cacheService.cacheData(jsonData);
        final famxPay = FamxPay.fromJson(jsonData);
        _dataStreamController.add(famxPay);
        return famxPay;
      });
    } catch (e) {
      throw FamxPayException('Failed to get FamxPay data: $e');
    }
  }

  @override
  Future<void> refreshData() async {
    try {
      await cacheService.clearCache();
      await getFamxPayData(forceRefresh: true);
    } catch (e) {
      throw FamxPayException('Failed to refresh data: $e');
    }
  }

  void dispose() {
    _dataStreamController.close();
  }
}
