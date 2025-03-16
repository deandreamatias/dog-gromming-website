import 'package:flutter/material.dart';

class TitleLText extends StatelessWidget {
  final String label;
  final Color? color;

  const TitleLText(this.label, {super.key, this.color});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(color: color),
      textAlign: TextAlign.center,
    );
  }
}
