import 'package:adawat_provider_app/models/service_category.dart';
import 'package:adawat_provider_app/models/service_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class MyServicesListingViewModel extends GetxController {

  /// Controller
  TextEditingController searchController = TextEditingController();

  /// Services List
  RxList<ServiceCategory> myServicesList = <ServiceCategory>[
    ServiceCategory(name: 'AC Services', selected: false),
    ServiceCategory(name: 'Electricity', selected: false),
    ServiceCategory(name: 'Plumbing', selected: false),
    ServiceCategory(name: 'Carpentry', selected: false),
    ServiceCategory(name: 'Cleaning', selected: false),
  ].obs;

  /// Sub-Services list
  RxList<ServiceModel> mySubServicesList = <ServiceModel>[
    ServiceModel(
      serviceName: 'Installation',
      measuringUnit: 'Per Unit',
      price: 100,
      duration: '1',
    ),
    ServiceModel(
      serviceName: 'Repair',
      measuringUnit: 'Per Unit',
      price: 80,
      duration: '0.5 - 0.8'
    ),
    ServiceModel(
      serviceName: 'Service',
      measuringUnit: 'Per Unit',
      price: 150,
      duration: '2',
    )
  ].obs;

  /// Loading Variables
  RxBool showSubServices = false.obs;

}