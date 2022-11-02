import 'package:get/get.dart';

import '../controllers/stock_details_controller.dart';

class StockDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StockDetailsController>(
      () => StockDetailsController(),
    );
  }
}
