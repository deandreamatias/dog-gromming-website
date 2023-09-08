import 'package:flutter/material.dart';

class BodyMText extends StatelessWidget {
  final String label;
  final Color? color;

  const BodyMText(
    this.label, {
    super.key,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: color),
      textAlign: TextAlign.center,
    );
  }
}
