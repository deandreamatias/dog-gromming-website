import 'package:flutter/material.dart';

class BodyLText extends StatelessWidget {
  final String label;
  final Color? color;

  const BodyLText(this.label, {super.key, this.color});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(color: color),
      textAlign: TextAlign.center,
    );
  }
}
