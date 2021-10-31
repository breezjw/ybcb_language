import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:language/app_routes.dart';
import 'package:language/controller/auth_controller.dart';
import 'package:easy_localization/easy_localization.dart';

final supportedLocales = [
  const Locale('en', 'US'),
  const Locale('ko', 'KR')
];

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await EasyLocalization.ensureInitialized();

  //Get.testMode = true;

  runApp(
    EasyLocalization(
      supportedLocales: supportedLocales,
      path: 'assets/translations',
      fallbackLocale: const Locale('en', 'US'),
      child: MyApp()
    )

  );
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  //
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      initialRoute: "/splash",
      getPages: AppRoutes.routes,
      navigatorKey: Get.key,
    );
  }
}