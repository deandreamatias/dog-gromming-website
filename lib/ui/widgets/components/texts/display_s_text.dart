import 'package:flutter/material.dart';

class DisplaySText extends StatelessWidget {
  final String label;
  final Color? color;

  const DisplaySText(
    this.label, {
    super.key,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: Theme.of(context).textTheme.displaySmall?.copyWith(color: color),
      textAlign: TextAlign.center,
    );
  }
}
