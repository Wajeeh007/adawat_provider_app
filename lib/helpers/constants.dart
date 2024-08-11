import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Colors
const primaryBlack = Color(0xff0b0c0c);
const primaryGrey = Color(0xff2a2e34);
const primaryWhite = Color(0xffe9eaec);
const primaryYellow = Color(0xfffbe134);
const primaryDullYellow = Color(0xffe4b61a);
const darkThemeLightGrey = Color(0xffcecece);
const errorRed = Color(0xffef0000);
const backgroundWhite = Colors.white;
const lightThemeBorderGrey = Color(0xffe0e0e0);
Color darkModeShimmerBaseGrey = Colors.grey.shade900;
Color darkModeShimmerHighGrey = Colors.grey.shade800;
Color lightModeShimmerBaseGrey = Colors.grey.shade400;
Color lightModeShimmerHighGrey = Colors.grey.shade200;
Color lightModeShadowGrey = darkThemeLightGrey;
const pendingStatusBgColor = Color(0xffffcccc);
const completedStatusBgColor = Color(0xffb7f9a9);
const completedTextColor = Colors.green;
const lightModeTextGreyAndShadow = Color(0xff9e9e9e);

/// Container Shadow
List<BoxShadow> kShadow = [
  BoxShadow(
      offset: const Offset(0, 10),
      spreadRadius: 0.1,
      blurRadius: 20,
      color: Get.context!.theme.shadowColor
  )];

/// Border Radius
BorderRadius kBorderRadius = BorderRadius.circular(kContainerRadius);

/// Numerical Constants
const kContainerRadius = 15.0;
const constraintSubtractValue = 30;

/// Type of status
enum ContainerType {pending, completed, cancelled}

/// Months list
const List<String> months = [
  'January',
  'February',
  'March',
  'April',
  'May',
  'June',
  'July',
  'August',
  'September',
  'October',
  'November',
  'December'
];