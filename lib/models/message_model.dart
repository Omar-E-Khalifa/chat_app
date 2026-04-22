import 'package:chat_app/constants.dart';

class MessageModel {
  final String message;
  final String id;

  MessageModel({required this.message, required this.id});

  factory MessageModel.fromJson(jsonData) {
    return MessageModel(
      message: jsonData[KMessage],
      id: jsonData["id"],
    );
  }
}
