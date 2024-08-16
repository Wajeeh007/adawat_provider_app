import 'package:adawat_provider_app/models/message.dart';
import 'package:adawat_provider_app/screens/chat/chat_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ChatViewModel extends GetxController {

  /// Controller(s)
  ScrollController scrollController = ScrollController();
  TextEditingController messageController = TextEditingController();

  /// Chat messages list
  Rx<ChatModel> chat = ChatModel(
      name: 'Wajeeh',
      lastMessage: Message(
          messageTime: DateTime.now(),
          message: 'Hello',
          isMine: false
      ),
    messages: [
      Message(
          messageTime: DateTime.now().subtract(const Duration(days: 2)),
          message: 'Hello',
          isMine: false
      ),
      Message(
          messageTime: DateTime.now().subtract(const Duration(days: 1)),
          message: 'Hello',
          isMine: false
      ),
      Message(
          messageTime: DateTime.now().subtract(const Duration(hours: 2)),
          message: 'Hello',
          isMine: true
      ),
      Message(
          messageTime: DateTime.now().subtract(const Duration(days: 1)),
          message: 'Hello',
          isMine: false
      ),
      Message(
          messageTime: DateTime.now().subtract(const Duration(minutes: 2)),
          message: 'Hello, Demo repeat test message checking',
          isMine: true
      ),
      Message(
          messageTime: DateTime.now(),
          message: 'Hello',
          isMine: false
      ),
    ]
  ).obs;

  /// Loading Variables
  RxBool showMessages = false.obs;

  @override
  void onReady() {
    if(scrollController.hasClients) {
      scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeIn
      );
    }
    super.onReady();
  }
}