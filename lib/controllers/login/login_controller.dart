import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travelguide/repositories/authentication/auth_repo.dart';

class LoginController extends GetxController {
  final email = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final hidePassword = true.obs;

  Future<void> emailAndPasswordSignIn() async {
    try {
      if (!loginFormKey.currentState!.validate()) {
        return;
      }

      await AuthenticationRepository.instance
          .loginWithEmailAndPassword(email.text.trim(), password.text.trim());
    } catch (e) {
      print('Login failed - $e');
      // Handle the error here
    }
  }
}
