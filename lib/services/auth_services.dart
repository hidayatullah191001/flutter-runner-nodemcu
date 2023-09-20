part of 'services.dart';

class AuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserModel?> signUpUser(SignUpFormModel data) async {
    try {
      if (data.email.toString().isNotEmpty ||
          data.name.toString().isNotEmpty ||
          data.password.toString().isNotEmpty) {
        UserCredential user = await _auth.createUserWithEmailAndPassword(
            email: data.email.toString(), password: data.password.toString());
        UserModel userModel =
            UserModel(uid: user.user?.uid, email: data.email, name: data.name);

        await _firestore.collection('users').doc(user.user?.uid).set(
              userModel.toJson(),
            );
        await storeCredentialToLocal(userModel, data.password.toString());
        return userModel;
      }
    } catch (e) {
      print('error : $e');
    }
  }

  Future<UserModel?> signInUser(SignInFormModel data) async {
    try {
      if (data.email.toString().isNotEmpty ||
          data.password.toString().isNotEmpty) {
        UserCredential user = await _auth.signInWithEmailAndPassword(
            email: data.email.toString(), password: data.password.toString());

        CollectionReference users = _firestore.collection('users');

        final userLogin = await users.doc(user.user?.uid).get();
        final curUserData = userLogin.data() as Map<String, dynamic>;

        if (curUserData != null) {
          // Data tidak null, maka Anda bisa menggunakan curUserData
          UserModel userModel = UserModel(
            uid: curUserData['uid'],
            name: curUserData['name'],
            email: curUserData['email'],
          );
          await storeCredentialToLocal(userModel, data.password.toString());
          return userModel;
        }

        print(userLogin.data());
      }
    } catch (e) {
      print('error : $e');
    }
  }

  Future<void> storeCredentialToLocal(UserModel user, String password) async {
    try {
      const storage = FlutterSecureStorage();
      await storage.write(key: 'uid', value: user.uid);
      await storage.write(key: 'name', value: user.name);
      await storage.write(key: 'email', value: user.email);
      await storage.write(key: 'password', value: password);
    } catch (e) {
      rethrow;
    }
  }

  Future<SignInFormModel> getCredentiallFromLocal() async {
    try {
      const storage = FlutterSecureStorage();
      Map<String, String> values = await storage.readAll();
      if (values['email'] == null || values['password'] == null) {
        throw 'authenticated';
      } else {
        final SignInFormModel data = SignInFormModel(
          email: values['email'],
          password: values['password'],
        );
        return data;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logout() async {
    try {
      await _auth.signOut();
      await clearLocalStorage();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> clearLocalStorage() async {
    const storage = FlutterSecureStorage();
    storage.deleteAll();
  }
}
