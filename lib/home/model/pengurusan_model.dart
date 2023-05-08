class Pengurusan {
  final String nama;
  final String jawatan;
  final String photoURL;
  final String email;
  final String kawasanQariah;
  final int noPhone;

  Pengurusan({
    required this.nama,
    required this.jawatan,
    required this.photoURL,
    required this.email,
    required this.kawasanQariah,
    required this.noPhone,
  });

  factory Pengurusan.fromRealtime(dynamic json) {
    return Pengurusan(
        nama: json['nama'],
        jawatan: json['jawatan'],
        photoURL: json['photoURL'],
        noPhone: json['noPhone'],
        email: json['email'],
        kawasanQariah: json['kawasanQariah']);
  }

  Map<String, dynamic> toRealtime() => {
        'nama': nama,
        'jawatan': jawatan,
        'photoURL': photoURL,
        'noPhone': noPhone,
        'email': email,
        'kawasanQariah': kawasanQariah,
      };
}
