import 'package:aider_mobile_app/core/utils/app_theme_util.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../constants/colors.dart';

extension ShimmerLoadingEffect on Widget{

  Widget applyShimmer(
      {bool enable = true, Color? baseColor, Color? highlightColor}) {
    if (enable) {
      return Shimmer.fromColors(
        baseColor: baseColor??  AppThemeUtil.getThemeColor(kGrey100),
        highlightColor: highlightColor??  AppThemeUtil.getThemeColor(kGrey100.withOpacity(0.1)),
        child: this,
      );
    } else {
      return this;
    }
  }

}