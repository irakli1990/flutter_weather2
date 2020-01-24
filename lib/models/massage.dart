// To parse this JSON data, do
//
//     final message = messageFromJson(jsonString);

import 'dart:convert';

Message messageFromJson(String str) => Message.fromJson(json.decode(str));

String messageToJson(Message data) => json.encode(data.toJson());

class Message {
  String cod;
  String message;

  Message({
    this.cod,
    this.message,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
    cod: json["cod"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "cod": cod,
    "message": message,
  };
}
