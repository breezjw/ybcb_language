import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:language/controller/auth_controller.dart';

class SplashScreenView extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());

  SplashScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get.put<AuthController>(AuthController());

    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}