part of 'services.dart';

class PesertaServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool?> addNewPeserta(PesertaFormModel data, String uidUser) async {
    try {
      if (data != null) {
        DocumentReference docRef = _firestore.collection('peserta').doc();
        await _firestore.collection('peserta').add({
          'uid': docRef.id,
          'name': data.name,
          'email': data.email,
          'usia': data.usia,
          'alamat': data.alamat,
          'uid_user': uidUser,
        });
        return true;
      }
    } catch (e) {
      print('error : $e');
      return false;
    }
  }

  Future<bool?> saveTesPeserta(TestFormModel data, String uidPeserta) async {
    final now = new DateTime.now();
    String formatterDate = DateFormat.yMEd().format(now);
    String formatterTime = DateFormat.Hms().format(now);
    String formatter = '${formatterDate} ${formatterTime}'; // 28/03/2020
    try {
      if (data != null) {
        DocumentReference docRef = _firestore.collection('hitung').doc();
        await _firestore.collection('hitung').add({
          'uid': docRef.id,
          'uid_peserta': uidPeserta,
          'hasil_hitung': data.hitungMasuk,
          'created_at': formatter,
          'updated_at': formatter,
        });
      }
      return true;
    } catch (e) {
      print('error : $e');
      return false;
    }
  }

  Future<bool?> deletePeserta(String uid) async {
    WriteBatch batch = FirebaseFirestore.instance.batch();
    try {
      await FirebaseFirestore.instance
          .collection('peserta')
          .where('uid', isEqualTo: uid)
          .get()
          .then((querySnapshot) => {
                querySnapshot.docs.forEach((document) {
                  batch.delete(document.reference);
                })
              });
      await FirebaseFirestore.instance
          .collection('hitung')
          .where('uid_peserta', isEqualTo: uid)
          .get()
          .then((querySnapshot) => {
                querySnapshot.docs.forEach((document) {
                  batch.delete(document.reference);
                })
              });
      batch.commit();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool?> deleteTest(String uid) async {
    WriteBatch batch = FirebaseFirestore.instance.batch();
    try {
      await FirebaseFirestore.instance
          .collection('hitung')
          .where('uid', isEqualTo: uid)
          .get()
          .then((querySnapshot) => {
                querySnapshot.docs.forEach((document) {
                  batch.delete(document.reference);
                })
              });
      batch.commit();
      return true;
    } catch (e) {
      return false;
    }
  }
}
