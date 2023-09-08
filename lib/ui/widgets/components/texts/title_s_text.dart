import 'package:flutter/material.dart';

class TitleSText extends StatelessWidget {
  final String label;
  final Color? color;

  const TitleSText(
    this.label, {
    super.key,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: Theme.of(context).textTheme.titleSmall?.copyWith(color: color),
      textAlign: TextAlign.center,
    );
  }
}
