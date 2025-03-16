import 'package:flutter/material.dart';

class BodyMText extends StatelessWidget {
  final String label;
  final Color? color;
  final TextAlign? textAlign;

  const BodyMText(this.label, {super.key, this.color, this.textAlign});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: color),
      textAlign: textAlign,
    );
  }
}
