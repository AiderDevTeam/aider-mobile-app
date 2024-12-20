import 'package:aider_mobile_app/core/constants/colors.dart';
import 'package:aider_mobile_app/core/extensions/widgets/expanded_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/text_extension.dart';
import 'package:aider_mobile_app/core/utils/app_theme_util.dart';
import 'package:aider_mobile_app/src/features/rentals/presentation/widgets/confirm_pickup_modal.dart';
import 'package:aider_mobile_app/src/shared_widgets/buttons/app_primary_button.dart';
import 'package:aider_mobile_app/src/shared_widgets/cards/app_card.dart';
import 'package:aider_mobile_app/src/shared_widgets/common/app_bottom_nav_wrapper.dart';
import 'package:aider_mobile_app/src/shared_widgets/common/h_space.dart';
import 'package:aider_mobile_app/src/shared_widgets/common/v_space.dart';
import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';
import '../../../../../core/utils/app_dialog_util.dart';
import '../../../../shared_widgets/base/draggable_bottom_sheet.dart';
import '../../../../shared_widgets/modals/draggable_bottom_sheet_content.dart';

class QualityAssuranceModal extends StatefulWidget {
  const QualityAssuranceModal({
    super.key,
    required this.onYesPressed,
    this.onNoPressed,
  });
  final void Function() onYesPressed;
  final void Function()? onNoPressed;

  @override
  State<QualityAssuranceModal> createState() => _QualityAssuranceModalState();
}

class _QualityAssuranceModalState extends State<QualityAssuranceModal> {
  int? wornOut;
  int? damaged;
  @override
  Widget build(BuildContext context) {
    return DraggableBottomSheet(
      initialChildSize: 0.75,
      minChildSize: 0.65,
      maxChildSize: 0.85,
      builder: (context, scrollController) {
        return DraggableBottomSheetContent(
          bottomNavigationBar: AppBottomNavWrapper(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Do you still want to continue with pickup',
                ).semiBold().fontSize(14).color(kGrey1200),
                const VSpace(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppPrimaryButton(
                      text: "No Report",
                      textColor: kGrey1000,
                      borderColor: kGrey1000,
                      color: kPrimaryWhite,
                      minWidth: AppThemeUtil.width(181.50),
                      height: AppThemeUtil.height(52),
                      onPressed: () async{
                        AppDialogUtil.showScrollableBottomSheet(
                          context: context,
                          builder: (context) => ConfirmPickupModal(
                              title: "Are you sure?\nIf you continue, a report would be sent\nto customer care to investigate.",
                              onYesPressed: () async{

                              },
                          )
                        );
                      },
                    ),
                    AppPrimaryButton(
                      text: "Yes, Accept",
                      minWidth: AppThemeUtil.width(181.50),
                      height: AppThemeUtil.height(52),
                      onPressed: widget.onYesPressed,
                    )
                  ],
                ),
              ],
            ),
          ),
          draggableKey: GlobalKey(),
          scrollController: scrollController,
          hasBottomBorder: false,
          title: 'Quality Assurance',
          content: Container(
            padding: EdgeInsets.all(AppThemeUtil.radius(20)),
            color: kPrimaryWhite,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Text(
                    'Please complete the form below for quality assurance and to ensure the item is in good working condition.',
                  ).regular().fontSize(14).color(kGrey800),
                  const VSpace(height: 24),
                  AppCard(
                    width: double.infinity,
                    padding: EdgeInsets.all(AppThemeUtil.radius(12)),
                    decoration: ShapeDecoration(
                      color: kGrey50,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppThemeUtil.radius(12)),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppCard(
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text(
                                'Is the item damaged?',
                              ).semiBold().fontSize(14).color(kGrey1200).expanded(),
                              HSpace(width: AppThemeUtil.width(8)),
                              ToggleSwitch(
                                minWidth: 45.0,
                                minHeight: 26.0,
                                fontSize: 12.0,
                                initialLabelIndex: damaged ?? 0,
                                activeBgColor: const [kGrey1200],
                                activeFgColor: kPrimaryWhite,
                                inactiveBgColor: kGrey200,
                                inactiveFgColor: kGrey500,
                                totalSwitches: 2,
                                labels: const ['No', 'Yes'],
                                onToggle: (index) {
                                  setState(() {
                                    damaged = index;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                        const VSpace(height: 24),
                        AppCard(
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text(
                                'Are there worn out part?',
                              ).semiBold().fontSize(14).color(kGrey1200).expanded(),
                              HSpace(width: AppThemeUtil.width(8)),
                              ToggleSwitch(
                                minWidth: 45.0,
                                minHeight: 26.0,
                                fontSize: 12.0,
                                initialLabelIndex: wornOut ?? 0,
                                activeBgColor: const [kGrey1200],
                                activeFgColor: kPrimaryWhite,
                                inactiveBgColor: kGrey200,
                                inactiveFgColor: kGrey500,
                                totalSwitches: 2,
                                labels: const ['No', 'Yes'],
                                onToggle: (index) {
                                  setState(() {
                                    wornOut = index!;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                        const VSpace(height: 24),
                        const Text("Responsibility Acknowledgement").semiBold().fontSize(14).color(kGrey1200),
                        const VSpace(height: 24),
                        const Text("• I understand that I am responsible for the item while it is in my possession.").regular().fontSize(14).color(kGrey1200),
                        const VSpace(height: 16),
                        const Text("• I agree to return the item in the same condition I received it, accounting for normal wear and tear.").regular().fontSize(14).color(kGrey1200),
                        const VSpace(height: 16),
                        const Text("• I agree to compensate the vendor for any damage or loss beyond normal wear and tear.").regular().fontSize(14).color(kGrey1200),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        );
      },
    );
  }
}
