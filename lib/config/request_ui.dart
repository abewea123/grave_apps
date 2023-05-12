import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:grave_apps/config/toast_view.dart';
import 'package:lottie/lottie.dart';

class RequestUI {
  static Future<LocationPermission> requestLocation(
      BuildContext context) async {
    var permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      await Get.bottomSheet(
        Material(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LottieBuilder.asset(
                    'assets/lottie/location_permission.json',
                    width: 150,
                    height: 150,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Aplikasi ini memerlukan keizinan lokasi daripada peranti anda. Sila pilih dan aktifkan keizinan tepat (\'Precise Location\') untuk mendapatkan lokasi yang lebih baik',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        try {
                          LocationPermission request =
                              await Geolocator.requestPermission();

                          debugPrint(request.name);

                          if (request == LocationPermission.always ||
                              request == LocationPermission.whileInUse) {
                            Get.back();
                            permission = request;
                          }
                        } on Exception catch (e) {
                          Get.back();
                          ToastView.error(context,
                              title: 'Kesalahan telah berlaku!',
                              subtitle: 'Kesalahan: $e',
                              icon: Icons.location_off);
                        }
                      },
                      child: const Text('Benarkan Lokasi'),
                    ),
                  ),
                  const SizedBox(height: 30)
                ],
              ),
            ),
          ),
        ),
        isScrollControlled: true,
      );
    }
    return permission;
  }
}
