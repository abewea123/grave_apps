import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:get/get.dart';
import 'package:grave_apps/home/controller/search_controller.dart';

import '../controller/home_controller.dart';

class LamanUtamaView extends StatelessWidget {
  const LamanUtamaView({
    super.key,
    required HomeController controller,
  }) : _controller = controller;

  final HomeController _controller;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
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
                    Stack(
                      alignment: AlignmentDirectional.topStart,
                      children: [
                        const Positioned.fill(
                          top: 300,
                          bottom: 0,
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Berikut adalah nama jenazah yang baru dikebumikan',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          child: SizedBox(
                            height: 400,
                            width: 700,
                            child: CardSwiper(
                              cardsCount: _controller.cards().length,
                              isHorizontalSwipingEnabled: false,
                              isVerticalSwipingEnabled: true,
                              numberOfCardsDisplayed: 3,
                              cardBuilder: (context, index) {
                                return _controller.cards()[index];
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 590),
                      ],
                    ),
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
