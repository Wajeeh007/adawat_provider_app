import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../helpers/constants.dart';
import 'package:adawat_provider_app/helpers/languages/translations_key.dart' as lang_key;

class Guider extends StatelessWidget {
  const Guider({
    super.key,
    required this.guiderBool,
    this.colors,
    this.children,
    this.child
  }) : assert(children != null || child != null, 'Either child or children must be provided'),
      assert(children == null || child == null, 'Cannot provide both children and child');

  final RxBool guiderBool;
  final List<Color>? colors;
  final List<Widget>? children;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Obx(() => Visibility(
        visible: guiderBool.value,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => guiderBool.value = false,
          child: Container(
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 15),
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: colors ?? [primaryBlack.withOpacity(0.7), primaryBlack.withOpacity(0.9)]
                )
            ),
            child: Center(
              child: child ?? Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 7,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: children!,
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Text(
                        lang_key.tapToRemoveGuider.tr,
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: backgroundWhite
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}