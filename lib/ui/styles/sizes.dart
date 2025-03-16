enum Sizes { xs, s, m, l, xl }

extension ResponsiveSizes on Sizes {
  double get width {
    switch (this) {
      case Sizes.xs:
        return 320;
      case Sizes.s:
        return 768;
      case Sizes.m:
        return 1024;
      case Sizes.l:
        return 1440;
      case Sizes.xl:
        return 1920;
    }
  }
}
