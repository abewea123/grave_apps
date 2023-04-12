import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widget/kad_arwah.dart';

class HomeController extends GetxController {
  final searchInput = TextEditingController();
  var index = 0.obs;

  List<KadArwah> cards = const [
    KadArwah(
      nama: 'Adlan Khayran',
      alamat: 'Kajang, Selangor',
      tarikhLahir: '04/05/1998',
      tarikhMeninggal: '01/12/20xx',
      lotKubur: '0112',
      nota: '',
    ),
    KadArwah(
      nama: 'Ali Bin Abu',
      alamat: 'Seri Kembangan, Selangor',
      tarikhLahir: '04/11/2001',
      tarikhMeninggal: '01/12/20xx',
      lotKubur: '0113',
      nota: '',
    ),
    KadArwah(
      nama: 'Ahmad Albab',
      alamat: 'Isketambola, Pasir Berdegung',
      tarikhLahir: '04/05/1978',
      tarikhMeninggal: '01/01/20xx',
      lotKubur: '0114',
      nota: 'Arwah kedekut orangnya',
    ),
    KadArwah(
      nama: 'Abdullah',
      alamat: 'Pasir Mas, Kelantan',
      tarikhLahir: '04/05/1950',
      tarikhMeninggal: '01/12/20xx',
      lotKubur: '01111',
      nota: '',
    ),
  ];
}
