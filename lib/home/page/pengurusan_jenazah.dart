import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:grave_apps/config/haptic_feedback.dart';
import 'package:grave_apps/config/routes.dart';
import 'package:grave_apps/home/model/pengurusan_model.dart';
import '../controller/home_controller.dart';

extension StringExtension on String {
  String capitalizeByWord() {
    if (trim().isEmpty) {
      return '';
    }
    return split(' ')
        .map((element) =>
            "${element[0].toUpperCase()}${element.substring(1).toLowerCase()}")
        .join(" ");
  }
}

class PengurusanJenazahView extends StatelessWidget {
  final User? user;
  PengurusanJenazahView({super.key, required this.user});
  final _homeController = Get.find<HomeController>();
  // bool isScroll = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: user!.isAnonymous
          ? null
          : Obx(() => FloatingActionButton.extended(
                isExtended: _homeController.fabScrollPengurusan.value,
                onPressed: () {
                  Haptic.feedbackClick();
                  Get.toNamed(MyRoutes.tambahPengurusan);
                },
                icon: const Icon(Icons.add),
                label: const Text('Tambah Pengurusan'),
              )),
      body: NotificationListener<UserScrollNotification>(
        onNotification: (noti) {
          if (noti.direction == ScrollDirection.forward) {
            _homeController.fabScrollPengurusan.value = true;
          } else if (noti.direction == ScrollDirection.reverse) {
            _homeController.fabScrollPengurusan.value = false;
          }
          return true;
        },
        child: CustomScrollView(
          slivers: [
            SliverAppBar.large(
              title: const Text('Pengurusan'),
            ),
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('pengurusan')
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const SliverFillRemaining(
                      child: Align(
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('Memuat naik...'),
                            SizedBox(height: 10),
                            CircularProgressIndicator.adaptive(),
                          ],
                        ),
                      ),
                    );
                  }
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      ((context, index) {
                        return Column(
                          children: snapshot.data!.docs.map((docs) {
                            final pengurusan = Pengurusan.fromRealtime(docs);
                            return ListTile(
                              title: Text(pengurusan.nama.toString()),
                              subtitle: Text(pengurusan.jawatan
                                  .toString()
                                  .capitalizeByWord()),
                              onTap: () {
                                Haptic.feedbackSuccess();
                                showBottom(context, pengurusan);
                              },
                              leading: CircleAvatar(
                                child: ClipOval(
                                    child: Image.network(pengurusan.photoURL)),
                              ),
                            );
                          }).toList(),
                        );
                      }),
                      childCount: 1,
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }

  Future<dynamic> showBottom(BuildContext context, Pengurusan pengurusan) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 50,
                  child: ClipOval(
                    child: Image.network(pengurusan.photoURL),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  pengurusan.nama.toString(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
                Text(
                  pengurusan.jawatan.toString().capitalizeByWord(),
                  style: const TextStyle(color: Colors.grey, fontSize: 18),
                ),
                const SizedBox(height: 20),
                const Divider(),
                const SizedBox(height: 20),
                ListTile(
                  title: Text(
                      pengurusan.kawasanQariah.toString().capitalizeByWord()),
                  leading: Icon(
                    Icons.mosque,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
                ListTile(
                  title: Text(pengurusan.email.toString()),
                  leading: Icon(
                    Icons.email,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton.icon(
                      onPressed: () => _homeController.callPengurusan(
                          pengurusan.noPhone.toString(), context),
                      icon: const Icon(Icons.call),
                      label: const Text('Hubungi')),
                ),
                const SizedBox(height: 4),
              ],
            ),
          );
        },
        isScrollControlled: true);
  }
}
