import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travelguide/repositories/authentication/auth_repo.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  final email = TextEditingController();
  final password = TextEditingController();
  final fullname = TextEditingController();
  final phone = TextEditingController();

  void registerUser(
      String email, String password, String fullname, String phone) {
    AuthenticationRepository.instance
        .createUserWithEmailAndPassword(email, password, fullname, phone);
  }
}
