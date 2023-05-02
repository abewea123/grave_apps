import 'dart:typed_data';

import 'package:crop_image/crop_image.dart';
import 'package:flutter/material.dart';

class CropWeb extends StatelessWidget {
  final Uint8List? image;
  const CropWeb({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sunting Gambar'),
      ),
      body: Center(
        child: CropImage(
          image: Image.memory(image!),
        ),
      ),
    );
  }
}
