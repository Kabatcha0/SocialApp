class CommentModel {
  late String name;
  late String date;
  late String text;
  late String image;
  late String? commentImage;

  CommentModel({
    required this.name,
    required this.date,
    required this.text,
    required this.image,
    required this.commentImage,
  });
  CommentModel.fromjson(Map<String, dynamic> json) {
    name = json["name"];
    date = json["date"];
    text = json["text"];
    image = json["image"];
    commentImage = json["commentImage"];
  }
  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "date": date,
      "text": text,
      "image": image,
      "commentImage": commentImage
    };
  }
}
