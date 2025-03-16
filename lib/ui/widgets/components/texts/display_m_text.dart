import 'package:flutter/material.dart';

class DisplayMText extends StatelessWidget {
  final String label;
  final Color? color;

  const DisplayMText(this.label, {super.key, this.color});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: Theme.of(context).textTheme.displayMedium?.copyWith(color: color),
      textAlign: TextAlign.center,
    );
  }
}
