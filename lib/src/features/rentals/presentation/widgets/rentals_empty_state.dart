import 'package:aider_mobile_app/core/constants/colors.dart';
import 'package:aider_mobile_app/core/extensions/widgets/center_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/text_extension.dart';
import 'package:aider_mobile_app/core/utils/app_theme_util.dart';
import 'package:aider_mobile_app/src/features/rentals/presentation/widgets/rental_notice.dart';
import 'package:aider_mobile_app/src/shared_widgets/cards/app_card.dart';
import 'package:aider_mobile_app/src/shared_widgets/common/v_space.dart';
import 'package:flutter/material.dart';

import '../../../../shared_widgets/common/svg_icon.dart';


class RentalEmptyStateScreen extends StatelessWidget {
  const RentalEmptyStateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const RentalNotice(),
          const VSpace(height: 96),
          ZSvgIcon(
            'rental.svg',
            size: AppThemeUtil.radius(111),
            color: kGrey500,
          ).toCenter(),
          const VSpace(height: 20),
          const Text(
            'You’ve not rented any items, when\nyou do, it will appear here.',
            textAlign: TextAlign.center,
          ).semiBold().fontSize(16).color(kGrey1200).toCenter()
        ],
      ),
    );
  }
}
