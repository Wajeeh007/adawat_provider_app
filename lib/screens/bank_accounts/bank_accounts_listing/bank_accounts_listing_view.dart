import 'package:adawat_provider_app/custom_widgets/custom_appbar.dart';
import 'package:adawat_provider_app/custom_widgets/custom_textfield.dart';
import 'package:adawat_provider_app/custom_widgets/guider.dart';
import 'package:adawat_provider_app/custom_widgets/no_data_found.dart';
import 'package:adawat_provider_app/helpers/common_functions.dart';
import 'package:adawat_provider_app/models/bank_account.dart';
import 'package:adawat_provider_app/screens/bank_accounts/bank_accounts_listing/bank_accounts_listing_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:get/get.dart';
import 'package:adawat_provider_app/helpers/languages/translations_key.dart' as lang_key;
import 'package:shimmer/shimmer.dart';
import '../../../custom_widgets/bottom_sheet_item.dart';
import '../../../custom_widgets/guider_arrow_and_text.dart';
import '../../../helpers/constants.dart';
import '../../../helpers/routes.dart';

class BankAccountsListingView extends StatelessWidget {
  BankAccountsListingView({super.key});

  final BankAccountsListingViewModel viewModel = Get.put(BankAccountsListingViewModel());

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Scaffold(
          appBar: CustomAppBar(
            titleText: lang_key.bankAccount.tr,
            action: [
              Obx(() => Visibility(
                  visible: viewModel.showBankAccounts.value && viewModel.allAccountsList.length < 5,
                  child: IconButton(
                      onPressed: () => Get.toNamed(AppRoutes.editOrAddAccount),
                      icon: const Icon(
                        Icons.add_circle_outline_rounded,
                        size: 25,
                      )
                  ),
                ),
              )
            ],
          ),
          body: Obx(() => viewModel.showBankAccounts.value && viewModel.visibleAccountsList.isEmpty ? NoDataFound(
              text: lang_key.noBankAccountFound.tr,
              icon: CupertinoIcons.nosign,
          ) : SingleChildScrollView(
              child: Column(
                children: [
                  SearchField(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(
                        viewModel.showBankAccounts.value ? viewModel.visibleAccountsList.length : 3,
                        (index) {
                          return viewModel.showBankAccounts.isTrue
                              && viewModel.visibleAccountsList.isNotEmpty ?
                          AccountDetailsWidget(
                              accountDetails: viewModel.visibleAccountsList[index]
                          ) : const AccountShimmer();
                        }
                    ),
                  )
                ],
              )),
            ),
          ),
        Obx(() => Visibility(
          visible: viewModel.showBankAccounts.value,
          child: Guider(
                guiderBool: viewModel.showGuider,
              children: [
                GuiderArrowAndText(
                  text: lang_key.swipeToDelete.tr,
                  arrowIcon: Icons.arrow_back_ios_new_rounded,
                ),
                const SizedBox(height: 80,),
                GuiderArrowAndText(
                  text: lang_key.swipeToEdit.tr,
                  arrowIcon: Icons.arrow_forward_ios_rounded,
                  shimmerDirection: ShimmerDirection.ltr,
                ),
              ],
            ),
        ),
        )
      ],
    );
  }

  /// Bottom sheet for choosing filter type
  showFilterBottomSheet(BuildContext context) {
    Get.bottomSheet(
        elevation: 8,
        Container(
          padding: const EdgeInsets.all(15),
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: kBorderRadius,
              color: Theme.of(context).colorScheme.primaryContainer
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      lang_key.searchBy.tr,
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    InkWell(
                      onTap: () => Get.back(),
                      child: const Icon(
                        Icons.close,
                        size: 18,
                        color: errorRed,
                      ),
                    )
                  ],
                ),
              ),
              const Divider(),
              Obx(() => Column(
                children: List.generate(viewModel.bottomSheetItems.length, (int index) {
                  return BottomSheetItem(
                    itemsList: viewModel.bottomSheetItems,
                    index: index,
                    chosenFilterValue: viewModel.chosenFilter,
                    goBack: true,
                  );
                }),
              ),
              ),
            ],
          ),
        )
    );
  }
}

/// Textfield for searching bank account
class SearchField extends StatelessWidget {
  SearchField({super.key});

