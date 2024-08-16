import 'package:adawat_provider_app/models/service_category.dart';
import 'package:adawat_provider_app/models/service_model.dart';
import 'package:adawat_provider_app/screens/add_service/service_model_extended.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AddServiceViewModel extends GetxController {

  /// Controller(s)
  TextEditingController searchController = TextEditingController();

  /// Service Category lists
  List<ServiceCategory> allServiceCategoryList = <ServiceCategory>[
    ServiceCategory(name: 'AC Services', numberOfServices: 2),
    ServiceCategory(name: 'Electricity', numberOfServices: 5),
    ServiceCategory(name: 'Plumbing', numberOfServices: 1),
    ServiceCategory(name: 'Carpentry', numberOfServices: 1),
    ServiceCategory(name: 'Cleaning', numberOfServices: 3),
  ];

  RxList<ServiceCategory> visibleServiceCategoryList = <ServiceCategory>[].obs;

  /// Sub-Services lists
  List<ServiceModelExtended> allSubServicesList = <ServiceModelExtended>[
    ServiceModelExtended(
      serviceModel: ServiceModel(
        categoryName: 'Installation',
        measuringUnit: 'Per Unit',
        price: 100,
        duration: '1',
      ),
      isAdded: false
    ),
    ServiceModelExtended(
      serviceModel: ServiceModel(
          categoryName: 'Repair',
          measuringUnit: 'Per Unit',
          price: 80,
          duration: '0.5 - 0.8'
      ),
      isAdded: true,
    ),
    ServiceModelExtended(
      serviceModel: ServiceModel(
        categoryName: 'Service',
        measuringUnit: 'Per Unit',
        price: 150,
        duration: '2',
      ),
      isAdded: true
    )
  ];

  RxList<ServiceModelExtended> visibleSubServiceList = <ServiceModelExtended>[].obs;

  /// Loading Variables
  RxBool showServicesCategory = false.obs;
  RxBool showSubServices = false.obs;

  @override
  void onReady() {
    visibleSubServiceList.addAll(allSubServicesList);
    visibleSubServiceList.refresh();
    visibleServiceCategoryList.addAll(allServiceCategoryList);
    visibleServiceCategoryList.refresh();
    Future.delayed(const Duration(seconds: 3), () => showServicesCategory.value = true);
    super.onReady();
  }

  @override
  void onClose() {
    showServicesCategory.value = false;
    showSubServices.value = false;
    visibleServiceCategoryList.clear();
    visibleSubServiceList.clear();
    super.onClose();
  }

  repopulateLists() {
    visibleServiceCategoryList.clear();
    visibleSubServiceList.clear();
    visibleServiceCategoryList.addAll(allServiceCategoryList);
    visibleSubServiceList.addAll(allSubServicesList);
    visibleSubServiceList.refresh();
    visibleServiceCategoryList.refresh();
  }

  searchItem(String value) {
    visibleServiceCategoryList.clear();
    visibleSubServiceList.clear();
    for(var element in allServiceCategoryList) {
      if(element.name!.toLowerCase().contains(value.toLowerCase())) {
        visibleServiceCategoryList.add(element);
      }
    }
  }
}