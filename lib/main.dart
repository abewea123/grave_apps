import 'package:dynamic_color/dynamic_color.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:grave_apps/config/routes.dart';
import 'package:grave_apps/config/scroll_config.dart';
import 'package:grave_apps/config/theme_data.dart';
import 'config/color_scheme.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await GetStorage.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
        initialRoute: MyRoutes.home,
        getPages: MyRoutes().page,
      );
    });
  }
}
