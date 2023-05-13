import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grave_apps/config/routes.dart';
import 'package:grave_apps/home/controller/search_controller.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:grave_apps/home/model/jenazah_model.dart';
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
    return CustomScrollView(
      slivers: [
        SliverAppBar.large(
          title: const Text('Laman Utama'),
          actions: [
            IconButton(
              onPressed: () {
                Get.toNamed(MyRoutes.tambahRekod, arguments: {
                  'user': user,
                });
              },
              icon: const Icon(Icons.add),
            ),
          ],
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
                        stream: FirebaseFirestore.instance
                            .collection('jenazah')
                            .snapshots(),
                        builder:
                            (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator.adaptive();
                          }

                          if (snapshot.hasData) {
                            _controller.jenazah = snapshot.data!.docs
                                .map((docs) => Jenazah.fromFirestore(docs))
                                .toList();

                            int length = _controller.jenazah.length;
                            return Column(
                              children: [
                                Swiper(
                                  itemCount: length <= 5 ? length : 5,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return _controller.cards()[index];
                                  },
                                  layout: SwiperLayout.TINDER,
                                  itemWidth: 500,
                                  loop: length == 1 ? false : true,
                                  itemHeight: 380,
                                ),
                                const SizedBox(height: 20),
                                Text(
                                  'Berikut adalah $length senarai rekod  jenazah yang baru dikebumikan',
                                  style: const TextStyle(color: Colors.grey),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 30),
                                SizedBox(
                                  height: 50,
                                  width: 300,
                                  child: ElevatedButton.icon(
                                    onPressed: () {},
                                    icon: const Icon(Icons.list_alt),
                                    label: const Text('Semua Rekod'),
                                  ),
                                ),
                                const SizedBox(height: 20),
                              ],
                            );
                          }
                          return const SizedBox();
                        }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
