import 'dart:ui';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final emailText = TextEditingController();
  final passwordText = TextEditingController();
  var showPassword = true.obs;
  String? errorEmail;
  String? errorPassword;
  String showErrorCode = '';
  final passwordFocus = FocusNode();
  final formKey = GlobalKey<FormState>();
  final _firebaseAuth = FirebaseAuth.instance;

  bool checkEmail(String email) {
    return EmailValidator.validate(email);
  }

  void showingPassword() {
    showPassword.value = !showPassword.value;
  }

  Future<User?> login() async {
    showErrorCode = '';
    errorEmail = null;
    errorPassword = null;
    update();

    if (formKey.currentState!.validate()) {
      Get.dialog(
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
          child: const AlertDialog(
            icon: Icon(Icons.login),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Sila tunggu sebentar...'),
                SizedBox(height: 10),
                CircularProgressIndicator.adaptive(),
              ],
            ),
          ),
        ),
      );
      try {
        var auth = await _firebaseAuth.signInWithEmailAndPassword(
            email: emailText.text.trim(), password: passwordText.text.trim());

        if (auth.user != null) {
          return auth.user;
        }
        return auth.user;
      } on FirebaseAuthException catch (e) {
        debugPrint(e.code);
        Get.back();
        if (e.code == 'user-not-found') {
          errorEmail = 'Email pengguna tidak ditemui!';
          update();
          Get.dialog(
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
              child: AlertDialog(
                icon: const Icon(Icons.person_off_rounded),
                title: const Text('Pengguna tidak ditemui'),
                content: const Text(
                    'Pastikan anda adalah salah seorang pengurusan E-Grave Lot. Sila hubungi kami jika ada sebarang pertanyaan'),
                actions: [
                  TextButton(
                    onPressed: () => Get.back(),
                    child: const Text('Hubungi kami'),
                  ),
                  TextButton(
                    onPressed: () => Get.back(),
                    child: const Text('Tutup'),
                  ),
                ],
              ),
            ),
          );
        } else if (e.code == 'wrong-password') {
          errorPassword = 'Kata laluan salah!';
          update();
        } else {
          showErrorCode = e.message.toString();
          debugPrint(e.message);
        }
      }
    }
    return null;
  }
}
