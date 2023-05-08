import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grave_apps/config/haptic_feedback.dart';
import 'package:grave_apps/config/toast_view.dart';
import 'package:url_launcher/url_launcher.dart';

import '../model/jenazah_model.dart';
import '../widget/kad_arwah.dart';

class HomeController extends GetxController {
  final searchInput = TextEditingController();
  var index = 0.obs;
  var fabScrollPengurusan = true.obs;

  void callPengurusan(String phone, BuildContext context) {
    const code = '+60';
    final noPhone = '$code$phone';
    Haptic.feedbackClick();
    Get.dialog(BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: AlertDialog(
        icon: const Icon(Icons.call),
        title: Text(noPhone),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.call),
              title: const Text('Hubungi'),
              onTap: () => launchCaller(noPhone, context),
            ),
            ListTile(
              leading: const Icon(Icons.message),
              title: const Text('WhatsApp'),
              onTap: () => launchWhatsapp(noPhone, context),
            ),
          ],
        ),
      ),
    ));
  }

  void launchWhatsapp(String noFon, BuildContext context) async {
    Get.back();
    String phone = noFon.contains('+6') ? noFon : '+6$noFon';
    final url = GetPlatform.isAndroid
        ? "whatsapp://send?phone=$phone&text=Salam"
        : "https://wa.me/$phone/?text=Salam";
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      Get.back();
      if (context.mounted) {
        ToastView.error(context,
            title: 'Kesalahan telah berlaku!',
            subtitle: 'Gagal untuk mengakses WhatsApp',
            icon: Icons.close);
      }
    }
  }

  void launchCaller(String noFon, BuildContext context) async {
    Get.back();
    final url = "tel:$noFon";
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      Get.back();
      if (context.mounted) {
        ToastView.error(context,
            title: 'Kesalahan telah berlaku!',
            subtitle: 'Gagal untuk mengakses WhatsApp',
            icon: Icons.close);
      }
    }
  }

  List<Jenazah> jenazah = [
    Jenazah(
      nama: 'Adlan Khayran',
      tempatTinggal: 'Kajang, Selangor',
      lotKubur: '0112',
      nota: '',
      profileImage: '',
      latitude: 0,
      longitude: 0,
      tarikhLahir: DateTime.now(),
      tarikhMeninggal: DateTime.now(),
    ),
    Jenazah(
      nama: 'Ali Bin Abu',
      tempatTinggal: 'Seri Kembangan, Selangor',
      lotKubur: '0113',
      nota: '',
      profileImage: '',
      latitude: 0,
      longitude: 0,
      tarikhLahir: DateTime.now(),
      tarikhMeninggal: DateTime.now(),
    ),
    Jenazah(
      nama: 'Ahmad Albab',
      tempatTinggal: 'Isketambola, Pasir Berdengung',
      lotKubur: '0114',
      nota: 'Arwah kedekut orangnya',
      profileImage: '',
      latitude: 0,
      longitude: 0,
      tarikhLahir: DateTime.now(),
      tarikhMeninggal: DateTime.now(),
    ),
    Jenazah(
      nama: 'Abdullah',
      tempatTinggal: 'Pasir Mas, Kelantan',
      lotKubur: '0115',
      nota: '',
      profileImage: '',
      latitude: 0,
      longitude: 0,
      tarikhLahir: DateTime.now(),
      tarikhMeninggal: DateTime.now(),
    ),
  ];

  List<KadArwah> cards() {
    List<KadArwah> kad = [];

    for (var kadArwah in jenazah) {
      kad.add(
        KadArwah(
          nama: kadArwah.nama,
          alamat: kadArwah.tempatTinggal,
          tarikhLahir: kadArwah.tarikhLahir.toString(),
          tarikhMeninggal: kadArwah.tarikhMeninggal.toString(),
          lotKubur: kadArwah.lotKubur,
          nota: kadArwah.nota,
        ),
      );
    }
    return kad;
  }
}
