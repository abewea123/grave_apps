import 'package:flutter/material.dart';

class KadArwah extends StatelessWidget {
  final String nama;
  final String alamat;
  final String tarikhLahir;
  final String tarikhMeninggal;
  final String lotKubur;
  final String nota;
  const KadArwah({
    super.key,
    required this.nama,
    required this.alamat,
    required this.tarikhLahir,
    required this.tarikhMeninggal,
    required this.lotKubur,
    required this.nota,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 3,
            blurRadius: 5,
            offset: const Offset(0, 9), // changes position of shadow
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const CircleAvatar(
                  radius: 30,
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        nama,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        alamat,
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
                      text: tarikhLahir,
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
                      text: tarikhMeninggal,
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
                      text: alamat, style: const TextStyle(color: Colors.grey)),
                ],
              ),
            ),
            const SizedBox(height: 5),
            Text.rich(
              TextSpan(
                text: 'Lot Kubur: ',
                children: [
                  TextSpan(
                      text: lotKubur,
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
                    text: nota,
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Center(
              child: SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.location_on),
                  label: const Text(
                    'Lokasi',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}