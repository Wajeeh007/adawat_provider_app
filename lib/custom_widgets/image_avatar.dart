import 'package:flutter/material.dart';

import 'custom_network_image.dart';

class ImageAvatar extends StatelessWidget {
  const ImageAvatar({super.key, this.url, this.heightAndWidth = 40});

  final String? url;
  final double heightAndWidth;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: url == null ? Image.asset(
        'assets/images/person_circle.png',
        color: Theme.of(context).colorScheme.secondary,
        fit: BoxFit.fitHeight,
        height: heightAndWidth,
        width: heightAndWidth,
      ) : CustomNetworkImage(
        height: heightAndWidth,
        width: heightAndWidth,
        boxShape: BoxShape.circle,
      )
    );
  }
}
