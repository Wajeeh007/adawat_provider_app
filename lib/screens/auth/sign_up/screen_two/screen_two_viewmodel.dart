// import 'package:geolocator/geolocator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:permission_handler/permission_handler.dart';

class ScreenTwoViewModel extends GetxController {

  // late GoogleMapController googleMapController;
  // late Position currentPosition;
  RxBool fetchingLocation = true.obs;
  TextEditingController labelController = TextEditingController();
  TextEditingController houseNumController = TextEditingController();
  TextEditingController streetNumController = TextEditingController();
  TextEditingController laneController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController buildingNameController = TextEditingController();
  TextEditingController nearbyLandmarkController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  TextEditingController numberController = TextEditingController();

  @override
  void onReady() async {
    // currentPosition = await _determinePosition();
    stopTimer();
    super.onReady();
  }

  @override
  void onClose() {
    // currentPosition = await _determinePosition();
    stopTimer();
    disposeVariables();
    super.onClose();
  }

  disposeVariables() {
    labelController.dispose();
    houseNumController.dispose();
    streetNumController.dispose();
    laneController.dispose();
    areaController.dispose();
    cityController.dispose();
    buildingNameController.dispose();
    nearbyLandmarkController.dispose();
    numberController.dispose();
    noteController.dispose();
  }

  stopTimer() {
    Future.delayed(const Duration(seconds: 5), () => fetchingLocation.value = false);
  }

  // Future<Position> _determinePosition() async {
  //   bool serviceEnabled;
  //   LocationPermission permission;
  //
  //   // Test if location services are enabled.
  //   serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //     // Location services are not enabled don't continue
  //     // accessing the position and request users of the
  //     // App to enable the location services.
  //     return Future.error('Location services are disabled.');
  //   }
  //
  //   permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.denied) {
  //       // Permissions are denied, next time you could try
  //       // requesting permissions again (this is also where
  //       // Android's shouldShowRequestPermissionRationale
  //       // returned true. According to Android guidelines
  //       // your App should show an explanatory UI now.
  //       return Future.error('Location permissions are denied');
  //     }
  //   }
  //
  //   if (permission == LocationPermission.deniedForever) {
  //     // Permissions are denied forever, handle appropriately.
  //     return Future.error(
  //         'Location permissions are permanently denied, we cannot request permissions.');
  //   }
  //
  //   return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  // }
  //
  //   getLocation() async {
  //
  // }
}