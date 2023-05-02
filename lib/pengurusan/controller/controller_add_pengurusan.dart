import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grave_apps/config/toast_view.dart';
import 'package:grave_apps/pengurusan/controller/pick_image_web.dart';
import 'package:grave_apps/pengurusan/view/crop_web.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:universal_html/html.dart' as html;
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
  File imageFile = File('');
  html.File? webFile;

  var fileName = ''.obs;
  Uint8List webImage = Uint8List(10);

  void chooseImage(BuildContext context) async {
    Haptic.feedbackClick();
    final file =
        await _pickImage(context, (file) => _cropSquareImage(file, context));

    if (file == null) return;
    imageFile = File(file.path);
    update();
  }

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

  Future<CroppedFile?> _pickImage(BuildContext context,
      Future<CroppedFile?> Function(CroppedFile file) cropImage) async {
    try {
      if (GetPlatform.isWeb) {
        html.FileUploadInputElement uploadInput = html.FileUploadInputElement()
          ..accept = 'image/*';
        uploadInput.click();

        uploadInput.onChange.listen((event) {
          webFile = uploadInput.files!.first;
          final reader = html.FileReader();
          reader.readAsDataUrl(webFile!);

          reader.onLoadEnd.listen((event) {
            Uint8List data = const Base64Decoder()
                .convert(reader.result.toString().split(",").last);
            Get.to(CropWeb(image: data));
          });
        });
        return null;
      }

      final pickImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);

      if (pickImage == null) return null;

      final file = CroppedFile(pickImage.path);
      fileName.value = pickImage.name;

      return cropImage(file);
    } on Exception catch (e) {
      imageFile = File('');
      ToastView.error(context,
          title: 'Kesalahan Telah Berlaku',
          subtitle: 'Kesalahan: $e',
          icon: Icons.error);
      update();
      return null;
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

  Future<CroppedFile?> _cropSquareImage(
          CroppedFile imageFile, BuildContext context) async =>
      await ImageCropper().cropImage(
        sourcePath: imageFile.path,
        aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
        aspectRatioPresets: [
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.square
        ],
        compressQuality: 70,
        compressFormat: ImageCompressFormat.jpg,
        uiSettings: [
          _androidUiCrop(),
          _webUiCrop(context),
        ],
      );
  WebUiSettings _webUiCrop(BuildContext context) => WebUiSettings(
        context: context,
        enableResize: true,
        enableZoom: true,
        boundary: const CroppieBoundary(width: 350, height: 350),
        viewPort: const CroppieViewPort(width: 350, height: 350),
      );

  AndroidUiSettings _androidUiCrop() => AndroidUiSettings(
        toolbarTitle: 'Sunting Gambar',
        toolbarColor: Get.theme.primaryColor,
        toolbarWidgetColor: Colors.white,
      );
}
