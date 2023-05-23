import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:grave_apps/config/routes.dart';
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
                              leading: StreamBuilder(
                                  stream: FirebaseFirestore.instance
                                      .collection('jenazah')
                                      .where('approve', isEqualTo: false)
                                      .snapshots(),
                                  builder: (context,
                                      AsyncSnapshot<QuerySnapshot> snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const Icon(Icons.person_2_rounded);
                                    }
                                    return snapshot.data!.docs.isEmpty
                                        ? const Icon(Icons.person_2_rounded)
                                        : Badge(
                                            label: Text(snapshot
                                                .data!.docs.length
                                                .toString()),
                                            child: const Icon(
                                                Icons.person_2_rounded),
                                          );
                                  }),
                              title: const Text('Maklumat Akaun'),
                              subtitle: const Text('Lihat maklumat anda'),
                              onTap: () =>
                                  Get.toNamed(MyRoutes.maklumatPengurusan),
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