  final BankAccountsListingViewModel viewModel = Get.find();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
      child: Row(
        children: [
          Expanded(
            flex: 7,
            child: CustomTextField(
              isSearchField: true,
              keyboardType: viewModel.chosenFilter.value == lang_key.accountIban.tr ? TextInputType.number : TextInputType.text,
              hintText: '${lang_key.searchBy.tr} ${viewModel.chosenFilter.value}',
              controller: viewModel.searchController,
              onChanged: (value) {
                if(value == '' || value.isEmpty) {
                  CommonFunctions.repopulateList(viewModel.allAccountsList, viewModel.visibleAccountsList);
                } else {
                  viewModel.searchAccount(value);
                }
              },
              enabled: viewModel.showBankAccounts.value,
              searchPrefixIconColor: viewModel.showBankAccounts.value ? null :  Theme.of(context).iconTheme.color!.withOpacity(0.5),
            ),
          ),
          const SizedBox(width: 10,),
          Expanded(
            child: CustomTextField(
              prefixIcon: Icon(
                Icons.filter_alt_outlined,
                size: 18,
                color: viewModel.showBankAccounts.value ? null : Theme.of(context).iconTheme.color!.withOpacity(0.5),
              ),
              readOnly: true,
              enabled: viewModel.showBankAccounts.value,
              onTap: () => BankAccountsListingView().showFilterBottomSheet(context),
            ),
          )
        ],
      ),
    );
  }
}

/// Bank Account details widget
class AccountDetailsWidget extends StatelessWidget {
  AccountDetailsWidget({super.key, required this.accountDetails});

  final BankAccount accountDetails;

  final BankAccountsListingViewModel viewModel = Get.find();

  @override
  Widget build(BuildContext context) {

    final strings = accountDetails.bankName!.split(' ');
    String text = '';
    for(var element in strings) {
      text = text + element[0];
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: SwipeActionCell(
        leadingActions: [
          SwipeAction(
            content: Container(
              height: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Icon(Icons.create_outlined, color: Get.isDarkMode ? primaryBlack : darkThemeLightGrey,),
              ),
            ),
            color: Get.isDarkMode ? darkThemeLightGrey : primaryBlack,
            backgroundRadius: kContainerRadius,
            onTap: (CompletionHandler handler) async => Get.toNamed(AppRoutes.editOrAddAccount, arguments: {'accountDetails': accountDetails}),
          )
        ],
        trailingActions: [
          SwipeAction(
            icon: const Icon(CupertinoIcons.delete_simple, color: backgroundWhite,),
            performsFirstActionWithFullSwipe: true,
            backgroundRadius: kContainerRadius,
            widthSpace: 65,
            onTap: (CompletionHandler handler) async {
              await handler(true);
              // viewModel.allAddressList.removeAt(index);
              // viewModel.allAddressList.refresh();
            },
          ),
        ],
        key: UniqueKey(),
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  height: 70,
                  width: 70,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: accountDetails.circleColor
                  ),
                  child: Text(
                    text,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: primaryBlack
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10,),
              Expanded(
                flex: 8,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 3,
                          child: Text(
                            accountDetails.bankName!,
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ),
                        if(accountDetails.isDefault!) Text(
                          lang_key.defaultAccount.tr,
                          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            fontWeight: FontWeight.w600
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            accountDetails.accountHolderName!,
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                          Text(
                            accountDetails.accountNumber!,
                            style: Theme.of(context).textTheme.labelSmall,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

/// Shimmer widget for loading
class AccountShimmer extends StatelessWidget {
  const AccountShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Theme.of(context).colorScheme.tertiaryContainer,
      highlightColor: Theme.of(context).colorScheme.tertiaryFixedDim,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 15.0, left: 15, right: 15),
          child: SizedBox(
            height: 70,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondaryContainer,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                const SizedBox(width: 10,),
                Expanded(
                  flex: 5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        height: 18,
                        width: Get.width * 0.5,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.secondaryContainer,
                          borderRadius: kBorderRadius
                        ),
                      ),
                      Container(
                        height: 10,
                        width: Get.width * 0.35,
                        decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.secondaryContainer,
                            borderRadius: kBorderRadius
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
    );
  }
}
