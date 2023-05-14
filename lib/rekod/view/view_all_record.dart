import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:grave_apps/config/haptic_feedback.dart';
import 'package:grave_apps/config/routes.dart';

import '../../home/controller/home_controller.dart';

class ViewAllRecord extends StatelessWidget {
  ViewAllRecord({super.key});

  final _controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NotificationListener<UserScrollNotification>(
        onNotification: (noti) {
          if (noti.direction == ScrollDirection.forward) {
            _controller.fabScrollAllRecord.value = true;
          } else if (noti.direction == ScrollDirection.reverse) {
            _controller.fabScrollAllRecord.value = false;
          }
          return true;
        },
        child: CustomScrollView(
          slivers: [
            SliverAppBar.large(
              title: const Text('Semua Rekod'),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  var jenazah = _controller.jenazah[index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(jenazah.gambarKubur),
                    ),
                    title: Text(jenazah.nama),
                    subtitle: Text(jenazah.tempatTinggal),
                    onTap: () {},
                  );
                },
                childCount: _controller.jenazah.length,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Obx(() => FloatingActionButton.extended(
            onPressed: () {
              Haptic.feedbackClick();
              Get.toNamed(MyRoutes.tambahRekod);
            },
            label: const Text('Tambah Rekod'),
            icon: const Icon(Icons.add),
            heroTag: null,
            isExtended: _controller.fabScrollAllRecord.value,
          )),
    );
  }
}
