// ignore_for_file: unused_import

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:stock_market/app/data/constants.dart';
import 'package:stock_market/app/data/helpers.dart';

import '../controllers/stock_details_controller.dart';

class StockDetailsView extends GetView<StockDetailsController> {
  StockDetailsView({Key? key}) : super(key: key);
  dynamic args = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Text(args[1]),
            const SizedBox(height: 2),
            Text(
              args[0],
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 18.0,
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          args[0],
                          softWrap: true,
                          overflow: TextOverflow.clip,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        Text(
                          args[1],
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w300,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Obx(
                        () => Text(
                          controller.stock.value.open?.toString() ?? '',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 8.0,
              ),
              const Divider(),
              const SizedBox(
                height: 8.0,
              ),
              controller.obx(
                (flSpots) => SizedBox(
                  height: 300,
                  width: double.infinity,
                  child: LineChart(
                    LineChartData(
                      lineTouchData: LineTouchData(
                          touchTooltipData: LineTouchTooltipData(
                              tooltipBgColor: Colors.white)),
                      lineBarsData: [
                        LineChartBarData(
                          isCurved: false,
                          barWidth: 1.2,
                          shadow: const Shadow(
                              blurRadius: 1, color: Colors.blueGrey),
                          isStrokeCapRound: true,
                          color: Get.theme.primaryColor,
                          dotData: FlDotData(
                            show: false,
                          ),
                          belowBarData: BarAreaData(
                            show: true,
                            color: Get.theme.primaryColor.withOpacity(0.1),
                          ),
                          spots: flSpots,
                        ),
                      ],
                      titlesData: FlTitlesData(
                        show: true,
                        bottomTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false)),
                        leftTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false)),
                        topTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false)),
                      ),
                      gridData: FlGridData(show: false),
                      borderData: FlBorderData(
                        show: false,
                        border: Border(
                          bottom:
                              BorderSide(color: Colors.grey[100]!, width: 4),
                          left: const BorderSide(color: Colors.transparent),
                          right: const BorderSide(color: Colors.transparent),
                          top: const BorderSide(color: Colors.transparent),
                        ),
                      ),
                      minX: 0,
                      minY: controller.minY.value,
                      maxX: double.parse(flSpots.length.toString()),
                      maxY: controller.maxY.value,
                    ),
                  ),
                ),
                onLoading: const SizedBox(
                  height: 300,
                  child: Center(
                    heightFactor: 4,
                    child: CircularProgressIndicator.adaptive(),
                  ),
                ),
                onError: (error) => SizedBox(
                  height: 300,
                  child: Center(
                    heightFactor: 4,
                    child: Text(error ?? ''),
                  ),
                ),
              ),
              const SizedBox(
                height: 14.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(
                    () => OutlinedButton(
                        onPressed: () {
                          controller.interval.value = Constants.intervalDaily;
                          controller.fetchData();
                        },
                        style: controller.interval.value ==
                                Constants.intervalDaily
                            ? ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Get.theme.primaryColor.withOpacity(0.2)))
                            : null,
                        child: const Text('1D')),
                  ),
                  Obx(
                    () => OutlinedButton(
                        onPressed: () {
                          controller.interval.value = Constants.intervalWeekly;
                          controller.fetchData();
                        },
                        style: controller.interval.value ==
                                Constants.intervalWeekly
                            ? ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Get.theme.primaryColor.withOpacity(0.2)))
                            : null,
                        child: const Text('1W')),
                  ),
                  Obx(
                    () => OutlinedButton(
                        onPressed: () {
                          controller.interval.value = Constants.intervalMonthly;
                          controller.fetchData();
                        },
                        style: controller.interval.value ==
                                Constants.intervalMonthly
                            ? ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Get.theme.primaryColor.withOpacity(0.2)))
                            : null,
                        child: const Text('1M')),
                  ),
                  Obx(
                    () => OutlinedButton(
                        onPressed: () {
                          controller.interval.value = Constants.intervalYearly;
                          controller.fetchData();
                        },
                        style: controller.interval.value ==
                                Constants.intervalYearly
                            ? ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Get.theme.primaryColor.withOpacity(0.2)))
                            : null,
                        child: const Text('1Y')),
                  )
                ],
              ),
              const SizedBox(
                height: 14.0,
              ),
              const Divider(),
              const SizedBox(
                height: 14.0,
              ),
              const Text(
                'Fundamentals',
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(
                height: 18.0,
              ),
              Obx(
                () {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            textAlign: TextAlign.start,
                            text: TextSpan(children: [
                              const TextSpan(
                                  text: 'Open : ',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.black)),
                              TextSpan(
                                  text: '${controller.stock.value.open ?? '-'}',
                                  style: const TextStyle(
                                      fontSize: 18, color: Colors.grey)),
                            ]),
                          ),
                          const SizedBox(
                            height: 8.0,
                          ),
                          RichText(
                            textAlign: TextAlign.start,
                            text: TextSpan(children: [
                              const TextSpan(
                                  text: 'Close : ',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.black)),
                              TextSpan(
                                  text:
                                      '${controller.stock.value.close ?? '-'}',
                                  style: const TextStyle(
                                      fontSize: 18, color: Colors.grey)),
                            ]),
                          ),
                          const SizedBox(
                            height: 8.0,
                          ),
                          RichText(
                            textAlign: TextAlign.start,
                            text: TextSpan(children: [
                              const TextSpan(
                                  text: 'High : ',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.black)),
                              TextSpan(
                                  text: '${controller.stock.value.high ?? '-'}',
                                  style: const TextStyle(
                                      fontSize: 18, color: Colors.grey)),
                            ]),
                          ),
                          const SizedBox(
                            height: 8.0,
                          ),
                          RichText(
                            textAlign: TextAlign.start,
                            text: TextSpan(children: [
                              const TextSpan(
                                  text: 'Low : ',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.black)),
                              TextSpan(
                                  text: '${controller.stock.value.low ?? '-'}',
                                  style: const TextStyle(
                                      fontSize: 18, color: Colors.grey)),
                            ]),
                          ),
                        ],
                      ),
                      const SizedBox(width: 80.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            textAlign: TextAlign.start,
                            text: TextSpan(children: [
                              const TextSpan(
                                  text: 'Volume : ',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.black)),
                              TextSpan(
                                  text:
                                      '${controller.stock.value.volume ?? '-'}',
                                  style: const TextStyle(
                                      fontSize: 18, color: Colors.grey)),
                            ]),
                          ),
                          const SizedBox(
                            height: 8.0,
                          ),
                          RichText(
                            textAlign: TextAlign.start,
                            text: TextSpan(children: [
                              const TextSpan(
                                  text: 'Last : ',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.black)),
                              TextSpan(
                                  text: '${controller.stock.value.last ?? '-'}',
                                  style: const TextStyle(
                                      fontSize: 18, color: Colors.grey)),
                            ]),
                          ),
                          const SizedBox(
                            height: 8.0,
                          ),
                          RichText(
                            textAlign: TextAlign.start,
                            text: TextSpan(children: [
                              const TextSpan(
                                  text: 'Symbol : ',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.black)),
                              TextSpan(
                                  text: controller.stock.value.symbol ?? '-',
                                  style: const TextStyle(
                                      fontSize: 18, color: Colors.grey)),
                            ]),
                          ),
                          const SizedBox(
                            height: 8.0,
                          ),
                          RichText(
                            textAlign: TextAlign.start,
                            text: TextSpan(children: [
                              const TextSpan(
                                  text: 'Exchange : ',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.black)),
                              TextSpan(
                                  text: controller.stock.value.exchange ?? '-',
                                  style: const TextStyle(
                                      fontSize: 18, color: Colors.grey)),
                            ]),
                          ),
                        ],
                      )
                    ],
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
