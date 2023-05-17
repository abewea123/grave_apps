import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';

class ViewGambarKubur extends StatelessWidget {
  ViewGambarKubur({super.key});
  final _args = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gambar'),
      ),
      body: Center(
        child: PhotoView(
          imageProvider: NetworkImage(_args['id']),
        ),
      ),
    );
  }
}
