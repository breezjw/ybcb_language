import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:language/view/content_card_list_view.dart';
import 'package:language/view/main_view.dart';
import 'package:logger/logger.dart';
import 'package:language/service/fireauth/auth_service.dart';

enum SignInType { EMAIL_PASSWORD, GOOGLE }

class AuthController extends GetxController {

  Logger logger = Logger();

  static AuthController to = Get.find();
  //RxBool isLogged = false.obs;
  TextEditingController? emailController;
  TextEditingController? passwordController;
  AuthService? _authService;
  Rxn<User> user = Rxn<User>();

  AuthController() {
    _authService = AuthService();
  }


  @override
  void onReady() async {

    logger.d("onInit");
    ever(user, handleAuthChanged);
    user.value = _authService?.getCurrentUser();

    user.bindStream(_authService!.onAuthChanged());
    emailController = TextEditingController();
    passwordController = TextEditingController();

    logger.d("$user");

    super.onReady();
  }

  handleAuthChanged(user) {
    logger.d("handleAuthChanged");
    if (user == null) {
      logger.d("Go /login");
      Get.offAllNamed("/login");
    } else {
      logger.d("Go /");
      Get.offAll(MainView());
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

  handleSignOut() {
    _authService?.signOut();
  }
}