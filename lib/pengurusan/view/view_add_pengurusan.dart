import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grave_apps/pengurusan/controller/controller_add_pengurusan.dart';
import '../../config/haptic_feedback.dart';

class ViewAddPengurusan extends StatelessWidget {
  ViewAddPengurusan({super.key});
  final _addPengurusan = Get.put(ControllerAddPengurusan());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Center(
          child: SizedBox(
            width: 800,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Form(
                key: _addPengurusan.formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 50),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Icons.person_add,
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
                      'Tambah Pengurusan E-Grave',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      'Masukkan semua maklumat terhadap pengguna untuk perngurusan E-Grave Lot',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 60),
                    Text(
                      'Maklumat Peribadi',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      controller: _addPengurusan.namaText,
                      keyboardType: TextInputType.name,
                      textCapitalization: TextCapitalization.words,
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.person,
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                        label: const Text('Nama'),
                        hintText: 'Abdullah',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Sila masukkan nama!';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _addPengurusan.noPhoneText,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.phone,
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                        label: const Text('Nombor Telefon'),
                        hintText: '0123456789',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Masukkan nombor telefon';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Maklumat Pengurusan',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _addPengurusan.kawasanQaryahText,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.name,
                      textCapitalization: TextCapitalization.sentences,
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.mosque,
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                        label: const Text('Kawasan Qaryah'),
                        hintText: 'Masjid Sultan Ismail Petra',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Sila masukkan Kawasan Qaryah!';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _addPengurusan.jawatanPengurusanText,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.name,
                      textCapitalization: TextCapitalization.sentences,
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.cases,
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                        label: const Text('Jawatan Pengurusan'),
                        hintText: 'Pengurus Jenazah, Perkebumian',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Sila masukkan jawatan pengurusan!';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 30),
                    Text(
                      'Maklumat Akaun',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      controller: _addPengurusan.emailText,
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.email,
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                        label: const Text('Email'),
                        hintText: 'abdullah@email.com',
                      ),
                      validator: (value) {
                        bool validate = _addPengurusan.checkEmail(value!);
                        if (!validate) {
                          return 'Sila masukkan email dengan betul!';
                        }
                        return null;
                      },
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
                            onTap: () => _addPengurusan.pickImage(context),
                            child: Ink(
                              height: 80,
                              width: double.infinity,
                              color: Get.isDarkMode
                                  ? Colors.grey.shade900
                                  : Colors.grey.shade200,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Obx(() => Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        CircleAvatar(
                                          backgroundImage: FileImage(File(
                                              _addPengurusan.imagePath.value)),
                                          child:
                                              _addPengurusan.imageLoc.value ==
                                                      ''
                                                  ? Icon(
                                                      Icons.upload,
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .onSecondaryContainer,
                                                    )
                                                  : const SizedBox(),
                                        ),
                                        const SizedBox(width: 30),
                                        Expanded(
                                          child: Text(
                                            _addPengurusan.imageLoc.value == ''
                                                ? 'Muat naik gambar akaun profil'
                                                : _addPengurusan.imageLoc.value,
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
                    ),
                    const SizedBox(height: 30),
                    Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _addPengurusan.confirmationAdd,
                          child: const Text('Tambah Pengurusan'),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
