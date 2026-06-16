import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import '../../../../../../shared/theme/app_theme.dart';

class ShimmerLoadingWidget extends StatelessWidget {

  const ShimmerLoadingWidget({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius,
    this.margin,
  });
  final double width;
  final double height;
  final BorderRadius? borderRadius;
  final EdgeInsets? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: Shimmer(
        color: context.textTertiaryColor,
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: context.surfaceColor,
            borderRadius:
                borderRadius ??
                BorderRadius.circular(
                  context.responsiveValue(small: 8, medium: 12, large: 16),
                ),
          ),
        ),
      ),
    );
  }
}

class ShimmerTextWidget extends StatelessWidget {
  final double width;
  final double? height;

  const ShimmerTextWidget({
    super.key,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      color: context.textTertiaryColor,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: context.surfaceColor,
          borderRadius: BorderRadius.circular(
            context.responsiveValue(small: 2, medium: 3, large: 4),
          ),
        ),
      ),
    );
  }
}
