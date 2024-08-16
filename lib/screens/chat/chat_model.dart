import 'package:adawat_provider_app/models/message.dart';

class ChatModel {

  String? name;
  String? imageUrl;
  Message? lastMessage;
  List<Message>? messages;

  ChatModel({this.name, this.imageUrl, this.lastMessage, this.messages});
}