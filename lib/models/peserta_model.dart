class PesertaModel {
  String? uid;
  String? name;
  String? email;
  String? usia;
  String? alamat;
  String? uidUser;
  String? createdAt;

  PesertaModel({
    this.uid,
    this.name,
    this.email,
    this.usia,
    this.alamat,
    this.uidUser,
    this.createdAt,
  });

  PesertaModel.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    name = json['name'];
    email = json['email'];
    usia = json['usia'];
    alamat = json['alamat'];
    uidUser = json['uid_user'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'usia': usia,
      'alamat': alamat,
      'uid_user': uidUser,
      'created_at': createdAt,
    };
  }
}
