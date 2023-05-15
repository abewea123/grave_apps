import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grave_apps/home/model/jenazah_model.dart';
import 'package:intl/intl.dart';
import 'package:maps_launcher/maps_launcher.dart';

class ViewDetailsRecord extends StatelessWidget {
  ViewDetailsRecord({super.key});

  final _params = Get.parameters;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('jenazah')
              .doc(_params['uid'])
              .snapshots(),
          builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator.adaptive(),
                  SizedBox(height: 10),
                  Text('Memuatkan data...')
                ],
              );
            }

            if (snapshot.hasData) {
              Jenazah jenazah = Jenazah.fromFirestore(snapshot.data);
              TextEditingController jenazahText =
                  TextEditingController(text: jenazah.nama);
              TextEditingController tempatTinggalText =
                  TextEditingController(text: jenazah.tempatTinggal);
              TextEditingController tarikhLahirText = TextEditingController(
                  text: DateFormat('dd MMMM yyyy').format(jenazah.tarikhLahir));
              TextEditingController tarikhMeninggalText = TextEditingController(
                  text: DateFormat('dd MMMM yyyy')
                      .format(jenazah.tarikhMeninggal));
              TextEditingController lotKuburText =
                  TextEditingController(text: jenazah.lotKubur);
              TextEditingController notesText =
                  TextEditingController(text: jenazah.nota);
              return CustomScrollView(
                slivers: [
                  SliverAppBar.large(
                    title: Text(jenazah.nama),
                    flexibleSpace: Hero(
                      tag: jenazah.id.toString(),
                      child: FlexibleSpaceBar(
                        title: Text(
                          jenazah.nama,
                          style: TextStyle(
                            color: Get.isDarkMode ? Colors.white : Colors.black,
                          ),
                        ),
                        background: Stack(
                          fit: StackFit.expand,
                          children: [
                            Image.network(
                              jenazah.gambarKubur,
                              fit: BoxFit.cover,
                              colorBlendMode: BlendMode.darken,
                            ),
                            ClipRRect(
                              child: BackdropFilter(
                                filter:
                                    ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                child: Container(
                                  color: Get.isDarkMode
                                      ? Colors.black54
                                      : Colors.white60,
                                  alignment: Alignment.center,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 13),
                              Column(
                                children: [
                                  Text(
                                    'Maklumat Peribadi',
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 30),
                              TextFormField(
                                controller: jenazahText,
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.name,
                                readOnly: true,
                                decoration: const InputDecoration(
                                  hintText: 'Abdullah',
                                  label: Text('Nama Jenazah'),
                                  icon: Icon(Icons.person),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Sila masukkan nama jenazah';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 20),
                              TextFormField(
                                controller: tempatTinggalText,
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.streetAddress,
                                readOnly: true,
                                decoration: const InputDecoration(
                                  hintText: 'Kota Bahru, Kelantan',
                                  label: Text('Tempat Tinggal'),
                                  icon: Icon(Icons.map),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Sila masukkan tempat tinggal jenazah';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 20),
                              TextFormField(
                                controller: tarikhLahirText,
                                // onTap: () => _controller.tarikhLahirDate(context),
                                textInputAction: TextInputAction.next,
                                readOnly: true,
                                decoration: const InputDecoration(
                                  hintText: '8 April 1998',
                                  label: Text('Tarikh Lahir'),
                                  icon: Icon(Icons.timer),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Sila masukkan tarikh lahir lahir';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 20),
                              TextFormField(
                                controller: tarikhMeninggalText,
                                // onTap: () => _controller.tarikhMeninggalDate(context),
                                textInputAction: TextInputAction.next,
                                readOnly: true,
                                decoration: const InputDecoration(
                                  hintText: '10 May 2023',
                                  label: Text('Tarikh Meninggal'),
                                  icon: Icon(Icons.access_time_filled_rounded),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Sila masukkan tarikh meninggal jenazah';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 20),
                              Text(
                                'Maklumat Kubur',
                                style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 20),
                              TextFormField(
                                controller: lotKuburText,
                                textInputAction: TextInputAction.next,
                                readOnly: true,
                                decoration: const InputDecoration(
                                  hintText: '213',
                                  label: Text('Lot Kubur'),
                                  icon: Icon(Icons.approval_sharp),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Sila masukkan lot kubur jenazah';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 20),
                              TextFormField(
                                controller: notesText,
                                textInputAction: TextInputAction.next,
                                readOnly: true,
                                maxLines: 3,
                                decoration: const InputDecoration(
                                  hintText:
                                      'cth: Waris kepada Mamat, Kubur berdekatan dengan pokok...',
                                  label: Text('Nota'),
                                  icon: Icon(Icons.note),
                                ),
                              ),
                              const SizedBox(height: 30),
                              Align(
                                alignment: Alignment.center,
                                child: SizedBox(
                                  height: 45,
                                  width: 500,
                                  child: ElevatedButton(
                                    onPressed: () =>
                                        MapsLauncher.launchCoordinates(
                                            jenazah.geoPoint.latitude,
                                            jenazah.geoPoint.longitude),
                                    child: const Text('Lokasi kubur'),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 14),
                              Align(
                                alignment: Alignment.center,
                                child: TextButton(
                                  onPressed: () {},
                                  child: const Text('Gambar Kubur'),
                                ),
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
            return const Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text('Uh, Oh.. Kesalahan telah berlaku!')],
            );
          }),
    );
  }
}