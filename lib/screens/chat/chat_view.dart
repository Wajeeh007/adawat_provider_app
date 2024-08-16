import 'package:adawat_provider_app/custom_widgets/custom_appbar.dart';
import 'package:adawat_provider_app/custom_widgets/image_avatar.dart';
import 'package:adawat_provider_app/helpers/constants.dart';
import 'package:adawat_provider_app/screens/chat/chat_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../helpers/common_functions.dart';
import '../../models/message.dart';
import 'package:adawat_provider_app/helpers/languages/translations_key.dart' as lang_key;

//TODO: Refactoring according to prompt and add no messages image/text/vector

class ChatView extends StatelessWidget {
  ChatView({super.key});

  final ChatViewModel viewModel = Get.put<ChatViewModel>(ChatViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
      elevation: 5,
        leadingWidth: 35,
        backBtnLeadingAlignment: Alignment.centerRight,
        bgColor: Theme.of(context).appBarTheme.backgroundColor,
        centerTitle: false,
        titleWidget: Row(
          children: [
            ImageAvatar(url: viewModel.chat.value.imageUrl),
            Text(
              viewModel.chat.value.name!,
              style: Theme.of(context).textTheme.bodySmall,
            )
          ]
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: viewModel.scrollController,
              itemCount: viewModel.chat.value.messages!.length,
              reverse: true,
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 15),
              itemBuilder: (context, index) {

                Message message = viewModel.chat.value.messages![viewModel.chat.value.messages!.length - index - 1];

                return MessageBubble(message: message.message!, messageTime: message.messageTime!, isMine: message.isMine!);
              },
            ),
          ),
          MessageTextField()
        ],
      ),
    );
  }
}

/// Message bubble widget
class MessageBubble extends StatelessWidget {
  MessageBubble({
    super.key,
    required this.message,
    required this.messageTime,
    required this.isMine
  });

  final String message;
  final bool isMine;
  final DateTime messageTime;

  final ChatViewModel viewModel = Get.find();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if(isMine) Text(
            CommonFunctions().getTimeDifference(messageTime),
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: darkThemeLightGrey
            ),
          ),
          Container(
            constraints: BoxConstraints(maxWidth: Get.width * 0.7),
            padding: const EdgeInsets.all(10),
            margin: isMine ? EdgeInsets.zero : const EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
                color: isMine ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.only(topLeft: const Radius.circular(kContainerRadius), topRight: const Radius.circular(kContainerRadius), bottomRight: Radius.circular(isMine ? 0 : kContainerRadius), bottomLeft: Radius.circular(isMine ? kContainerRadius : 0))
            ),
            child: Text(
              message,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: backgroundWhite
              ),
            ),
          ),
          if(!isMine) Text(
            CommonFunctions().getTimeDifference(messageTime),
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: darkThemeLightGrey
            ),
          )
        ],
      ),
    );
  }
}

/// Textfield and button for typing and sending messages
class MessageTextField extends StatelessWidget {
  MessageTextField({super.key});

  final double borderRadius = 30;

  final ChatViewModel viewModel = Get.find();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: TextFormField(
              controller: viewModel.messageController,
              maxLines: 10,
              minLines: 1,
              style: Theme.of(context).textTheme.labelMedium,
              decoration: InputDecoration(
                hintText: lang_key.typeSomething.tr,
                hintStyle: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: Get.isDarkMode ? darkThemeLightGrey : lightThemeBorderGrey
                ),
                filled: true,
                contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                fillColor: Theme.of(context).colorScheme.primaryContainer,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(borderRadius),
                  borderSide: const BorderSide(
                    color: primaryGrey
                  )
                ),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(borderRadius),
                    borderSide: const BorderSide(
                        color: primaryGrey
                    )
                ),
              ),
            ),
          ),
          const SizedBox(width: 8,),
          CircleAvatar(
            radius: 28,
            backgroundColor: Theme.of(context).colorScheme.primary,
            child: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.send_rounded, color: backgroundWhite, size: 25,)
            ),
          )
        ],
      ),
    );
  }
}