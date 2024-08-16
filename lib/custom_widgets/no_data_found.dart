import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NoDataFound extends StatelessWidget {
  const NoDataFound({super.key, required this.text, this.icon, this.image});

  final String text;
  final IconData? icon;
  final String? image;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            image != null ? Image.asset(
              image!,
              height: Get.height * 0.3,
              width: Get.width * 0.25,
            ) : Icon(
              icon ?? Icons.error_outline_rounded,
              size: 40,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                text,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w400
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
