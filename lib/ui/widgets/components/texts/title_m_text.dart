import 'package:flutter/material.dart';

class TitleMText extends StatelessWidget {
  final String label;
  final Color? color;

  const TitleMText(this.label, {super.key, this.color});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(color: color),
      textAlign: TextAlign.center,
    );
  }
}
