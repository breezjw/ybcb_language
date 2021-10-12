import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';
import 'package:language/service/fireauth/auth_service.dart';

enum SignInType { EMAIL_PASSWORD, GOOGLE }

class AuthController extends GetxController {

  Logger logger = Logger();

  static AuthController to = Get.find();
  RxBool isLogged = false.obs;
  TextEditingController? emailController;
  TextEditingController? passwordController;
  AuthService? _authService;
  Rxn<User> user = Rxn<User>();

  AuthController() {
    _authService = AuthService();
    _authService?.onAuthChanged().listen((event) {
      logger.d("onAuthChanged");
      logger.d("${user.value}");
      isLogged.value = event != null;
      user.value = event;
    });
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }


  @override
  void onInit() async {
    ever(isLogged, handleAuthChanged);
    user.value = await _authService?.getCurrentUser();
    isLogged.value = user.value != null;

    logger.d("$user");

    super.onInit();
  }

  handleAuthChanged(isLoggedIn) {
    if (isLoggedIn == false) {
      logger.d("Go /login");
      Get.offAllNamed("/login");
    } else {
      logger.d("Go /");
      Get.offAllNamed("/");
    }
  }

  handleSignIn(SignInType type) async {
    if (type == SignInType.EMAIL_PASSWORD) {
      if (emailController?.text == "" || passwordController?.text == "") {
        Get.snackbar(
          "Error",
          "Empty email or password",
        );
        return;
      }
    }

    Get.snackbar("Signing In", "Loading",
        showProgressIndicator: true,
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(minutes: 2));
    try {
      if (type == SignInType.GOOGLE) {
        await _authService?.signInWithGoogle();
        Get.offAllNamed("/");
      }
    } on Exception catch (_, e) {
      Get.back();
      Get.defaultDialog(title: "Error", middleText: e.toString(), actions: [
        FlatButton(
          onPressed: () {
            Get.back();
          },
          child: Text("Close"),
        ),
      ]);
      logger.e(e);
    }
  }
}