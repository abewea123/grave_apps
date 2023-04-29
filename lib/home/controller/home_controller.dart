import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/jenazah_model.dart';
import '../widget/kad_arwah.dart';

class HomeController extends GetxController {
  final searchInput = TextEditingController();
  var index = 0.obs;

  List<Jenazah> jenazah = [
    Jenazah(
      nama: 'Adlan Khayran',
      tempatTinggal: 'Kajang, Selangor',
      lotKubur: '0112',
      nota: '',
      profileImage: '',
      latitude: 0,
      longitude: 0,
      tarikhLahir: DateTime.now(),
      tarikhMeninggal: DateTime.now(),
    ),
    Jenazah(
      nama: 'Ali Bin Abu',
      tempatTinggal: 'Seri Kembangan, Selangor',
      lotKubur: '0113',
      nota: '',
      profileImage: '',
      latitude: 0,
      longitude: 0,
      tarikhLahir: DateTime.now(),
      tarikhMeninggal: DateTime.now(),
    ),
    Jenazah(
      nama: 'Ahmad Albab',
      tempatTinggal: 'Isketambola, Pasir Berdengung',
      lotKubur: '0114',
      nota: 'Arwah kedekut orangnya',
      profileImage: '',
      latitude: 0,
      longitude: 0,
      tarikhLahir: DateTime.now(),
      tarikhMeninggal: DateTime.now(),
    ),
    Jenazah(
      nama: 'Abdullah',
      tempatTinggal: 'Pasir Mas, Kelantan',
      lotKubur: '0115',
      nota: '',
      profileImage: '',
      latitude: 0,
      longitude: 0,
      tarikhLahir: DateTime.now(),
      tarikhMeninggal: DateTime.now(),
    ),
  ];

  List<KadArwah> cards() {
    List<KadArwah> kad = [];

    for (var kadArwah in jenazah) {
      kad.add(
        KadArwah(
          nama: kadArwah.nama,
          alamat: kadArwah.tempatTinggal,
          tarikhLahir: kadArwah.tarikhLahir.toString(),
          tarikhMeninggal: kadArwah.tarikhMeninggal.toString(),
          lotKubur: kadArwah.lotKubur,
          nota: kadArwah.nota,
        ),
      );
    }
    return kad;
  }
}
