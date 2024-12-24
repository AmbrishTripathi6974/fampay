import 'package:get/get.dart';
import 'package:workmanager/workmanager.dart';

import '../data/repository/fampay_repo.dart';

class BackgroundService {
  static const String refreshTask = 'com.fampay.refresh';
  static const Duration refreshInterval = Duration(hours: 1);
  
  final FamxPayRepository repository;
  final Workmanager workmanager;

  BackgroundService({
    required this.repository,
    required this.workmanager,
  });

  Future<void> initialize() async {
    await workmanager.initialize(
      callbackDispatcher,
      isInDebugMode: false,
    );
  }

  Future<void> schedulePeriodicRefresh() async {
    await workmanager.registerPeriodicTask(
      refreshTask,
      refreshTask,
      frequency: refreshInterval,
      constraints: Constraints(
        networkType: NetworkType.connected,
        requiresBatteryNotLow: true,
      ),
      existingWorkPolicy: ExistingWorkPolicy.replace,
      backoffPolicy: BackoffPolicy.exponential,
      initialDelay: const Duration(minutes: 15),
    );
  }

  Future<void> cancelPeriodicRefresh() async {
    await workmanager.cancelByUniqueName(refreshTask);
  }
}

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    try {
      if (task == BackgroundService.refreshTask) {
        final repository = Get.find<FamxPayRepository>();
        await repository.refreshData();
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  });
}