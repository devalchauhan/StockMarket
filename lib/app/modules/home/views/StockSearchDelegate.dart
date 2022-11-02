import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stock_market/app/models/stock.dart';
import 'package:stock_market/app/modules/home/controllers/home_controller.dart';

class StockSearchDelegate extends SearchDelegate {
  HomeController homeController = Get.find();
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Column(
      children: <Widget>[
        ListView.builder(
          shrinkWrap: true,
          itemCount: homeController.allStocks.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(homeController.limitedStocks[index].name!),
              trailing: Text(homeController.limitedStocks[index].symbol!),
            );
          },
        ),
      ],
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<StockModel> suggestions = [];

    for (var stock in homeController.allStocks) {
      if (query.isNotEmpty &&
          stock.name!.toLowerCase().contains(query.toLowerCase())) {
        suggestions.add(stock);
      }
    }

    if (query.isEmpty) {
      return const Center(
        child: Text('Search for stocks'),
      );
    }
    if (query.isNotEmpty && suggestions.isEmpty) {
      return const Center(
        child: Text(
          'No data found.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18),
        ),
      );
    }
    return ListView.builder(
      shrinkWrap: true,
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(suggestions[index].name!),
          leading: Text(suggestions[index].symbol!),
          trailing: IconButton(
              onPressed: () {
                if (homeController.limitedStocks.firstWhereOrNull((element) =>
                        element.name == suggestions[index].name!) ==
                    null) {
                  homeController.limitedStocks.add(suggestions[index]);
                  close(context, true);
                  Get.find<HomeController>()
                      .change([], status: RxStatus.success());
                }
              },
              icon: homeController.limitedStocks.firstWhereOrNull((element) =>
                          element.name == suggestions[index].name!) ==
                      null
                  ? Icon(
                      Icons.add_box_outlined,
                      color: Get.theme.primaryColor,
                    )
                  : Icon(
                      Icons.check_box_outlined,
                      color: Get.theme.primaryColor,
                    )),
        );
      },
    );
  }
}
