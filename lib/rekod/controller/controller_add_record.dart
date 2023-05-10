import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grave_apps/config/haptic_feedback.dart';
import 'package:intl/intl.dart';

class AddRecordController extends GetxController {
  final namaJenazahText = TextEditingController();
  final tempatTinggalText = TextEditingController();
  final tarikhLahirText = TextEditingController();
  final tarikhMeninggalText = TextEditingController();
  final lotKuburText = TextEditingController();
  final lokasiKuburText = TextEditingController();

  DateTime tarikhLahir = DateTime.now();
  DateTime tarikhMeninggal = DateTime.now();

  void tarikhLahirDate(BuildContext context) async {
    Haptic.feedbackClick();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950, 1),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      tarikhLahir = picked;
      tarikhLahirText.text = DateFormat('dd MMMM yyyy').format(tarikhLahir);
      update();
      Haptic.feedbackSuccess();
    }
  }

  void tarikhMeninggalDate(BuildContext context) async {
    Haptic.feedbackClick();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950, 1),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      tarikhMeninggal = picked;
      tarikhMeninggalText.text =
          DateFormat('dd MMMM yyyy').format(tarikhMeninggal);
      update();
      Haptic.feedbackSuccess();
    }
  }
}
