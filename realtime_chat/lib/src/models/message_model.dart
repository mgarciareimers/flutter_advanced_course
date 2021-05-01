import 'dart:convert';

MessageModel messageModelFromJson(String str) => MessageModel.fromJson(json.decode(str));

String messageModelToJson(MessageModel data) => json.encode(data.toJson());

class MessageModel {
  MessageModel({
    this.uid,
    this.text,
  });

  String uid;
  String text;

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
    uid: json["uid"],
    text: json["text"],
  );

  Map<String, dynamic> toJson() => {
    "uid": uid,
    "text": text,
  };
}