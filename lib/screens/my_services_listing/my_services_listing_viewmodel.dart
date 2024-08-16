import 'package:adawat_provider_app/models/service_category.dart';
import 'package:adawat_provider_app/models/service_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class MyServicesListingViewModel extends GetxController {

  /// Controller
  TextEditingController searchController = TextEditingController();

  /// Services List
  List<ServiceCategory> allMyServicesCategoryList = <ServiceCategory>[
    ServiceCategory(name: 'AC Services'),
    ServiceCategory(name: 'Electricity'),
    ServiceCategory(name: 'Plumbing'),
    ServiceCategory(name: 'Carpentry'),
    ServiceCategory(name: 'Cleaning'),
  ];

  RxList<ServiceCategory> visibleMyServicesCategoryList = <ServiceCategory>[].obs;
  
  /// Sub-Services list
  List<ServiceModel> allSubServicesList = <ServiceModel>[
    ServiceModel(
      categoryName: 'Installation',
      measuringUnit: 'Per Unit',
      price: 100,
      duration: '1',
    ),
    ServiceModel(
      categoryName: 'Repair',
      measuringUnit: 'Per Unit',
      price: 80,
      duration: '0.5 - 0.8'
    ),
    ServiceModel(
      categoryName: 'Service',
      measuringUnit: 'Per Unit',
      price: 150,
      duration: '2',
    )
  ];

  RxList<ServiceModel> visibleSubServiceList = <ServiceModel>[].obs;
  
  /// Loading Variables
  RxBool showSubServices = false.obs;
  RxBool showServicesCategory = false.obs;

  @override
  void onReady() {
    visibleSubServiceList.addAll(allSubServicesList);
    visibleSubServiceList.refresh();
    visibleMyServicesCategoryList.addAll(allMyServicesCategoryList);
    visibleMyServicesCategoryList.refresh();
    Future.delayed(const Duration(seconds: 3), () => showServicesCategory.value = true);
    super.onReady();
  }

  @override
  void onClose() {
    showServicesCategory.value = false;
    showSubServices.value = false;
    visibleMyServicesCategoryList.clear();
    visibleSubServiceList.clear();
    super.onClose();
  }

  /// Search service from categories list and sub-services
  searchItem(String value) {
    visibleMyServicesCategoryList.clear();
    visibleSubServiceList.clear();
    for(var element in allMyServicesCategoryList) {
      if(element.name!.toLowerCase().contains(value.toLowerCase())) {
        visibleMyServicesCategoryList.add(element);
      }
    }
  }
}