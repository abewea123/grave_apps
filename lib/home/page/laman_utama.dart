import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:grave_apps/config/routes.dart';
import 'package:grave_apps/home/controller/search_controller.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:grave_apps/home/model/jenazah_model.dart';
import '../../config/haptic_feedback.dart';
import '../controller/home_controller.dart';

class LamanUtamaView extends StatelessWidget {
  final User? user;
  const LamanUtamaView({
    super.key,
    required HomeController controller,
    required this.user,
  }) : _controller = controller;

  final HomeController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NotificationListener<UserScrollNotification>(
        onNotification: (noti) {
          if (noti.direction == ScrollDirection.forward) {
            _controller.fabScrollLamanUtama.value = true;
          } else if (noti.direction == ScrollDirection.reverse) {
            _controller.fabScrollLamanUtama.value = false;
          }
          return true;
        },
        child: CustomScrollView(
          slivers: [
            SliverAppBar.large(
              title: const Text('Laman Utama'),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            showSearch(
                              context: context,
                              delegate: CariJenazah(),
                            );
                          },
                          child: SizedBox(
                            width: 700,
                            height: 60,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Get.isDarkMode
                                    ? Colors.grey.shade900
                                    : Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(20.0),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Cari nama jenazah..',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                            stream: _controller.rekodJenazah,
                            builder: (context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 2,
                                  child: const Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      CircularProgressIndicator.adaptive(),
                                      SizedBox(height: 10),
                                      Text('Memuatkan data...'),
                                    ],
                                  ),
                                );
                              }

                              if (snapshot.hasData) {
                                _controller.jenazah = snapshot.data!.docs
                                    .map((docs) => Jenazah.fromFirestore(docs))
                                    .toList();

                                int length = _controller.jenazah.length;
                                return _content(length);
                              }
                              return _content(_controller.jenazah.length);
                            }),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Obx(() => FloatingActionButton.extended(
            onPressed: () {
              Haptic.feedbackClick();
              Get.toNamed(MyRoutes.semuaRekod);
            },
            label: const Text('Semua Rekod'),
            icon: const Icon(Icons.list_alt),
            isExtended: _controller.fabScrollLamanUtama.value,
            heroTag: null,
          )),
    );
  }

  Column _content(int length) {
    return Column(
      children: [
        Swiper(
          itemCount: length <= 5 ? length : 5,
          itemBuilder: (BuildContext context, int index) {
            return _controller.cards()[index];
          },
          layout: SwiperLayout.TINDER,
          itemWidth: 400,
          loop: false,
          itemHeight: 300,
        ),
        const SizedBox(height: 20),
        Text(
          'Berikut adalah $length senarai rekod  jenazah yang baru dikebumikan',
          style: const TextStyle(color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 10),
        const Text(
          'كُلُّ نَفْسٍ ذَاۤىِٕقَةُ الْمَوْتِۗ ثُمَّ اِلَيْنَا تُرْجَعُوْنَ',
          style: TextStyle(color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 50),
      ],
    );
  }
}
