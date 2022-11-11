class ChatDetails {
  late String name;
  late String date;
  late String image;
  late String text;
  late String senderId;
  late String reciveId;
  // late String? chatImage;

  ChatDetails({
    required this.name,
    required this.date,
    required this.text,
    required this.image,
    required this.senderId,
    required this.reciveId,
    // required this.chatImage,
  });
  ChatDetails.fromjson(Map<String, dynamic> json) {
    name = json["name"];
    date = json["date"];
    image = json["image"];
    text = json["text"];
    senderId = json["senderId"];
    reciveId = json["reciveId"];
    // // chatImage = json["chatImage"];
  }
  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "date": date,
      "text": text,
      "image": image,
      "senderId": senderId,
      "reciveId": reciveId,
      // // "chatImage": chatImage
    };
  }
}
