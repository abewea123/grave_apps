import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:grave_apps/api/geocode_api.dart';
import 'package:grave_apps/config/haptic_feedback.dart';
import 'package:grave_apps/config/request_ui.dart';
import 'package:grave_apps/config/toast_view.dart';
import 'package:intl/intl.dart';
import 'package:grave_apps/rekod/model/geocode_address.dart';
import 'package:path/path.dart' as p;
import 'package:universal_html/html.dart' as html;

class AddRecordController extends GetxController {
  final namaJenazahText = TextEditingController();
  final tempatTinggalText = TextEditingController();
  final tarikhLahirText = TextEditingController();
  final tarikhMeninggalText = TextEditingController();
  final lotKuburText = TextEditingController();
  final lokasiKuburText = TextEditingController();
  final notesText = TextEditingController();

  DateTime tarikhLahir = DateTime.now();
  DateTime tarikhMeninggal = DateTime.now();

  double latitude = 0;
  double longitude = 0;

  File imageFile = File('');
  html.File? webFile;
  var fileName = ''.obs;
  String fileExtension = '';
  Uint8List webImage = Uint8List(10);

  var alamatCode = ''.obs;

  GeocodeAddress? geocode;

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

  void openMap() {
    MapsLauncher.launchCoordinates(latitude, longitude);
  }

  void chooseImageMac(BuildContext context) async {
    try {
      FilePickerResult? picker =
          await FilePicker.platform.pickFiles(type: FileType.image);
      if (picker != null) {
        final String? path = picker.files.single.path;
        final String? extension = picker.files.single.extension;
        if (path != null && extension != null) {
          imageFile = File(path);
          fileName.value = picker.files.single.name;
          fileExtension = extension;
          update();
        }
        update();
      }
    } on Exception catch (e) {
      imageFile = File('');
      fileName.value = '';
      fileExtension = '';
      ToastView.error(context,
          title: 'Kesalahan Telah Berlaku',
          subtitle: 'Kesalahan: $e',
          icon: Icons.error);
      update();
    }
  }

  void chooseImageWeb(BuildContext context) async {
    try {
      html.FileUploadInputElement uploadInput = html.FileUploadInputElement()
        ..accept = 'image/*';
      uploadInput.click();

      uploadInput.onChange.listen((event) {
        webFile = uploadInput.files!.first;
        final reader = html.FileReader();
        reader.readAsDataUrl(webFile!);

        reader.onLoadEnd.listen((event) async {
          Uint8List? data = const Base64Decoder()
              .convert(reader.result.toString().split(",").last);

          fileName.value = webFile?.name ?? 'profile_picture.png';
          fileExtension = p.extension(fileName.value);
          webImage = data;
          update();
        });
      });
    } on Exception catch (e) {
      imageFile = File('');
      fileName.value = '';
      fileExtension = '';
      ToastView.error(context,
          title: 'Kesalahan Telah Berlaku',
          subtitle: 'Kesalahan: $e',
          icon: Icons.error);
      update();
    }
  }

  void chooseImage(BuildContext context) async {
    Haptic.feedbackClick();
    final pick = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pick == null) return;
    imageFile = File(pick.path);
    fileName.value = pick.name;
    fileExtension = p.extension(pick.path);
    update();
  }

  void _requestLocation(BuildContext context) async {
    Get.back();

    var permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      if (context.mounted) {
        Get.dialog(
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: const AlertDialog(
              icon: Icon(Icons.gps_fixed),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Mendapakan lokasi anda...'),
                  SizedBox(height: 20),
                  CircularProgressIndicator.adaptive()
                ],
              ),
            ),
          ),
          barrierDismissible: true,
        );
        LocationPermission result = await RequestUI.requestLocation(context);

        if (result == LocationPermission.always ||
            result == LocationPermission.whileInUse) {
          if (context.mounted) {
            ToastView.success(context,
                title: 'Operasi Selesai!',
                subtitle: 'Permintaan lokasi berjaya!',
                icon: Icons.location_on);
          }
          Get.back();
          _getGpsLocation();
        }
      } else if (permission == LocationPermission.deniedForever ||
          permission == LocationPermission.denied) {
        if (context.mounted) {
          ToastView.error(context,
              title: 'Operasi Gagal!',
              subtitle:
                  'Gagal untuk meminta lokasi daripada peranti anda! Sila pastikan anda telah berikan keizinan daripada aplikasi ini untuk menggunakan lokasi pada tetapan peranti',
              icon: Icons.location_on);
          Get.back();
        }
      } else {
        Get.back();
        _getGpsLocation();
      }
    } else if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      _getGpsLocation();
    }
  }

  void _getGpsLocation() async {
    Get.dialog(
      BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: const AlertDialog(
          icon: Icon(Icons.gps_fixed),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Mendapakan lokasi anda...'),
              SizedBox(height: 20),
              CircularProgressIndicator.adaptive()
            ],
          ),
        ),
      ),
      barrierDismissible: true,
    );
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    latitude = position.latitude;
    longitude = position.longitude;

    lokasiKuburText.text = 'Lat: $latitude\nLong: $longitude';

    debugPrint('latitude: $latitude');
    debugPrint('longitude: $longitude');

    Response response = await GeocodeAPI().getAddress(latitude, longitude);

    debugPrint('${response.status.code}');

    // debugPrint(response.body['display_name']);
    if (response.isOk) {
      Map<String, dynamic> data = jsonDecode(response.bodyString.toString());

      alamatCode.value = data['display_name'].toString();
      update();
      Get.back();
    }
  }
}
