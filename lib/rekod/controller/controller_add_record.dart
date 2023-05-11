import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:grave_apps/config/haptic_feedback.dart';
import 'package:grave_apps/config/request_ui.dart';
import 'package:grave_apps/config/toast_view.dart';
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

  void chooseLocation(BuildContext context) {
    Haptic.feedbackClick();
    Get.dialog(
      BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: AlertDialog(
          icon: const Icon(Icons.location_on),
          title: const Text('Pilih kaedah untuk mendapatkan lokasi kubur'),
          actions: [
            ListTile(
              title: const Text('GPS'),
              leading: const Icon(Icons.gps_fixed),
              onTap: () => _requestLocation(context),
            ),
          ],
        ),
      ),
    );
  }

  void _requestLocation(BuildContext context) async {
    Get.back();
    var permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      LocationPermission result = await RequestUI().requestLocation();

      if (result == LocationPermission.always ||
          result == LocationPermission.whileInUse) {
        if (context.mounted) {
          ToastView.success(context,
              title: 'Operasi Selesai!',
              subtitle: 'Permintaan lokasi berjaya!',
              icon: Icons.location_on);
        }
        _getGpsLocation();
      }
    } else if (permission == LocationPermission.deniedForever) {
      if (context.mounted) {
        ToastView.error(context,
            title: 'Operasi Gagal!',
            subtitle:
                'Gagal untuk meminta lokasi daripada peranti anda! Sila pastikan anda telah berikan keizinan daripada aplikasi ini untuk menggunakan lokasi pada tetapan peranti',
            icon: Icons.location_on);
      }
    } else {
      _getGpsLocation();
    }
  }

  void _getGpsLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    lokasiKuburText.text =
        'Lat: ${position.latitude}\nLong: ${position.longitude}';
  }
}
