import 'package:flutter/material.dart';

class LabelLText extends StatelessWidget {
  final String label;
  final Color? color;

  const LabelLText(
    this.label, {
    super.key,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: Theme.of(context).textTheme.labelLarge?.copyWith(color: color),
      textAlign: TextAlign.center,
    );
  }
}
