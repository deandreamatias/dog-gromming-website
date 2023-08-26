enum Sizes {
  small,
  medium,
  large,
  extraLarge,
}

extension ResponsiveSizes on Sizes {
  double get width {
    switch (this) {
      case Sizes.small:
        return 320;
      case Sizes.medium:
        return 768;
      case Sizes.large:
        return 1024;
      case Sizes.extraLarge:
        return 1440;
      default:
        return 0;
    }
  }
}
