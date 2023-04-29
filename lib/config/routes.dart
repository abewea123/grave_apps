import 'package:get/get.dart';
import 'package:grave_apps/home/view_home.dart';
import 'package:grave_apps/login/view/login_view.dart';

class MyRoutes {
  static const home = '/home';
  static const login = '/login';

  List<GetPage> page = [
    GetPage(
      name: home,
      page: () => const Home(),
    ),
    GetPage(
      name: login,
      page: () => ViewLogin(),
    ),
  ];
}
