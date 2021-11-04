import 'package:get/get.dart';
import 'package:language/view/content_card_list_view.dart';
import 'package:language/view/login_view.dart';
import 'package:language/view/main_view.dart';
import 'package:language/view/splash_view.dart';

class AppRoutes {
  static final routes = [
    GetPage(
      name: '/splash',
      page: () => SplashScreenView(),
    ),
    GetPage(
      name: '/login',
      page: () => LoginView(),
    ),
    GetPage(
      name: '/',
      page: () => MainView(),
    ),
  ];
}