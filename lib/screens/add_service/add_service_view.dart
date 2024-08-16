import 'package:adawat_provider_app/custom_widgets/custom_appbar.dart';
import 'package:adawat_provider_app/custom_widgets/no_data_found.dart';
import 'package:adawat_provider_app/screens/add_service/add_service_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:adawat_provider_app/helpers/languages/translations_key.dart' as lang_key;
import '../../custom_widgets/custom_textfield.dart';
import '../../custom_widgets/service_category_and_services.dart';

class AddServiceView extends StatelessWidget {
  AddServiceView({super.key});

  final AddServiceViewModel viewModel = Get.put(AddServiceViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleText: lang_key.addNewService.tr,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
        child: Obx(() => Column(
            children: [
              CustomTextField(
                isSearchField: true,
                controller: viewModel.searchController,
                hintText: lang_key.searchService.tr,
                onChanged: (value) {
                  if(value == '' || value.isEmpty) {
                    viewModel.repopulateLists();
                  } else {
                    viewModel.searchItem(value);
                  }
                },
                enabled: viewModel.showServicesCategory.value,
              ),
              viewModel.visibleServiceCategoryList.isEmpty ? NoDataFound(
                  text: lang_key.noServiceFound.tr
              ) : GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 15,
                      crossAxisSpacing: 10,
                      childAspectRatio: 0.7
                  ),
                  itemCount: viewModel.showServicesCategory.value ? viewModel.visibleServiceCategoryList.length : 6,
                  itemBuilder: (context, index) {
                    return viewModel.showServicesCategory.value ? ServiceCategoryAndServices(
                      item: viewModel.visibleServiceCategoryList[index],
                      showSubServices: viewModel.showSubServices,
                      toAddServiceList: viewModel.visibleSubServiceList,
                      toAdd: true,
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