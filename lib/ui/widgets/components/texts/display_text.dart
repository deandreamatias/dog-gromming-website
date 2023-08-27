import 'package:flutter/material.dart';

class DisplayText extends StatelessWidget {
  final String label;
  const DisplayText(this.label, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: Theme.of(context).textTheme.displayMedium,
      textAlign: TextAlign.center,
    );
  }
}
