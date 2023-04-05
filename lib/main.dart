import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:get/get.dart';
import 'package:grave_apps/home_controller.dart';
import 'package:grave_apps/scroll_config.dart';
import 'package:grave_apps/theme.dart';

Future<void> main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: MyTheme().lightTheme(Theme.of(context).colorScheme),
      scrollBehavior: MyCustomScrollBehavior(),
      home: Home(controller: _controller),
    );
  }
}

class Home extends StatelessWidget {
  const Home({
    super.key,
    required HomeController controller,
  }) : _controller = controller;

  final HomeController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            title: const Text('E-Grave Lot'),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.person),
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
                      SizedBox(
                        width: 700,
                        child: TextField(
                          controller: _controller.searchInput,
                          decoration: const InputDecoration(
                            hintText: 'Cari nama..',
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        height: 400,
                        width: 700,
                        child: CardSwiper(
                          cardsCount: _controller.cards.length,
                          isHorizontalSwipingEnabled: false,
                          numberOfCardsDisplayed: 3,
                          cardBuilder: (context, index) {
                            return _controller.cards[index];
                          },
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class KadArwah extends StatelessWidget {
  final String nama;
  final String alamat;
  final String tarikhLahir;
  final String tarikhMeninggal;
  final String lotKubur;
  final String nota;
  const KadArwah({
    super.key,
    required this.nama,
    required this.alamat,
    required this.tarikhLahir,
    required this.tarikhMeninggal,
    required this.lotKubur,
    required this.nota,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      // height: 400,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 3,
            blurRadius: 5,
            offset: const Offset(0, 9), // changes position of shadow
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.blue,
                ),
                const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      nama,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      alamat,
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text.rich(
              TextSpan(
                text: 'Tarikh Lahir: ',
                children: [
                  TextSpan(
                      text: tarikhLahir,
                      style: const TextStyle(color: Colors.grey)),
                ],
              ),
            ),
            const SizedBox(height: 5),
            Text.rich(
              TextSpan(
                text: 'Tarikh Meninggal: ',
                children: [
                  TextSpan(
                      text: tarikhMeninggal,
                      style: const TextStyle(color: Colors.grey)),
                ],
              ),
            ),
            const SizedBox(height: 5),
            Text.rich(
              TextSpan(
                text: 'Tempat Tinggal: ',
                children: [
                  TextSpan(
                      text: alamat, style: const TextStyle(color: Colors.grey)),
                ],
              ),
            ),
            const SizedBox(height: 5),
            Text.rich(
              TextSpan(
                text: 'Lot Kubur: ',
                children: [
                  TextSpan(
                      text: lotKubur,
                      style: const TextStyle(color: Colors.grey)),
                ],
              ),
            ),
            const SizedBox(height: 5),
            Text.rich(
              TextSpan(
                text: 'Nota: ',
                children: [
                  TextSpan(
                    text: nota,
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Center(
              child: SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.location_on),
                  label: const Text(
                    'Lokasi',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
