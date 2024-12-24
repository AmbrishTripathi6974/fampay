import '../../model/fampay_model.dart';

abstract class FamxPayRepository {
  Future<FamxPay> getFamxPayData({bool forceRefresh = false});
  Future<void> refreshData();
}
