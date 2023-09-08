import 'package:dog_gromming_website/ui/widgets/components/assets/svg_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';

class CircleLogo extends StatelessWidget {
  const CircleLogo({
    super.key,
    required this.circleRadius,
  });

  final double circleRadius;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      image: true,
      label: 'home.semantic_logo'.tr(),
      child: SizedBox(
        width: circleRadius * 2,
        height: circleRadius * 2,
        child: const SvgImage(
          imageName: 'logo',
          width: double.infinity,
          height: double.infinity,
        ),
      ),
    );
  }
}
