import 'package:aider_mobile_app/core/extensions/widgets/flexible_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/gesture_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/padding_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/text_extension.dart';
import 'package:aider_mobile_app/core/constants/colors.dart';
import 'package:aider_mobile_app/core/routing/app_navigator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/app_theme_util.dart';
import '../../../core/constants/common.dart';
import '../base/custom_scroll_behaviour.dart';
import 'modal_grab_bar.dart';

class BottomModalTitle extends StatelessWidget {
  const BottomModalTitle({
    super.key,
    required this.scrollController,
    this.title,
    this.titleTextStyle,
    this.modalHeaderContent,
    this.hasBottomBorder = true,
    this.goBack,
    this.onClose,
    this.stopScroll = false,
  });

  final ScrollController scrollController;
  final String? title;
  final TextStyle? titleTextStyle;
  final Widget? modalHeaderContent;
  final bool hasBottomBorder;
  final void Function()? goBack;
  final void Function()? onClose;
  final bool stopScroll;

  @override
  Widget build(BuildContext context) {
    return CustomScrollBehaviour(
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        controller: stopScroll? null : scrollController,
        child: Container(
          decoration: BoxDecoration(
            border: hasBottomBorder? Border(
              bottom: BorderSide(width: 1, color: AppThemeUtil.getThemeColor(kGrey200)),
            ) : null,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _HeaderPill(),
                ],
              ),

              (modalHeaderContent != null)?
              modalHeaderContent!
                  :
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  (goBack != null)?
                  Row(
                    children: [
                      Icon(
                        CupertinoIcons.arrow_left,
                        size: AppThemeUtil.radius(24.0),
                        color: AppThemeUtil.getThemeColor(kPrimaryBlack),
                      ).onPressed(goBack!),
                      Text(
                        title?? '',
                      ).extraBold().fontSize(16.0).color(kPrimaryBlack).overflowText(TextOverflow.ellipsis).paddingOnly(left: 16.0).flexible(),
                    ],
                  ).paddingOnly(right: 8.0).flexible()
                  :
                  Text(
                    title?? '',
                  ).extraBold().fontSize(16.0).color(kPrimaryBlack).overflowText(TextOverflow.ellipsis).paddingOnly(right: 8.0).flexible(),
                  Icon(
                    Icons.close,
                    size: AppThemeUtil.radius(24.0),
                    color: kGrey1200,
                  ).onPressed(() => onClose != null? onClose?.call() : AppNavigator.pop(context),),
                ],
              ).paddingOnly(left: kWidthPadding, right: kWidthPadding, bottom: 18.0),
            ],
          ),
        ),
      ),
    );
  }
}



class _HeaderPill extends StatelessWidget {
  const _HeaderPill();

  @override
  Widget build(BuildContext context) {
    return const ModalGrabBar().paddingOnly(top: 16.0, bottom: 32.0);
  }
}
