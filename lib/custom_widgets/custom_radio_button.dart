import 'package:flutter/material.dart';

class CustomRadioButton extends StatelessWidget {
  const CustomRadioButton({super.key, required this.isSelected});

  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: 18,
      width: 18,
      duration: const Duration(milliseconds: 350),
      padding: const EdgeInsets.all(4),
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            width: 0.8,
            color: isSelected ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.secondary,
          )
      ),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 350),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isSelected ? Theme.of(context).colorScheme.primary : Colors.transparent,
        ),
      ),
    );
  }
}