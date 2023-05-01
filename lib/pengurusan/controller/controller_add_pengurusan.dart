import 'dart:ui';

import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grave_apps/config/toast_view.dart';
import 'package:image_picker/image_picker.dart';

import '../../config/haptic_feedback.dart';

class ControllerAddPengurusan extends GetxController {
  final namaText = TextEditingController();
  final noPhoneText = TextEditingController();
  final kawasanQaryahText = TextEditingController();
  final jawatanPengurusanText = TextEditingController();
  final emailText = TextEditingController();
  final formKey = GlobalKey<FormState>();

  String? errorNama;
  String? errorNoPhone;
  String? errorKawasanQaryah;
  String? errorJawatan;
  String? errorEmail;

  final imagePicker = ImagePicker();
  var imageLoc = ''.obs;
  var imagePath = ''.obs;

  @override
  void onReady() {
    super.onReady();

    var user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      Get.dialog(
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
            child: AlertDialog(
              icon: const Icon(Icons.warning),
              title: const Text('Amaran'),
              content: const Text(
                  'Whoopsie anda bukan pengurusan! Halaman ini hanya untuk pengguna pengurusan atau ahli Qariah sahaja!'),
              actions: [
                TextButton(
                  onPressed: () {
                    Haptic.feedbackError();
                    Get.back();
                    Get.back();
                  },
                  child: const Text('Keluar'),
                ),
              ],
            ),
          ),
          barrierDismissible: false);
    } else {
      debugPrint('looks good!');
    }
  }

  bool checkEmail(String email) {
    return EmailValidator.validate(email);
  }

  void pickImage(BuildContext context) async {
    try {
      final XFile? image =
          await imagePicker.pickImage(source: ImageSource.gallery);

      if (image == null) {
        imageLoc.value = '';
        imagePath.value = '';
        return;
      }
      imageLoc.value = image.name.toString();
      imagePath.value = image.path.toString();
    } on Exception catch (e) {
      imageLoc.value = '';
      imagePath.value = '';
      ToastView.error(context,
          title: 'Kesalahan Telah Berlaku',
          subtitle: 'Kesalahan: $e',
          icon: Icons.error);
    }
  }

  void confirmationAdd() {
    if (formKey.currentState!.validate()) {
      Get.dialog(
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
          child: AlertDialog(
            icon: const Icon(Icons.person_add),
            title: const Text('Adakah anda pasti?'),
            content:
                const Text('Pastikan semua maklumat pengurusan adalah tepat!'),
            actions: [
              TextButton(
                onPressed: () {
                  Haptic.feedbackError();
                  Get.back();
                },
                child: const Text('Batal'),
              ),
              TextButton(
                onPressed: () {},
                child: const Text('Pasti'),
              ),
            ],
          ),
        ),
      );
    }
  }
}
