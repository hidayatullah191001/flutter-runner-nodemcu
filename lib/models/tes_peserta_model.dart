class TesPesertaModel {
  String? uid;
  String? uidPeserta;
  String? hasilHitung;
  String? createdAt;

  TesPesertaModel({
    this.uid,
    this.uidPeserta,
    this.hasilHitung,
    this.createdAt,
  });

  TesPesertaModel.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    uidPeserta = json['uid_peserta'];
    hasilHitung = json['hasil_hitung'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'uid_peserta': uidPeserta,
      'hasil_hitung': hasilHitung,
      'created_at': createdAt,
    };
  }
}
