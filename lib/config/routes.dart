import 'package:get/get.dart';
import 'package:grave_apps/home/view_home.dart';
import 'package:grave_apps/login/view/login_view.dart';
import 'package:grave_apps/pengurusan/view/view_add_pengurusan.dart';

class MyRoutes {
  static const home = '/home';
  static const login = '/login';
  static const tambahPengurusan = '/tambah-pengurusan';

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
  ];
}
