import 'package:aider_mobile_app/core/constants/colors.dart';
import 'package:aider_mobile_app/core/utils/app_theme_util.dart';
import 'package:aider_mobile_app/src/shared_widgets/common/svg_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';


class RatingStarsWidget extends StatelessWidget {
  const RatingStarsWidget({
    super.key,
    required this.onRatingUpdate,
  });

  final void Function(double) onRatingUpdate;

  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
        glow: false,
        initialRating: 0,
        minRating: 1,
        direction: Axis.horizontal,
        itemCount: 5,
        itemPadding: EdgeInsets.symmetric(horizontal: AppThemeUtil.width(13.5)),
        itemBuilder: (context, _) => ZSvgIcon(
          'star.svg',
          color: kWarning700,
          size: AppThemeUtil.radius(64.0),
        ),
        onRatingUpdate: onRatingUpdate
    );
  }
}
