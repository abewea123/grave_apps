import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grave_apps/home/page/laman_utama.dart';
import 'package:grave_apps/home/page/pengurusan_jenazah.dart';
import 'package:grave_apps/home/page/tetapan_view.dart';

import 'controller/home_controller.dart';

class Home extends StatelessWidget {
  const Home({
    super.key,
    required HomeController controller,
  }) : _controller = controller;

  final HomeController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => IndexedStack(
            index: _controller.index.value,
            children: [
              LamanUtamaView(controller: _controller),
              const PengurusanJenazahView(),
              const TetapanView(),
            ],
          )),
      bottomNavigationBar: Obx(
        () => NavigationBar(
          onDestinationSelected: (value) => _controller.index.value = value,
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
      ),
    );
  }
}
