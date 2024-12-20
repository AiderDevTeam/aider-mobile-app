import 'package:aider_mobile_app/core/extensions/widgets/text_extension.dart';
import 'package:aider_mobile_app/core/utils/app_theme_util.dart';
import 'package:aider_mobile_app/src/shared_widgets/cards/app_card.dart';
import 'package:aider_mobile_app/src/shared_widgets/common/h_space.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/colors.dart';

class KycRejectionCard extends StatelessWidget {
  const KycRejectionCard({
    super.key,
    this.withBackground = false,
    this.borderRadius,
    this.reason,
  });

  final bool withBackground;
  final BorderRadius? borderRadius;
  final String? reason;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppThemeUtil.radius(14)),
      decoration: ShapeDecoration(
        color: const Color(0xFFFEECEB),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),

      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppCard(
            width: 20,
            height: 20,
            child: Icon(Icons.info, color: kError600,),
          ),
          const HSpace(width: 10),
          Text(
            '${reason?.toUpperCase()}',
            maxLines: 4,
          ).bold().fontSize(14).color(kPrimaryBlack),
        ],
      ),
    );
  }
}
