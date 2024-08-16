import 'package:adawat_provider_app/custom_widgets/custom_appbar.dart';
import 'package:adawat_provider_app/custom_widgets/custom_network_image.dart';
import 'package:adawat_provider_app/custom_widgets/custom_textfield.dart';
import 'package:adawat_provider_app/custom_widgets/no_data_found.dart';
import 'package:adawat_provider_app/helpers/common_functions.dart';
import 'package:adawat_provider_app/helpers/routes.dart';
import 'package:adawat_provider_app/screens/inbox/inbox_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:adawat_provider_app/helpers/languages/translations_key.dart' as lang_key;
import 'package:shimmer/shimmer.dart';
import '../../helpers/constants.dart';
import '../chat/chat_model.dart';

class InboxView extends StatelessWidget {
  InboxView({super.key});

  final InboxViewModel viewModel = Get.put<InboxViewModel>(InboxViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleText: lang_key.inbox.tr,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Obx(() => Column(
            children: [
              CustomTextField(
                isSearchField: true,
                controller: viewModel.searchController,
                hintText: lang_key.searchChatByName.tr,
                onChanged: (value) {
                  if(value == '' || value.isEmpty) {
                    CommonFunctions.repopulateList(viewModel.allChats, viewModel.visibleChats);
                  } else {
                    viewModel.searchChat(value);
                  }
                },
                enabled: viewModel.showChats.value,
              ),
              viewModel.visibleChats.isEmpty ? NoDataFound(
                  text: lang_key.noChatsFound.tr
              ) : ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  itemCount: viewModel.showChats.value ? viewModel.visibleChats.length : 5,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Chat(
                        chat: viewModel.visibleChats[index],
                      isShimmer: !viewModel.showChats.value,
                    );
                  }
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Chat widget
class Chat extends StatelessWidget {
  Chat({
    super.key,
    required this.chat,
    required this.isShimmer
  });

  final ChatModel chat;
  final bool isShimmer;

  final InboxViewModel viewModel = Get.find();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0, right: 7),
      child: isShimmer ? const ChatShimmer() : InkWell(
        onTap: () => Get.toNamed(AppRoutes.chat),
        child: Row(
          children: [
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: chat.imageUrl == null ? Image.asset(
                    'assets/images/person_circle.png',
                  color: Theme.of(context).colorScheme.secondary,
                  fit: BoxFit.fitHeight,
                  height: 50,
                  width: 50,
                ) : CustomNetworkImage(
                  height: 75,
                  width: 75,
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        chat.name!,
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w600),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        DateFormat('hh:mm a').format(chat.lastMessage!.messageTime!),
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: darkThemeLightGrey
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          chat.lastMessage!.message!,
                          style: Theme.of(context).textTheme.labelMedium,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      chat.lastMessage!.isRead! ? const SizedBox() : CircleAvatar(
                        backgroundColor: Get.isDarkMode ? primaryDullYellow : primaryYellow,
                        radius: 5,
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ChatShimmer extends StatelessWidget {
  const ChatShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Theme.of(context).colorScheme.tertiaryContainer,
      highlightColor: Theme.of(context).colorScheme.tertiaryFixedDim,
      child: SizedBox(
        height: 60,
        child: Row(
          children: [
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondaryContainer,
                    shape: BoxShape.circle
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10,),
            Expanded(
              flex: 4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    height: 20,
                    width: Get.width * 0.35,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondaryContainer,
                      borderRadius: kBorderRadius
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 4),
                    height: 10,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondaryContainer,
                        borderRadius: kBorderRadius
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 4),
                    height: 10,
                    width: Get.width * 0.45,
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondaryContainer,
                        borderRadius: kBorderRadius
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}