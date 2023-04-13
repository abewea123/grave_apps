import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grave_apps/home/controller/home_controller.dart';
import 'package:grave_apps/config/scroll_config.dart';
import 'package:grave_apps/config/theme_data.dart';
import 'config/color_scheme.dart';
import 'home/view_home.dart';

Future<void> main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
        builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
      ColorScheme colorSchemeLight;
      ColorScheme colorSchemeDark;
      if (lightDynamic != null && darkDynamic != null) {
        colorSchemeLight = lightDynamic.harmonized();
        colorSchemeDark = darkDynamic.harmonized();
      } else {
        colorSchemeLight = lightColorScheme;
        colorSchemeDark = darkColorScheme;
      }
      return GetMaterialApp(
        title: 'E-Grave Apps',
        debugShowCheckedModeBanner: false,
        themeMode: MyTheme().themeMode,
        theme: MyTheme().lightTheme(colorSchemeLight),
        darkTheme: MyTheme().darkTheme(colorSchemeDark),
        scrollBehavior: MyCustomScrollBehavior(),
        home: Home(controller: _controller),
      );
    });
  }
}
