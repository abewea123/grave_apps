import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/haptic_feedback.dart';
import '../controller/controller_add_record.dart';

class ViewAddJenazah extends StatelessWidget {
  ViewAddJenazah({super.key});

  final _controller = Get.put(AddRecordController());
  final User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            width: 700,
            child: Form(
              key: _controller.formkey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: GetBuilder<AddRecordController>(builder: (_) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 50),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.line_style_sharp,
                            size: 35,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          IconButton(
                            onPressed: () {
                              Haptic.feedbackError();
                              Get.back();
                            },
                            icon: const Icon(Icons.close),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      Text(
                        'Tambah Rekod Jenazah',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        'Masukkan semua maklumat yang berkaitan dan pastikan semua maklumat adalah benar dan tepat.',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 50),
                      Text(
                        'Maklumat Peribadi',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _controller.namaJenazahText,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                          hintText: 'Abdullah',
                          label: Text('Nama Jenazah'),
                          icon: Icon(Icons.person),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Sila masukkan nama jenazah';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _controller.tempatTinggalText,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.streetAddress,
                        decoration: const InputDecoration(
                          hintText: 'Kota Bahru, Kelantan',
                          label: Text('Tempat Tinggal'),
                          icon: Icon(Icons.map),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Sila masukkan tempat tinggal jenazah';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _controller.tarikhLahirText,
                        onTap: () => _controller.tarikhLahirDate(context),
                        textInputAction: TextInputAction.next,
                        readOnly: true,
                        decoration: const InputDecoration(
                          hintText: '8 April 1998',
                          label: Text('Tarikh Lahir'),
                          icon: Icon(Icons.timer),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Sila masukkan tarikh lahir lahir';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _controller.tarikhMeninggalText,
                        onTap: () => _controller.tarikhMeninggalDate(context),
                        textInputAction: TextInputAction.next,
                        readOnly: true,
                        decoration: const InputDecoration(
                          hintText: '10 May 2023',
                          label: Text('Tarikh Meninggal'),
                          icon: Icon(Icons.access_time_filled_rounded),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Sila masukkan tarikh meninggal jenazah';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Maklumat Kubur',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _controller.lotKuburText,
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                          hintText: '213',
                          label: Text('Lot Kubur'),
                          icon: Icon(Icons.approval_sharp),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Sila masukkan lot kubur jenazah';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _controller.lokasiKuburText,
                        textInputAction: TextInputAction.next,
                        maxLines: 2,
                        readOnly: true,
                        onTap: () => _controller.chooseLocation(context),
                        decoration: const InputDecoration(
                          hintText: 'Lat: 2,31231\nLong: 5,32234',
                          label: Text('Lokasi Kubur'),
                          icon: Icon(Icons.person_pin_circle),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Sila berikan lokasi kordinat kubur jenazah';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _controller.notesText,
                        textInputAction: TextInputAction.next,
                        maxLines: 3,
                        decoration: const InputDecoration(
                          hintText:
                              'cth: Waris kepada Mamat, Arwah baik orangnya...',
                          label: Text('Nota'),
                          icon: Icon(Icons.note),
                        ),
                      ),
                      const SizedBox(height: 20),
                      DottedBorder(
                        dashPattern: const [5, 3],
                        borderType: BorderType.RRect,
                        color: Theme.of(context).colorScheme.tertiary,
                        radius: const Radius.circular(5),
                        child: Padding(
                          padding: const EdgeInsets.all(3),
                          child: ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5)),
                            child: InkWell(
                              onTap: () {
                                if (GetPlatform.isWeb) {
                                  _controller.chooseImageWeb(context);
                                } else if (GetPlatform.isMacOS) {
                                  _controller.chooseImageMac(context);
                                } else {
                                  _controller.chooseImage(context);
                                }
                              },
                              child: Ink(
                                height: 80,
                                width: double.infinity,
                                color: Get.isDarkMode
                                    ? Colors.grey.shade900
                                    : Colors.grey.shade200,
                                child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            height: 40,
                                            width: 40,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .onSurface),
                                            ),
                                            child: _controller.fileName.value ==
                                                    ''
                                                ? Icon(
                                                    Icons.upload,
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .onSecondaryContainer,
                                                  )
                                                : GetPlatform.isWeb
                                                    ? Image.memory(
                                                        _controller.webImage)
                                                    : Image.file(
                                                        _controller.imageFile,
                                                        fit: BoxFit.cover,
                                                      ),
                                          ),
                                        ),
                                        const SizedBox(width: 30),
                                        Expanded(
                                          flex: 5,
                                          child: Text(
                                            _controller.fileName.value == ''
                                                ? 'Muat naik gambar kubur'
                                                : _controller.fileName.value,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .secondary,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 50),
                      SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () =>
                              _controller.confirmationAddDialog(context),
                          child: Text(user!.isAnonymous
                              ? 'Meminta Tambah Rekod'
                              : 'Tambah Rekod'),
                        ),
                      ),
                      _controller.lokasiKuburText.text.isEmpty
                          ? const SizedBox()
                          : const SizedBox(height: 20),
                      _controller.lokasiKuburText.text.isEmpty
                          ? const SizedBox()
                          : Obx(() => Text.rich(
                                TextSpan(
                                  text: _controller.alamatCode.value != ''
                                      ? '${_controller.alamatCode.value}.\n'
                                      : 'Kordinat lokasi kubur tidak dapat diterjemah.\n',
                                  style: const TextStyle(color: Colors.grey),
                                  children: [
                                    TextSpan(
                                      text: ' Klik sini ',
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () => _controller.openMap(),
                                    ),
                                    const TextSpan(
                                        text:
                                            'untuk melihat kordinasi lokasi kubur dari aplikasi Peta'),
                                  ],
                                ),
                                textAlign: TextAlign.center,
                              )),
                      const SizedBox(height: 20),
                    ],
                  );
                }),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
