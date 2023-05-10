class Jenazah {
  final String nama;
  final String tempatTinggal;
  final String lotKubur;
  final String nota;
  final String profileImage;
  final double latitude;
  final double longitude;
  final DateTime tarikhLahir;
  final DateTime tarikhMeninggal;
  final DateTime kemaskini;

  Jenazah(
      {required this.nama,
      required this.tempatTinggal,
      required this.lotKubur,
      required this.nota,
      required this.profileImage,
      required this.latitude,
      required this.longitude,
      required this.tarikhLahir,
      required this.tarikhMeninggal,
      required this.kemaskini});

  factory Jenazah.fromFirestore(dynamic json) {
    return Jenazah(
        nama: json['nama'],
        tempatTinggal: json['tempatTinggal'],
        lotKubur: json['lotKubur'],
        nota: json['nota'],
        profileImage: json['profileImage'],
        latitude: json['latitude'],
        longitude: json['longitude'],
        tarikhLahir: json['tarikhLahir'],
        tarikhMeninggal: json['tarikhMeninggal'],
        kemaskini: json['kemaskini']);
  }

  Map<String, dynamic> toFirestore() => {
        'nama': nama,
        'tempatTinggal': tempatTinggal,
        'lotKubur': lotKubur,
        'nota': nota,
        'profileImage': profileImage,
        'latitude': latitude,
        'longitude': longitude,
        'tarikhLahir': tarikhLahir,
        'tarikhMeninggal': tarikhMeninggal,
        'kemaskini': kemaskini
      };
}
