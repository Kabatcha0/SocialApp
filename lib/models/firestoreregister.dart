class FireStoreRegister {
  late String name;
  late String uid;
  late String phone;
  late String email;
  late String password;
  late String image;
  late String bio;
  late String cover;
  FireStoreRegister(
      {required this.email,
      required this.name,
      required this.password,
      required this.phone,
      required this.uid,
      required this.bio,
      required this.image,
      required this.cover});
  FireStoreRegister.fromjson(Map<String, dynamic> json) {
    name = json["name"];
    uid = json["uid"];
    phone = json["phone"];
    email = json["email"];
    password = json["password"];
    bio = json["bio"];
    image = json["image"];
    cover = json["cover"];
  }
  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "uid": uid,
      "phone": phone,
      "email": email,
      "password": password,
      "bio": bio,
      "image": image,
      "cover": cover
    };
  }
}
