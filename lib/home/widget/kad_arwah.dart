import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grave_apps/config/extension.dart';
import 'package:grave_apps/config/routes.dart';
import 'package:intl/intl.dart';

import '../model/jenazah_model.dart';

class KadArwah extends StatelessWidget {
  final Jenazah jenazah;
  const KadArwah({
    super.key,
    required this.jenazah,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.toNamed(MyRoutes.detailsRekod,
          parameters: {'uid': jenazah.id.toString()}),
      borderRadius: BorderRadius.circular(30),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Get.isDarkMode ? Colors.grey.shade900 : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(30),
          image: DecorationImage(
              image: NetworkImage(jenazah.gambarKubur), fit: BoxFit.cover),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            gradient: LinearGradient(
              end: Alignment.topCenter,
              begin: Alignment.bottomCenter,
              colors: [
                Colors.black.withOpacity(0.8),
                Colors.black.withOpacity(0.7),
                Colors.transparent,
              ],
              stops: const [
                0.0,
                0.3,
                0.50,
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(17.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  jenazah.nama.capitalizeByWord(),
                  style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                Text(
                  jenazah.tempatTinggal.capitalizeByWord(),
                  style: const TextStyle(color: Colors.white),
                ),
                Text(
                  '${DateFormat('dd.MM.yyyy').format(jenazah.tarikhLahir)} - ${DateFormat('dd.MM.yyyy').format(jenazah.tarikhMeninggal)}',
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
