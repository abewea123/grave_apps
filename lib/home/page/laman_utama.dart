import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';

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
                    SizedBox(
                      width: 700,
                      child: TextField(
                        controller: _controller.searchInput,
                        decoration: const InputDecoration(
                          hintText: 'Cari nama jenazah',
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
                              cardsCount: _controller.cards.length,
                              isHorizontalSwipingEnabled: false,
                              isVerticalSwipingEnabled: true,
                              numberOfCardsDisplayed: 3,
                              cardBuilder: (context, index) {
                                return _controller.cards[index];
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
