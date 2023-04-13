import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../config/theme_data.dart';

class TetapanView extends StatefulWidget {
  const TetapanView({super.key});

  @override
  State<TetapanView> createState() => _TetapanViewState();
}

class _TetapanViewState extends State<TetapanView> {
  String themeSubtitle(bool isDarkMode, bool isSystemTheme) {
    String result = 'Sistem';
    if (isDarkMode == true && isSystemTheme == false) {
      result = 'Gelap';
    } else if (isDarkMode == false && isSystemTheme == false) {
      result = 'Cerah';
    } else {
      result = 'Sistem';
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    bool onDarkMode = GetStorage().read('isDarkMode') ?? Get.isDarkMode;
    bool systemTheme = GetStorage().read('isSystemMode') ?? false;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            title: const Text('Tetapan'),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Paparan',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      ListTile(
                        leading: Icon(Icons.format_paint),
                        title: const Text('Tema'),
                        subtitle: Text(themeSubtitle(onDarkMode, systemTheme)),
                        onTap: () async {
                          await MyTheme().switchThemeDialog();
                          setState(() {
                            themeSubtitle(onDarkMode, systemTheme);
                          });
                        },
                      ),
                      Text(
                        'Akaun',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      ListTile(
                        leading: Icon(Icons.person),
                        title: Text('Log Masuk'),
                        subtitle: Text('Log masuk akaun pengurusan'),
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
