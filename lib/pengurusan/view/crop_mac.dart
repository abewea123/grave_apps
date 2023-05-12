import 'dart:io';
import 'dart:ui';

import 'package:crop_image/crop_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

class CropMac extends StatefulWidget {
  final File image;
  const CropMac({super.key, required this.image});

  @override
  State<CropMac> createState() => _CropMacState();
}

class _CropMacState extends State<CropMac> {
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
                    child: const AlertDialog(
                      content: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
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
                final image = await _cropController.croppedBitmap();
                final data =
                    await image.toByteData(format: ImageByteFormat.png);
                final Directory tempDir = await getTemporaryDirectory();

                final bytes = data!.buffer.asUint8List();
                File? loc = await widget.image.copy('${tempDir.path}/temp.png');

                File? file = await loc.writeAsBytes(bytes);
                Get.back();
                Get.back(result: file);
              },
              icon: const Icon(Icons.done),
            ),
          ],
        ),
        body: Center(
          child: CropImage(
            controller: _cropController,
            image: Image.file(widget.image),
            paddingSize: 12.0,
            alwaysMove: true,
          ),
        ),
        bottomNavigationBar: BottomAppBar(
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
