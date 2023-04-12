import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grave_apps/home/controller/home_controller.dart';
import 'package:grave_apps/config/scroll_config.dart';
import 'package:grave_apps/config/theme.dart';

import 'home/view_home.dart';

Future<void> main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'E-Grave Apps',
      debugShowCheckedModeBanner: false,
      theme: MyTheme().lightTheme(Theme.of(context).colorScheme),
      scrollBehavior: MyCustomScrollBehavior(),
      home: Home(controller: _controller),
    );
  }
}
