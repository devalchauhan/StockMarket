import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stock_market/app/modules/home/views/StockSearchDelegate.dart';
import 'package:stock_market/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stock Market'),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () async => controller.getData(),
        child: SingleChildScrollView(
          primary: true,
          physics: const AlwaysScrollableScrollPhysics(),
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () async {
                    var result = await showSearch(
                        context: context, delegate: StockSearchDelegate());
                    if (result != null && result == true) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text(
                              "Successfully added the stock to watchlist.")));
                    }
                  },
                  child: TextFormField(
                    enabled: false,
                    decoration: InputDecoration(
                      disabledBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      border: InputBorder.none,
                      suffixIcon: const Icon(
                        Icons.search,
                        color: Colors.grey,
                      ),
                      hintText: 'Search',
                      filled: true,
                      fillColor: Colors.grey.shade200,
                      contentPadding: const EdgeInsets.all(18),
                    ),
                    onTap: () {},
                  ),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                controller.obx(
                  (state) => ListView.builder(
                    primary: false,
                    shrinkWrap: true,
                    itemCount: controller.limitedStocks.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 0),
                        title: Text(controller.limitedStocks[index].name!),
                        trailing: Text(controller.limitedStocks[index].symbol!),
                        subtitle: Text(controller
                            .limitedStocks[index].stockExchange!.name!),
                        onTap: () {
                          Get.toNamed(Routes.STOCK_DETAILS, arguments: [
                            controller.limitedStocks[index].name!,
                            controller.limitedStocks[index].symbol!,
                          ]);
                        },
                      );
                    },
                  ),
                  onLoading: const Center(
                    heightFactor: 5,
                    child: CircularProgressIndicator.adaptive(),
                  ),
                  onError: (error) {
                    return Center(
                      heightFactor: 5,
                      child: Text(
                        error ?? "",
                        textAlign: TextAlign.center,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
