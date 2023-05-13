import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grave_apps/config/routes.dart';
import 'package:grave_apps/home/controller/search_controller.dart';
import 'package:card_swiper/card_swiper.dart';
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
                    Swiper(
                      itemCount: _controller.jenazah.length,
                      itemBuilder: (BuildContext context, int index) {
                        return _controller.cards()[index];
                      },
                      layout: SwiperLayout.TINDER,
                      itemWidth: 500,
                      itemHeight: 380,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Berikut adalah 5 senarai rekod  jenazah yang baru dikebumikan',
                      style: TextStyle(color: Colors.grey),
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
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
