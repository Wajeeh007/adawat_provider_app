import 'package:adawat_provider_app/custom_widgets/custom_appbar.dart';
import 'package:adawat_provider_app/custom_widgets/custom_textfield.dart';
import 'package:adawat_provider_app/custom_widgets/no_data_found.dart';
import 'package:adawat_provider_app/helpers/common_functions.dart';
import 'package:adawat_provider_app/helpers/routes.dart';
import 'package:adawat_provider_app/screens/my_services_listing/my_services_listing_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:adawat_provider_app/helpers/languages/translations_key.dart' as lang_key;
import '../../custom_widgets/service_category_and_services.dart';

class MyServicesListingView extends StatelessWidget {
  MyServicesListingView({super.key});

  final MyServicesListingViewModel viewModel = Get.put(MyServicesListingViewModel());
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleText: lang_key.myServices.tr,
        action: [
          IconButton(
              onPressed: () => Get.toNamed(AppRoutes.addService),
              icon: const Icon(
                Icons.add_circle_outline_rounded,
                size: 25,
              )
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Obx(() => Column(
            children: [
              CustomTextField(
                isSearchField: true,
                controller: viewModel.searchController,
                hintText: lang_key.searchYourService.tr,
                onChanged: (value) {
                  if(value == '' || value.isEmpty) {
                    CommonFunctions.repopulateList(viewModel.allMyServicesCategoryList, viewModel.visibleMyServicesCategoryList);
                  } else {
                    viewModel.searchItem(value);
                  }
                },
                enabled: viewModel.showServicesCategory.value,
              ),
              viewModel.visibleMyServicesCategoryList.isEmpty ? NoDataFound(
                  text: lang_key.noServiceFound.tr
              ) : GridView.builder(
                  shrinkWrap: true,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                      mainAxisSpacing: 15,
                      crossAxisSpacing: 10,
                      childAspectRatio: 0.7
                    ),
                    itemCount: viewModel.showServicesCategory.value ? viewModel.visibleMyServicesCategoryList.length : 6,
                    itemBuilder: (context, index) {
                      return viewModel.showServicesCategory.value ? ServiceCategoryAndServices(
                          item: viewModel.visibleMyServicesCategoryList[index],
                        showSubServices: viewModel.showSubServices,
                        mySubServicesList: viewModel.visibleSubServiceList,
                      ) : const ServiceCategoryShimmer();
                    }
                ),
            ],
          ),
        ),
      ),
    );
  }
}