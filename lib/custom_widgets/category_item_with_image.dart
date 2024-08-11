import 'package:flutter/material.dart';
import '../helpers/constants.dart';
import '../models/service_category.dart';

class CategoryItemWithImage extends StatelessWidget {
  const CategoryItemWithImage({super.key, required this.item, this.onTap});

  final ServiceCategory item;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(
                      color: Colors.transparent,
                      width: 1.2
                  ),
                  borderRadius: kBorderRadius,
                  color: Colors.transparent,
                ),
                child: SizedBox(
                  width: 80,
                  height: 80,
                  child: ClipRRect(
                    borderRadius: kBorderRadius,
                    child: Image.asset(
                      'assets/images/category_example_image.png',
                      fit: BoxFit.cover,
                  ),
                ),
                )
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: SizedBox(
                width: 65,
                child: Text(
                  item.name!,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    fontSize: 11,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
