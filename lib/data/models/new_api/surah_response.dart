class SurahResponse {
  SurahResponse({
    this.statusCode = 200,
    this.message,
    required this.data
  });

  int statusCode;
  String? message;
  List<Data> data;

  factory SurahResponse.fromJson(Map<String, dynamic> json) => SurahResponse(
    statusCode: json['status_code'],
    message: json['message'],
    data: List<Data>.from(json['data'].map((x) => Data.fromJson(x)))
  );

  Map<String, dynamic> toJson() => {
    'status_code': statusCode,
    'message': message,
    'data': List<dynamic>.from(data.map((x) => x.toJson()))
  };
}

class Data {
    Data({
        required this.nomor,
        required this.nama,
        required this.namaLatin,
        required this.jumlahAyat,
        required this.tempatTurun,
        required this.arti,
        required this.deskripsi,
        required this.audio,
    });

    int nomor;
    String nama;
    String namaLatin;
    int jumlahAyat;
    String tempatTurun;
    String arti;
    String deskripsi;
    String audio;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        nomor: json["nomor"],
        nama: json["nama"],
        namaLatin: json["nama_latin"],
        jumlahAyat: json["jumlah_ayat"],
        tempatTurun: json["tempat_turun"],
        arti: json["arti"],
        deskripsi: json["deskripsi"],
        audio: json["audio"],
    );

    Map<String, dynamic> toJson() => {
        "nomor": nomor,
        "nama": nama,
        "nama_latin": namaLatin,
        "jumlah_ayat": jumlahAyat,
        "tempat_turun": tempatTurun,
        "arti": arti,
        "deskripsi": deskripsi,
        "audio": audio,
    };
}
