import 'package:adawat_provider_app/models/message.dart';
import 'package:adawat_provider_app/screens/chat/chat_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class InboxViewModel extends GetxController {

  /// Controller(s)
  TextEditingController searchController = TextEditingController();

  /// Lists for displaying all chats
  List<ChatModel> allChats = <ChatModel>[
    ChatModel(name: 'Ahsan', lastMessage: Message(message: 'Hi', messageTime: DateTime.now(), isRead: false)),
    ChatModel(name: 'Syed Ahsan', lastMessage: Message(message: 'Hi. This is your service Man', messageTime: DateTime.now(), isRead: false)),
    ChatModel(name: 'Wajeeh Ahsan', lastMessage: Message(message: 'Hi. Also Your service man', messageTime: DateTime.now(), isRead: true)),
    ChatModel(name: 'Umair', lastMessage: Message(message: 'Hi', messageTime: DateTime.now(), isRead: true)),
    ChatModel(name: 'Fahad', lastMessage: Message(message: 'Hi', messageTime: DateTime.now(), isRead: true)),
    ChatModel(name: 'Ahmad Khan', lastMessage: Message(message: 'Hi', messageTime: DateTime.now(), isRead: true)),
  ];

  RxList<ChatModel> visibleChats = <ChatModel>[].obs;

  /// Loading Variables
  RxBool showChats = false.obs;

  @override
  void onReady() {
    visibleChats.addAll(allChats);
    Future.delayed(const Duration(seconds: 3), () => showChats.value = true);
    super.onReady();
  }

  @override
  void onClose() {
    searchController.dispose();
    visibleChats.clear();
    allChats.clear();
    showChats.value = false;
    super.onClose();
  }

  searchChat(String value) {
    visibleChats.clear();
    for(var element in allChats) {
      if(element.name!.toLowerCase().contains(value.toLowerCase())) {
        visibleChats.add(element);
        visibleChats.refresh();
      }
    }
  }
}