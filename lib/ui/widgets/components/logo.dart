import 'package:dog_gromming_website/ui/widgets/components/assets/svg_image.dart';
import 'package:flutter/widgets.dart';

class Logo extends StatelessWidget {
  const Logo({
    super.key,
    required this.semanticLabel,
    required this.width,
    required this.height,
    required this.imageName,
  });

  final String semanticLabel;
  final double? width;
  final double? height;
  final String imageName;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      image: true,
      label: semanticLabel,
      child: SizedBox(
        width: width,
        height: height,
        child: SvgImage(
          imageName: imageName,
          width: double.infinity,
          height: double.infinity,
        ),
      ),
    );
  }

  factory Logo.text({
    double? height,
    double? width,
    required String semanticLabel,
  }) => Logo(
    height: height,
    width: width,
    semanticLabel: semanticLabel,
    imageName: 'text_logo',
  );

  factory Logo.circle({
    required double radius,
    required String semanticLabel,
  }) => Logo(
    height: radius * 2,
    width: radius * 2,
    semanticLabel: semanticLabel,
    imageName: 'logo',
  );
}
