import 'dart:math';

import 'package:avio/avio.dart';
import 'package:get/get.dart';
import 'package:stock_market/app/data/constants.dart';
import 'package:stock_market/app/data/endpoints.dart';
import 'package:stock_market/app/models/stock.dart';

class HomeController extends GetxController with StateMixin {
  RxList<StockModel> limitedStocks = <StockModel>[].obs;
  RxList<StockModel> allStocks = <StockModel>[].obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    getData();
  }

  Future<void> getData() async {
    change([], status: RxStatus.loading());
    ApiCall.instance.rest(
      params: {},
      serviceUrl: Endpoints.tickers + Constants.ACCESS_KEY,
      showLoader: false,
      methodType: RestMethod.get,
      error: (status, error) {
        if (status == 429) {
          change([],
              status: RxStatus.error(
                  "Monthly usage limit has been reached.\nUpgrade your subscription plan."));
        } else {
          change([], status: RxStatus.error("Something wen't wrong."));
        }
      },
      success: (status, data) {
        if (status == 200) {
          allStocks.clear();
          for (Map<String, dynamic> stock in data['data']) {
            allStocks.add(StockModel.fromJson(stock));
          }
          limitedStocks.clear();
          for (int i = 0; i < 10; i++) {
            limitedStocks.add(allStocks[Random().nextInt(99)]);
          }
          change([], status: RxStatus.success());
        }
      },
    );
    return;
  }

  @override
  void onClose() {
    super.onClose();
  }
}
