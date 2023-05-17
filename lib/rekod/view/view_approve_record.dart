import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grave_apps/config/extension.dart';
import 'package:grave_apps/config/routes.dart';
import 'package:grave_apps/home/model/jenazah_model.dart';

class ViewApproveReport extends StatelessWidget {
  const ViewApproveReport({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            title: const Text('Rekod Belum Diluluskan'),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('jenazah')
                      .where('approve', isEqualTo: false)
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const SizedBox(
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircularProgressIndicator.adaptive(),
                            SizedBox(height: 10),
                            Text('Memuatkan data...')
                          ],
                        ),
                      );
                    }

                    if (snapshot.data!.docs.isEmpty) {
                      return SizedBox(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height / 2,
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.browser_not_supported,
                              size: 120,
                              color: Colors.grey,
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Semua rekod jenazah telah diluluskan',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.grey),
                            )
                          ],
                        ),
                      );
                    }

                    return Column(
                      children: snapshot.data!.docs.map((docs) {
                        Jenazah jenazah = Jenazah.fromFirestore(docs);
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(jenazah.gambarKubur),
                          ),
                          title: Text(jenazah.nama),
                          subtitle:
                              Text(jenazah.tempatTinggal.capitalizeByWord()),
                          onTap: () => Get.toNamed(MyRoutes.detailsRekod,
                              parameters: {'uid': jenazah.id.toString()}),
                        );
                      }).toList(),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
