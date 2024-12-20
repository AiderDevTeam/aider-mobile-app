import 'package:aider_mobile_app/core/extensions/widgets/flexible_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/gesture_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/text_extension.dart';
import 'package:aider_mobile_app/src/shared_widgets/common/h_space.dart';
import 'package:flutter/material.dart';

import '../../../../../core/constants/colors.dart';
import '../../../../../core/utils/app_theme_util.dart';
import '../../../../shared_widgets/cards/app_card.dart';

class RentalNotice extends StatelessWidget {
  const RentalNotice({super.key});

  @override
  Widget build(BuildContext context) {
    return AppCard(
        width: double.infinity,
        padding: EdgeInsets.all(AppThemeUtil.radius(14)),
        decoration: ShapeDecoration(
          color: kBlue100,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        alignment: Alignment.center,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Icon(Icons.info, color: kBlue800,),
            const HSpace(width: 10),
            const Text("You will be able to confirm pickup and return of items rented from others here, and also see the duration and rental details").regular().fontSize(14).color(kGrey800).flexible(),
            const HSpace(width: 10),
            const Icon(Icons.close).onPressed((){

            })
          ],
        )
    );
  }
}
