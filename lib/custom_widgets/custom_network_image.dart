import 'package:adawat_provider_app/helpers/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomNetworkImage extends StatelessWidget {

  const CustomNetworkImage({
    super.key,
    this.imageUrl,
    this.boxShape,
    required this.height,
    required this.width,
    this.fit,
    this.placeholderImagePath,
    this.placeholderImagePadding = 0,
  }) : assert(imageUrl != null || placeholderImagePath != null, 'Either image URL must be provided or asset image'),
      assert(imageUrl == null || placeholderImagePath == null, 'Both Image URL and asset image cannot be provided');

  final String? imageUrl;
  final BoxShape? boxShape;
  final double height, width;
  final BoxFit? fit;
  final String? placeholderImagePath;
  final double placeholderImagePadding;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      height: height,
      width: width,
      imageUrl: imageUrl ?? '',
      imageBuilder: (context, imageProvider) {
        return boxShape == null ? ClipRRect(
          borderRadius: kBorderRadius,
          child: Image(image: imageProvider),
        ) : Container(
          decoration: BoxDecoration(
            shape: boxShape!,
            image: DecorationImage(
              image: imageProvider,
              fit: fit,
            ),
          ),
        );
      },
      errorWidget: (context, url, error) {
        return ClipRRect(
          borderRadius: kBorderRadius,
          child: Padding(
            padding: EdgeInsets.all(placeholderImagePadding),
            child: Image.asset(placeholderImagePath ?? 'assets/images/image_error.png', fit: BoxFit.fitHeight, color: Theme.of(context).colorScheme.secondary),
          ),
        );
      },
      placeholder: (context, url) {
        return const Center(
          child: CircularProgressIndicator(strokeWidth: 2.0),
        );
      },
    );
  }
}
