import 'package:flutter/widgets.dart';

class CommonImage extends StatelessWidget {
  final String imageName;
  final double? width;
  final double? height;

  const CommonImage({
    super.key,
    required this.imageName,
    this.width = 72,
    this.height = 72,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/$imageName.png',
      width: width,
      height: height,
      fit: BoxFit.cover,
    );
  }
}
