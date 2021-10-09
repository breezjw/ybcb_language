import 'package:get/get.dart';
import 'package:language/view/content_card_list.dart';

class AppRoutes {
  static final routes = [
    GetPage(
      name: '/',
      page: () => CardList(),
    ),
  ];
}