import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grave_apps/config/toast_view.dart';
import 'package:grave_apps/home/model/pengurusan_model.dart';
import 'package:path/path.dart' as p;
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
  String fileExtension = '';

  var fileName = ''.obs;
  Uint8List webImage = Uint8List(10);
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

  void chooseImage(BuildContext context) async {
    Haptic.feedbackClick();
    final file = await _pickImage(context, (file) => _cropSquareImage(file));

    if (file == null) return;
    imageFile = File(file.path);
    update();
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

          final resultImage =
              await Get.to<Uint8List>(() => CropWeb(image: data));
          if (resultImage == null) {
            debugPrint('kesalahan pada gambar');
            return;
          } else {
            fileName.value = webFile?.name ?? 'profile_picture.png';
            fileExtension = p.extension(fileName.value);
            webImage = resultImage;
            update();
          }
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

  void confirmationAdd(BuildContext context) {
    if (formKey.currentState!.validate()) {
      if (fileName.value == '') {
        Get.dialog(
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
            child: AlertDialog(
              icon: const Icon(Icons.portrait),
              title: const Text('Gambar Profil'),
              content: const Text(
                  'Sila muat naik gambar profil pengurusan untuk teruskan'),
              actions: [
                TextButton(
                  onPressed: () {
                    Haptic.feedbackClick();
                    Get.back();
                    if (GetPlatform.isWeb) {
                      chooseImageWeb(context);
                    } else {
                      chooseImage(context);
                    }
                  },
                  child: const Text('Muat naik'),
                ),
              ],
            ),
          ),
        );
      } else {
        Get.dialog(
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
            child: AlertDialog(
              icon: const Icon(Icons.person_add),
              title: const Text('Adakah anda pasti?'),
              content: const Text(
                  'Pastikan semua maklumat pengurusan adalah tepat!'),
              actions: [
                TextButton(
                  onPressed: () {
                    Haptic.feedbackError();
                    Get.back();
                  },
                  child: const Text('Batal'),
                ),
                TextButton(
                  onPressed: () async {
                    Get.back();
                    Get.dialog(
                      BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                        child: AlertDialog(
                          icon: const Icon(Icons.person_add),
                          content: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Text('Memuat naik data...'),
                              SizedBox(height: 10),
                              CircularProgressIndicator.adaptive(),
                            ],
                          ),
                        ),
                      ),
                    );
                    final success = await _addUser(context);

                    if (success == true && context.mounted) {
                      ToastView.success(context,
                          title: 'Operasi selesai',
                          subtitle:
                              'Pengurusan telah ditambah ke pangkalan data',
                          icon: Icons.person_add);
                      Get.back();
                      Get.back();
                    }
                  },
                  child: const Text('Pasti'),
                ),
              ],
            ),
          ),
        );
      }
    }
  }

  Future<bool> _addUser(BuildContext context) async {
    try {
      const password = 'Admin123';
      String url = '';

      // 1. Creating User
      final app = await Firebase.initializeApp(
          name: 'Secondary', options: Firebase.app().options);

      final credential = await FirebaseAuth.instanceFor(app: app)
          .createUserWithEmailAndPassword(
              email: emailText.text.trim(), password: password);

      final uid = credential.user!.uid.toString();

      final profileRef = FirebaseStorage.instance
          .ref('profilePhoto/pengurus/$uid$fileExtension');

      // 2. Upload user photo to firebase database
      TaskSnapshot upload;

      if (GetPlatform.isWeb) {
        upload = await profileRef.putData(webImage);
      } else {
        upload = await profileRef.putFile(imageFile);
      }
      url = await upload.ref.getDownloadURL();

      debugPrint(url);

      // 3. Upload user information into Firebase Realtime Database
      final pengurusan = Pengurusan(
        email: emailText.text.trim(),
        jawatan: jawatanPengurusanText.text.trim(),
        kawasanQariah: kawasanQaryahText.text.trim(),
        nama: namaText.text.trim(),
        noPhone: int.parse(noPhoneText.text.trim()),
        photoURL: url,
      );

      final realtime = pengurusan.toRealtime();
      await FirebaseFirestore.instance
          .collection('pengurusan')
          .doc(uid)
          .set(realtime);
      // 4. Customize user profile
      credential.user!.updateDisplayName(namaText.text);
      credential.user!.updatePhotoURL(url);

      app.delete();
      debugPrint('laala');
      return true;
    } on Exception catch (e) {
      ToastView.error(
        context,
        title: 'Kesalah telah berlaku',
        subtitle: 'Kesalahan: $e',
        icon: Icons.error,
      );
      Get.back();
      return false;
    }
  }

  Future<CroppedFile?> _pickImage(BuildContext context,
      Future<CroppedFile?> Function(CroppedFile file) cropImage) async {
    try {
      final pickImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);

      if (pickImage == null) return null;

      final file = CroppedFile(pickImage.path);
      fileName.value = pickImage.name;
      fileExtension = p.extension(fileName.value);
      debugPrint(fileExtension);

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

  Future<CroppedFile?> _cropSquareImage(CroppedFile imageFile) async =>
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
          AndroidUiSettings(
            toolbarTitle: 'Sunting Gambar',
            toolbarColor: Get.theme.primaryColor,
            toolbarWidgetColor: Colors.white,
          ),
        ],
      );
}
