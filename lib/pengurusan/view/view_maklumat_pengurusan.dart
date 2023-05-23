import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grave_apps/config/routes.dart';
import 'package:grave_apps/home/model/pengurusan_model.dart';
import 'package:grave_apps/pengurusan/controller/controller_add_pengurusan.dart';

class ViewMaklumatPengurusan extends StatelessWidget {
  ViewMaklumatPengurusan({super.key});
  final _user = FirebaseAuth.instance.currentUser;
  final _controller = Get.put(ControllerAddPengurusan());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('pengurusan')
              .doc(_user!.uid)
              .snapshots(),
          builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SizedBox(
                width: double.infinity,
                child: Center(
                  child: CircularProgressIndicator.adaptive(),
                ),
              );
            }
            if (snapshot.data!.exists == false) {
              Future.delayed(const Duration(milliseconds: 500), () {
                Get.back();
                FirebaseAuth.instance.signOut();
              });
              return const SizedBox();
            }
            if (snapshot.hasData) {
              Pengurusan pengurusan = Pengurusan.fromRealtime(snapshot.data);
              TextEditingController namaText =
                  TextEditingController(text: pengurusan.nama);
              TextEditingController noPhoneText =
                  TextEditingController(text: '0${pengurusan.noPhone}');
              TextEditingController jawatanPengurusanText =
                  TextEditingController(text: pengurusan.jawatan);
              TextEditingController kawasanQariahText =
                  TextEditingController(text: pengurusan.kawasanQariah);
              TextEditingController emailText =
                  TextEditingController(text: pengurusan.email);
              return CustomScrollView(
                slivers: [
                  SliverAppBar.large(
                    expandedHeight: 120,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundImage: NetworkImage(pengurusan.photoURL),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Form(
                            child: SizedBox(
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: StreamBuilder(
                                      stream: FirebaseFirestore.instance
                                          .collection('jenazah')
                                          .where('approve', isEqualTo: false)
                                          .snapshots(),
                                      builder: (context,
                                          AsyncSnapshot<QuerySnapshot>
                                              snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return const CircularProgressIndicator
                                              .adaptive();
                                        }
                                        return snapshot.data!.docs.isEmpty
                                            ? IconButton(
                                                onPressed: () => Get.toNamed(
                                                    MyRoutes
                                                        .rekodBelumDiluluskan),
                                                icon:
                                                    const Icon(Icons.list_alt))
                                            : Badge(
                                                label: Text(snapshot
                                                    .data!.docs.length
                                                    .toString()),
                                                alignment:
                                                    Alignment.bottomCenter,
                                                child: IconButton(
                                                    onPressed: () =>
                                                        Get.toNamed(MyRoutes
                                                            .rekodBelumDiluluskan),
                                                    icon: const Icon(
                                                        Icons.list_alt)),
                                              );
                                      },
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  Text(
                                    'Maklumat Peribadi',
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  TextFormField(
                                    textInputAction: TextInputAction.next,
                                    controller: namaText,
                                    readOnly: true,
                                    textCapitalization:
                                        TextCapitalization.words,
                                    decoration: InputDecoration(
                                      icon: Icon(
                                        Icons.person,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .tertiary,
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
                                    controller: noPhoneText,
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.phone,
                                    readOnly: true,
                                    decoration: InputDecoration(
                                      icon: Icon(
                                        Icons.phone,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .tertiary,
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
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  TextFormField(
                                    controller: kawasanQariahText,
                                    textInputAction: TextInputAction.next,
                                    readOnly: true,
                                    textCapitalization:
                                        TextCapitalization.words,
                                    decoration: InputDecoration(
                                      icon: Icon(
                                        Icons.mosque,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .tertiary,
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
                                    controller: jawatanPengurusanText,
                                    textInputAction: TextInputAction.next,
                                    readOnly: true,
                                    textCapitalization:
                                        TextCapitalization.words,
                                    decoration: InputDecoration(
                                      icon: Icon(
                                        Icons.cases,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .tertiary,
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
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  TextFormField(
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.emailAddress,
                                    controller: emailText,
                                    readOnly: true,
                                    decoration: InputDecoration(
                                      icon: Icon(
                                        Icons.email,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .tertiary,
                                      ),
                                      label: const Text('Email'),
                                      hintText: 'abdullah@email.com',
                                    ),
                                    validator: (value) {
                                      bool validate =
                                          EmailValidator.validate(value!);
                                      if (!validate) {
                                        return 'Sila masukkan email dengan betul!';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 30),
                                  Align(
                                    alignment: Alignment.center,
                                    child: SizedBox(
                                      height: 50,
                                      width: 700,
                                      child: ElevatedButton(
                                        onPressed: () async {
                                          Get.back();
                                          await FirebaseAuth.instance.signOut();
                                        },
                                        child: const Text('Log Keluar'),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Align(
                                    alignment: Alignment.center,
                                    child: TextButton(
                                        onPressed: () => _controller
                                            .deleteAccount(context, pengurusan),
                                        child: const Text(
                                          'Padam Akaun',
                                          style: TextStyle(color: Colors.red),
                                        )),
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              );
            }
            return const Center(
              child: Text('Error!'),
            );
          }),
    );
  }
}
