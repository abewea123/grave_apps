import 'package:cloud_firestore/cloud_firestore.dart';

class Jenazah {
  final String? id;
  final String nama;
  final String tempatTinggal;
  final String lotKubur;
  final String nota;
  final String gambarKubur;
  final GeoPoint geoPoint;
  final bool approve;
  final DateTime tarikhLahir;
  final DateTime tarikhMeninggal;
  final DateTime kemaskini;

  Jenazah(
      {this.id,
      required this.nama,
      required this.tempatTinggal,
      required this.lotKubur,
      required this.nota,
      required this.gambarKubur,
      required this.geoPoint,
      required this.approve,
      required this.tarikhLahir,
      required this.tarikhMeninggal,
      required this.kemaskini});

  factory Jenazah.fromFirestore(dynamic json) {
    return Jenazah(
        id: json.id,
        nama: json['nama'],
        tempatTinggal: json['tempatTinggal'],
        lotKubur: json['lotKubur'],
        nota: json['nota'],
        gambarKubur: json['gambarKubur'],
        geoPoint: json['geoPoint'] as GeoPoint,
        approve: json['approve'],
        tarikhLahir: DateTime.parse(json['tarikhLahir'].toDate().toString()),
        tarikhMeninggal:
            DateTime.parse(json['tarikhMeninggal'].toDate().toString()),
        kemaskini: DateTime.parse(json['kemaskini'].toDate().toString()));
  }

  Map<String, dynamic> toFirestore() => {
        'nama': nama,
        'tempatTinggal': tempatTinggal,
        'lotKubur': lotKubur,
        'nota': nota,
        'gambarKubur': gambarKubur,
        'geoPoint': geoPoint,
        'approve': approve,
        'tarikhLahir': tarikhLahir,
        'tarikhMeninggal': tarikhMeninggal,
        'kemaskini': kemaskini
      };
}
