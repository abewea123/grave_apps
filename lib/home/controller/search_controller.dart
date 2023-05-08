import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grave_apps/home/controller/home_controller.dart';

import '../model/jenazah_model.dart';

class CariJenazah extends SearchDelegate {
  final _homeController = Get.find<HomeController>();

  List<Jenazah> _getList() {
    return _homeController.jenazah.where((jenazah) {
      return jenazah.nama
          .toString()
          .toLowerCase()
          .contains(query.toLowerCase());
    }).toList();
  }

  @override
  String get searchFieldLabel => 'Cari nama jenazah';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          if (query.isEmpty) {
            close(context, null);
          } else {
            query = '';
          }
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () => close(context, null),
        icon: const Icon(
          Icons.arrow_back,
        ));
  }

  @override
  Widget buildResults(BuildContext context) {
    List jenazahList = _getList();
    return jenazahList.isEmpty
        ? Center(
            child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.person_off, size: 150, color: Colors.grey),
                const SizedBox(height: 10),
                Text(
                  'Jenazah yang bernama $query tidak dapat ditemui!',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ))
        : buildSuggestions(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List suggestion = _getList();

    return query.isEmpty
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Icon(
                  Icons.person_search,
                  size: 120,
                  color: Colors.grey,
                ),
                SizedBox(height: 10),
                Text(
                  'Anda boleh cari nama atau lot kubur jenazah',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                )
              ],
            ),
          )
        : ListView.builder(
            itemCount: suggestion.length,
            itemBuilder: (context, i) {
              Jenazah result = suggestion[i];
              return ListTile(
                title: Text(result.nama),
                subtitle: Text(result.tempatTinggal),
                leading: CircleAvatar(
                  backgroundColor: Get.isDarkMode
                      ? Theme.of(context).colorScheme.secondaryContainer
                      : Theme.of(context).colorScheme.secondary,
                ),
                onTap: () {},
              );
            });
  }
}
