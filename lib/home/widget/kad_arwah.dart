import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../model/jenazah_model.dart';

class KadArwah extends StatelessWidget {
  final Jenazah jenazah;
  const KadArwah({
    super.key,
    required this.jenazah,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Get.isDarkMode ? Colors.grey.shade900 : Colors.grey.shade200,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(jenazah.gambarKubur),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        jenazah.nama,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        jenazah.tempatTinggal,
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text.rich(
              TextSpan(
                text: 'Tarikh Lahir: ',
                children: [
                  TextSpan(
                      text: DateFormat('dd MMMM yyyy')
                          .format(jenazah.tarikhLahir),
                      style: const TextStyle(color: Colors.grey)),
                ],
              ),
            ),
            const SizedBox(height: 5),
            Text.rich(
              TextSpan(
                text: 'Tarikh Meninggal: ',
                children: [
                  TextSpan(
                      text: DateFormat('dd MMMM yyyy')
                          .format(jenazah.tarikhMeninggal),
                      style: const TextStyle(color: Colors.grey)),
                ],
              ),
            ),
            const SizedBox(height: 5),
            Text.rich(
              TextSpan(
                text: 'Tempat Tinggal: ',
                children: [
                  TextSpan(
                      text: jenazah.tempatTinggal,
                      style: const TextStyle(color: Colors.grey)),
                ],
              ),
            ),
            const SizedBox(height: 5),
            Text.rich(
              TextSpan(
                text: 'Lot Kubur: ',
                children: [
                  TextSpan(
                      text: jenazah.lotKubur,
                      style: const TextStyle(color: Colors.grey)),
                ],
              ),
            ),
            const SizedBox(height: 5),
            Text.rich(
              TextSpan(
                text: 'Nota: ',
                children: [
                  TextSpan(
                    text: jenazah.nota,
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            // Center(
            //   child: SizedBox(
            //     height: 50,
            //     width: double.infinity,
            //     child: ElevatedButton.icon(
            //       onPressed: () {},
            //       icon: const Icon(Icons.location_on),
            //       label: const Text(
            //         'Lokasi',
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
