import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grave_apps/home/page/laman_utama.dart';
import 'package:grave_apps/home/page/pengurusan_jenazah.dart';
import 'package:grave_apps/home/page/tetapan_view.dart';

import 'controller/home_controller.dart';

class Home extends StatelessWidget {
  Home({super.key});
  final _controller = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
          stream: _controller.userChange,
          builder: (context, snapshot) {
            User? user = snapshot.data;

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }

            if (user == null) {
              debugPrint('User has been logout! Sign in anonymous');

              FirebaseAuth.instance.signInAnonymously();
              return const SizedBox(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Melaraskan data...'),
                    SizedBox(height: 10),
                    CircularProgressIndicator.adaptive(),
                  ],
                ),
              );
            }
            return Row(
              children: [
                MediaQuery.of(context).size.width > 600
                    ? Obx(() => NavigationRail(
                          minWidth: 80,
                          extended: MediaQuery.of(context).size.width > 900
                              ? true
                              : false,
                          useIndicator: true,
                          leading: user.isAnonymous
                              ? const SizedBox()
                              : Column(
                                  children: [
                                    CircleAvatar(
                                      backgroundImage: NetworkImage(
                                        user.photoURL.toString(),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                  ],
                                ),
                          destinations: const [
                            NavigationRailDestination(
                              icon: Icon(Icons.home_outlined),
                              selectedIcon: Icon(Icons.home),
                              label: Text('Laman Utama'),
                            ),
                            NavigationRailDestination(
                              icon: Icon(Icons.manage_accounts),
                              selectedIcon: Icon(Icons.manage_accounts),
                              label: Text('Pengurusan'),
                            ),
                            NavigationRailDestination(
                              icon: Icon(Icons.settings_outlined),
                              selectedIcon: Icon(Icons.settings),
                              label: Text('Tetapan'),
                            ),
                          ],
                          selectedIndex: _controller.index.value,
                          onDestinationSelected: (value) {
                            _controller.index.value = value;
                            _controller.box.write('currentNav', value);
                          },
                        ))
                    : const SizedBox(),
                MediaQuery.of(context).size.width >= 600
                    ? const VerticalDivider()
                    : const SizedBox(),
                Expanded(
                  child: Obx(() => IndexedStack(
                        index: _controller.index.value,
                        children: [
                          LamanUtamaView(controller: _controller, user: user),
                          PengurusanJenazahView(user: user),
                          TetapanView(user: user),
                        ],
                      )),
                ),
              ],
            );
          }),
      bottomNavigationBar: MediaQuery.of(context).size.width < 600
          ? Obx(
              () => NavigationBar(
                onDestinationSelected: (value) {
                  _controller.index.value = value;
                  _controller.box.write('currentNav', value);
                },
                selectedIndex: _controller.index.value,
                destinations: [
                  const NavigationDestination(
                    icon: Icon(Icons.home_outlined),
                    selectedIcon: Icon(Icons.home),
                    label: 'Laman Utama',
                  ),
                  const NavigationDestination(
                    icon: Icon(Icons.manage_accounts),
                    selectedIcon: Icon(Icons.manage_accounts),
                    label: 'Pengurusan',
                  ),
                  NavigationDestination(
                    icon: const Icon(Icons.settings_outlined),
                    selectedIcon: const Icon(Icons.settings),
                    label: 'Tetapan'.tr,
                  ),
                ],
              ),
            )
          : null,
    );
  }
}
