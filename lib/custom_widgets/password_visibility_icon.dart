import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PasswordVisibilityIcon extends StatelessWidget {
  const PasswordVisibilityIcon({super.key, required this.visibility});

  final RxBool visibility;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () => visibility.value = !visibility.value,
        icon: Icon(visibility.value ? Icons.visibility_off_outlined : Icons.visibility_outlined
        )
    );
  }
}
