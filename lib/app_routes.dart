import 'package:get/get.dart';
import 'package:language/view/content_card_list.dart';
import 'package:language/view/login_page.dart';

class AppRoutes {
  static final routes = [
    GetPage(
      name: '/login',
      page: () => LoginPage(),
    ),
    GetPage(
      name: '/',
      page: () => ContentCardList(),
    ),
  ];
}