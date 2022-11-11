class ChatModel {
  late String profileImage;
  late String name;
  late String uid;

  ChatModel(
      {required this.profileImage, required this.name, required this.uid});
  ChatModel.fromjson(Map<String, dynamic> json) {
    profileImage = json["image"];
    name = json["name"];
    uid = json["uid"];
  }
}
