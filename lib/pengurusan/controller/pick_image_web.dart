import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:universal_html/html.dart';

class PickImageWeb extends GetxController {
  File? file;
  Uint8List? image;
  RxBool isSelected = false.obs;

  Future<Uint8List> getImage() async {
    Uint8List gambar = Uint8List(0);
    FileUploadInputElement uploadInput = FileUploadInputElement()
      ..accept = 'image/*';
    uploadInput.click();

    uploadInput.onChange.listen((event) {
      file = uploadInput.files!.first;
      final reader = FileReader();
      reader.readAsDataUrl(file!);

      reader.onLoadEnd.listen((event) {
        Uint8List data = const Base64Decoder()
            .convert(reader.result.toString().split(",").last);
        image = data;
        gambar = data;
        isSelected(true);
      });
    });
    return gambar;
  }
}
