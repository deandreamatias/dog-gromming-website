import 'package:dog_gromming_website/ui/widgets/components/assets/svg_image.dart';
import 'package:flutter/material.dart';

class HomeButton extends StatelessWidget {
  final VoidCallback onPressed;
  const HomeButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: const SvgImage(imageName: 'logo'),
    );
  }
}
