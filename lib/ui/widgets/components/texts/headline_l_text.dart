import 'package:flutter/material.dart';

class HeadlineLText extends StatelessWidget {
  final String label;
  final Color? color;

  const HeadlineLText(this.label, {super.key, this.color});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: color),
      textAlign: TextAlign.center,
    );
  }
}
