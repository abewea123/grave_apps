import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:grave_apps/config/routes.dart';
import 'package:grave_apps/config/toast_view.dart';

import '../../config/theme_data.dart';

class TetapanView extends StatefulWidget {
  final User? user;
  const TetapanView({super.key, required this.user});

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
                        leading: const Icon(Icons.format_paint),
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
                      widget.user!.isAnonymous
                          ? ListTile(
                              leading: const Icon(Icons.person),
                              title: const Text('Log Masuk'),
                              subtitle:
                                  const Text('Log masuk akaun pengurusan'),
                              onTap: () => Get.toNamed(MyRoutes.login),
                            )
                          : ListTile(
                              leading: const Icon(Icons.logout),
                              title: const Text('Log Keluar'),
                              subtitle:
                                  const Text('Log keluar akaun pengurusan'),
                              onTap: () {
                                FirebaseAuth.instance.signOut().then((value) {
                                  ToastView.error(
                                    context,
                                    icon: Icons.logout,
                                    subtitle:
                                        'Sila log masuk semula untuk mengaktifkan ciri pengurusan',
                                    title: 'Log Keluar Berjaya',
                                  );
                                });
                              },
                            ),
                      // Text(
                      //   'Debugging',
                      //   style: TextStyle(
                      //     color: Theme.of(context).colorScheme.primary,
                      //     fontWeight: FontWeight.bold,
                      //   ),
                      // ),
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
