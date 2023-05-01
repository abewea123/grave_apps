import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:grave_apps/config/haptic_feedback.dart';
import 'package:grave_apps/config/routes.dart';

class PengurusanJenazahView extends StatefulWidget {
  final User? user;
  const PengurusanJenazahView({super.key, required this.user});

  @override
  State<PengurusanJenazahView> createState() => _PengurusanJenazahViewState();
}

class _PengurusanJenazahViewState extends State<PengurusanJenazahView> {
  bool isScroll = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: widget.user != null
          ? FloatingActionButton.extended(
              isExtended: isScroll,
              onPressed: () {
                Haptic.feedbackClick();
                Get.toNamed(MyRoutes.tambahPengurusan);
              },
              icon: const Icon(Icons.add),
              label: const Text('Tambah Pengurusan'),
            )
          : null,
      body: NotificationListener<UserScrollNotification>(
        onNotification: (noti) {
          if (noti.direction == ScrollDirection.forward) {
            setState(() {
              isScroll = true;
            });
          } else if (noti.direction == ScrollDirection.reverse) {
            setState(() {
              isScroll = false;
            });
          }
          return true;
        },
        child: CustomScrollView(
          slivers: [
            SliverAppBar.large(
              title: const Text('Pengurusan'),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [],
              ),
            )
          ],
        ),
      ),
    );
  }
}
