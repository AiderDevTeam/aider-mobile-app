
import 'package:aider_mobile_app/core/extensions/widgets/shimmer_extension.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/colors.dart';

class CachedImagePlaceholder extends StatelessWidget {
  const CachedImagePlaceholder({
    super.key,
    this.shape = BoxShape.rectangle,
  });

  final BoxShape shape;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kPrimaryWhite,
        shape: shape,
      ),
    ).applyShimmer();
  }
}
