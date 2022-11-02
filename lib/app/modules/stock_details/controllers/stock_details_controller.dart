import 'dart:async';

import 'package:avio/avio.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:stock_market/app/data/constants.dart';
import 'package:stock_market/app/data/endpoints.dart';
import 'package:stock_market/app/data/helpers.dart';
import 'package:stock_market/app/models/intraday.dart';

class StockDetailsController extends GetxController with StateMixin {
  RxList<FlSpot> spots = <FlSpot>[].obs;
  Rx<Intraday> stock = Intraday().obs;
  RxDouble minY = double.infinity.obs;
  RxDouble maxY = 0.0.obs;

  Rx<String> interval = Constants.intervalDaily.obs;

  @override
  void onReady() {
    fetchData();
    super.onReady();
  }

  fetchData() {
    getData(
        interval.value,
        DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()
            .subtract(Duration(days: getDaysBeforeByInterval(interval.value)))),
        DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()));
  }

  Future<List<FlSpot>> getData(
    String interval,
    String dateFrom,
    String dateTo,
  ) async {
    Completer<List<FlSpot>> completer = Completer();

    List<FlSpot> flSpots = [];
    var symbol = Get.arguments[1];

    change([], status: RxStatus.loading());

    ApiCall.instance.rest(
      params: {},
      serviceUrl:
          '${Endpoints.intraday + Constants.ACCESS_KEY}&symbols=$symbol&interval=$interval&date_from=$dateFrom&date_to=$dateTo',
      showLoader: false,
      methodType: RestMethod.get,
      error: (status, error) {
        if (status == 429) {
          change([],
              status: RxStatus.error(
                  "Monthly usage limit has been reached.\nUpgrade your subscription plan."));
        } else {
          change([], status: RxStatus.error("No data found."));
        }
      },
      success: (status, data) {
        if (status == 200) {
          List<Intraday> intradays = [];
          for (var intraday in data['data']) {
            intradays.add(Intraday.fromJson(intraday));
          }
          double xAxisVal = -1;
          //
          for (var intraday in intradays) {
            if (minY.value > intraday.open!) {
              minY.value = intraday.open!;
            }
            if (maxY.value < intraday.open!) {
              maxY.value = intraday.open!;
            }

            xAxisVal = xAxisVal + 1;
            flSpots.add(FlSpot(xAxisVal, intraday.open!));
          }
          minY.value = minY.value * 0.999;
          maxY.value = maxY.value * 1.001;

          stock.value = intradays.isNotEmpty ? intradays[0] : Intraday();

          change(flSpots, status: RxStatus.success());
          return completer.complete(flSpots);
        }
      },
    );

    return completer.future;
  }
}
