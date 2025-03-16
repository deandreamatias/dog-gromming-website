import 'package:flutter/material.dart';

class HeadlineMText extends StatelessWidget {
  final String label;
  final Color? color;

  const HeadlineMText(this.label, {super.key, this.color});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: color),
      textAlign: TextAlign.center,
    );
  }
}
