class PostModel {
  late String name;
  late String uid;
  late String text;
  late String postPhoto;
  late String image;
  late String dateTime;
  PostModel(
      {required this.postPhoto,
      required this.name,
      required this.uid,
      required this.dateTime,
      required this.image,
      required this.text});
  PostModel.fromjson(Map<String, dynamic> json) {
    name = json["name"];
    uid = json["uid"];
    postPhoto = json["postPhoto"];
    dateTime = json["dateTime"];
    image = json["image"];
    text = json["text"];
  }
  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "uid": uid,
      "text": text,
      "postPhoto": postPhoto,
      "dateTime": dateTime,
      "image": image,
    };
  }
}
