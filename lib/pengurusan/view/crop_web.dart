import 'dart:typed_data';
import 'dart:ui';

import 'package:crop_image/crop_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CropWeb extends StatefulWidget {
  final Uint8List? image;
  const CropWeb({super.key, required this.image});

  @override
  State<CropWeb> createState() => _CropWebState();
}

class _CropWebState extends State<CropWeb> {
  final _cropController = CropController(
    aspectRatio: 1,
    defaultCrop: const Rect.fromLTRB(0.05, 0.05, 0.95, 0.95),
  );

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final result = await Get.dialog<bool>(AlertDialog(
          title: const Text('Keluar?'),
          content: const Text(
              'Segala perubahan akan dipadam. Adakah anda ingin keluar?'),
          actions: [
            TextButton(
              onPressed: () => Get.back(result: false),
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () => Get.back(result: true),
              child: const Text('Keluar'),
            ),
          ],
        ));
        return result ?? false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Sunting Gambar'),
          actions: [
            IconButton(
              onPressed: () async {
                Get.dialog(
                  BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                    child: AlertDialog(
                      content: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Text('Menyediakan gambar...'),
                          SizedBox(height: 10),
                          CircularProgressIndicator.adaptive()
                        ],
                      ),
                    ),
                  ),
                  barrierDismissible: false,
                );
                await Future.delayed(const Duration(seconds: 1));
                final bitmap = await _cropController.croppedBitmap();
                final data =
                    await bitmap.toByteData(format: ImageByteFormat.png);
                final result = data!.buffer.asUint8List();
                Get.back();
                Get.back(result: result);
              },
              icon: const Icon(Icons.done),
            ),
          ],
        ),
        body: widget.image == null
            ? const Center(
                child: Text(
                  'Tiada gambar ditemui!',
                  style: TextStyle(color: Colors.grey),
                ),
              )
            : Center(
                child: CropImage(
                  controller: _cropController,
                  image: Image.memory(widget.image!),
                  paddingSize: 12.0,
                  alwaysMove: true,
                ),
              ),
        bottomNavigationBar: widget.image == null
            ? null
            : BottomAppBar(
                height: 70,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        _cropController.rotateLeft();
                      },
                      icon: const Icon(Icons.rotate_90_degrees_ccw),
                    ),
                    IconButton(
                      onPressed: () {
                        _cropController.rotateRight();
                      },
                      icon: const Icon(Icons.rotate_90_degrees_cw_outlined),
                    ),
                    IconButton(
                      onPressed: () {
                        _cropController.crop =
                            const Rect.fromLTRB(0.05, 0.05, 0.95, 0.95);
                      },
                      icon: const Icon(Icons.crop),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
