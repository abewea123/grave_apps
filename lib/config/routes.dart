import 'package:get/get.dart';
import 'package:grave_apps/home/view_home.dart';
import 'package:grave_apps/login/view/login_view.dart';
import 'package:grave_apps/pengurusan/view/view_add_pengurusan.dart';
import 'package:grave_apps/rekod/view/view_all_record.dart';
import 'package:grave_apps/rekod/view/view_tambah_rekod_jenazah.dart';

class MyRoutes {
  static const home = '/home';
  static const login = '/login';
  static const tambahPengurusan = '/tambah-pengurusan';
  static const tambahRekod = '/tambah-rekod-jenazah';
  static const semuaRekod = '/semua-rekod';

  List<GetPage> page = [
    GetPage(
      name: home,
      page: () => const Home(),
    ),
    GetPage(
      name: login,
      page: () => ViewLogin(),
    ),
    GetPage(
      name: tambahPengurusan,
      page: () => ViewAddPengurusan(),
    ),
    GetPage(
      name: tambahRekod,
      page: () => ViewAddJenazah(),
    ),
    GetPage(
      name: semuaRekod,
      page: () => ViewAllRecord(),
    ),
  ];
}
