import 'package:avio/avio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/routes/app_pages.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Avio.init();
  runApp(
    GetMaterialApp(
      title: "Stock Market",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      theme: ThemeData.from(
          colorScheme: ColorScheme.fromSeed(
        seedColor: const Color.fromRGBO(27, 48, 90, 1),
      )),
      builder: (context, child) => AvioWrapper(
        child: child!,
      ),
    ),
  );
}
