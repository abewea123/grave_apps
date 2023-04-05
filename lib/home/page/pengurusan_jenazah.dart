import 'package:flutter/material.dart';

class PengurusanJenazahView extends StatelessWidget {
  const PengurusanJenazahView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            title: const Text('Pengurusan'),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                ListTile(
                  leading: CircleAvatar(),
                  title: Text('Wan Luqman'),
                  subtitle: Text('Pemaju Perisian Aplikasi'),
                  onTap: () {},
                ),
                ListTile(
                  leading: CircleAvatar(),
                  title: Text('Akid Fikri'),
                  subtitle: Text('Pembantu Pemaju Perisian Aplikasi'),
                  onTap: () {},
                ),
                ListTile(
                  leading: CircleAvatar(),
                  title: Text('Shariff'),
                  subtitle: Text('Pengurus Jenazah (Pegawai Masjid)'),
                  onTap: () {},
                ),
                ListTile(
                  leading: CircleAvatar(),
                  title: Text('Zayyan'),
                  subtitle: Text('Pembantu Pengurus Jenazah'),
                  onTap: () {},
                ),
                ListTile(
                  leading: CircleAvatar(),
                  title: Text('Roslan'),
                  subtitle: Text('Mandi Jenazah Lelaki'),
                  onTap: () {},
                ),
                ListTile(
                  leading: CircleAvatar(),
                  title: Text('Puan Hajjah'),
                  subtitle: Text('Mandi Jenazah Perempuan'),
                  onTap: () {},
                ),
                ListTile(
                  leading: CircleAvatar(),
                  title: Text('Che Amad'),
                  subtitle: Text('Perkebumian'),
                  onTap: () {},
                ),
                ListTile(
                  leading: CircleAvatar(),
                  title: Text('Hassan'),
                  subtitle: Text('Perkebumian'),
                  onTap: () {},
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
