class TestFormModel {
  final String? hitungMasuk;

  TestFormModel({
    this.hitungMasuk,
  });

  Map<String, dynamic> toJson() {
    return {
      'hitung_masuk': hitungMasuk,
    };
  }
}
