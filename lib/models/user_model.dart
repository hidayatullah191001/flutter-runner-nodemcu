class UserModel {
  String? uid;
  String? email;
  String? name;

  UserModel({
    this.uid,
    this.email,
    this.name,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    email = json['email'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
    };
  }
}
