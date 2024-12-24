import 'dart:async';

import 'package:get/get.dart';

import '../data/error_handler.dart';
import '../data/repository/fampay_repo.dart';
import '../data/repository/fampay_repo_impl.dart';
import '../model/fampay_model.dart';
import '../services/background_service.dart';

class FamxPayController extends GetxController {
  final FamxPayRepository repository;
  final BackgroundService backgroundService;
  
  final Rx<FamxPay?> famxPay = Rx<FamxPay?>(null);
  final RxList<HcGroup> hcGroups = <HcGroup>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool isRefreshing = false.obs;
  final Rx<FamxPayException?> error = Rx<FamxPayException?>(null);
  StreamSubscription? _dataSubscription;

  FamxPayController({
    required this.repository,
    required this.backgroundService,
  });

  @override
  void onInit() {
    super.onInit();
    _initializeBackgroundRefresh();
    _subscribeToDataUpdates();
  }

  Future<void> _initializeBackgroundRefresh() async {
    try {
      await backgroundService.initialize();
      await backgroundService.schedulePeriodicRefresh();
    } catch (e) {
      print('Failed to initialize background refresh: $e');
    }
  }

  void _subscribeToDataUpdates() {
    if (repository is FamxPayRepositoryImpl) {
      _dataSubscription = (repository as FamxPayRepositoryImpl)
          .dataStream
          .listen(_updateData, onError: _handleError);
    }
  }

  void _updateData(FamxPay data) {
    famxPay.value = data;
    hcGroups.value = data.hcGroups;
  }

  void _handleError(dynamic error) {
    if (error is FamxPayException) {
      this.error.value = error;
    } else {
      this.error.value = FamxPayException('Unexpected error: $error');
    }
  }

  Future<void> loadFamxPayData({bool showLoading = true}) async {
    try {
      if (showLoading) isLoading.value = true;
      error.value = null;
      
      final data = await repository.getFamxPayData();
      _updateData(data);
    } on FamxPayException catch (e) {
      _handleError(e);
    } catch (e) {
      _handleError(FamxPayException('Unexpected error occurred: $e'));
    } finally {
      if (showLoading) isLoading.value = false;
    }
  }

  Future<void> refreshData() async {
    try {
      isRefreshing.value = true;
      error.value = null;
      
      await repository.refreshData();
    } on FamxPayException catch (e) {
      _handleError(e);
    } catch (e) {
      _handleError(FamxPayException('Failed to refresh: $e'));
    } finally {
      isRefreshing.value = false;
    }
  }

  @override
  void onClose() {
    _dataSubscription?.cancel();
    if (repository is FamxPayRepositoryImpl) {
      (repository as FamxPayRepositoryImpl).dispose();
    }
    super.onClose();
  }
}