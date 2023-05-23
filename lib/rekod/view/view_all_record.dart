import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:grave_apps/config/extension.dart';
import 'package:grave_apps/config/haptic_feedback.dart';
import 'package:grave_apps/config/routes.dart';
import 'package:grave_apps/home/model/jenazah_model.dart';

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
              delegate: SliverChildListDelegate(
                [
                  StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('jenazah')
                          .where('approve', isEqualTo: true)
                          .snapshots(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const SizedBox(
                            width: double.infinity,
                            height: 500,
                            child: Column(
                              children: [
                                CircularProgressIndicator.adaptive(),
                                SizedBox(height: 10),
                                Text('Memuatkan data...')
                              ],
                            ),
                          );
                        }
                        return Column(
                          children: snapshot.data!.docs.map((docs) {
                            final jenazah = Jenazah.fromFirestore(docs);
                            return ListTile(
                              leading: Hero(
                                tag: jenazah.id.toString(),
                                child: CircleAvatar(
                                  backgroundImage:
                                      NetworkImage(jenazah.gambarKubur),
                                ),
                              ),
                              title: Text(jenazah.nama.capitalizeByWord()),
                              subtitle: Text(
                                  jenazah.tempatTinggal.capitalizeByWord()),
                              onTap: () => Get.toNamed(
                                MyRoutes.detailsRekod,
                                parameters: {
                                  'uid': jenazah.id.toString(),
                                },
                              ),
                            );
                          }).toList(),
                        );
                      }),
                ],
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
