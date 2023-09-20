class PesertaFormModel {
  final String? name;
  final String? email;
  final String? usia;
  final String? alamat;

  PesertaFormModel({
    this.name,
    this.email,
    this.usia,
    this.alamat,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'usia': usia,
      'alamat': alamat,
    };
  }
}
