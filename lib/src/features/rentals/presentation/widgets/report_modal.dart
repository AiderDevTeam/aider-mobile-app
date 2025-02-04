import 'package:aider_mobile_app/core/constants/common.dart';
import 'package:aider_mobile_app/core/extensions/widgets/padding_extension.dart';
import 'package:aider_mobile_app/core/utils/app_theme_util.dart';
import 'package:aider_mobile_app/src/features/rentals/domain/models/booking/booking_model.dart';
import 'package:aider_mobile_app/src/features/rentals/presentation/providers/rental_provider.dart';
import 'package:aider_mobile_app/src/shared_widgets/base/draggable_bottom_sheet.dart';
import 'package:aider_mobile_app/src/shared_widgets/buttons/app_primary_button.dart';
import 'package:aider_mobile_app/src/shared_widgets/common/app_bottom_nav_wrapper.dart';
import 'package:aider_mobile_app/src/shared_widgets/modals/draggable_bottom_sheet_content.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../shared_widgets/forms/app_input_field.dart';

class ReportModal extends StatefulWidget {
  const ReportModal({super.key, required this.booking, required this.isVendor});

  final BookingModel booking;
  final bool isVendor;

  @override
  State<ReportModal> createState() => _ReportModalState();
}

class _ReportModalState extends State<ReportModal> {
  final formKey = GlobalKey<FormState>();
  AutovalidateMode autoValidate = AutovalidateMode.disabled;
  final _reasonController = TextEditingController();

  @override
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableBottomSheet(
        initialChildSize: 0.65,
        minChildSize: 0.50,
        maxChildSize: 0.70,
        builder: (context, controller) {
          return DraggableBottomSheetContent(
            title: "Report",
            stopScroll: true,
            draggableKey: GlobalKey(),
            scrollController: controller,
            hasBottomBorder: false,
            bottomNavigationBar: AppBottomNavWrapper(
              child: AppPrimaryButton(
                minWidth: double.infinity,
                height: AppThemeUtil.height(52),
                text: "Submit",
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    if (widget.isVendor) {
                      context.read<RentalProvider>().reportBooking(
                            context: context,
                            externalId: widget.booking.vendor!.externalId!,
                            bookingId: widget.booking.id!,
                            andReason: _reasonController.text,
                          );
                    } else {
                      context.read<RentalProvider>().reportBooking(
                            context: context,
                            externalId: widget.booking.user!.externalId!,
                            bookingId: widget.booking.id!,
                            andReason: _reasonController.text,
                          );
                    }
                  } else {
                    setState(() =>
                        autoValidate = AutovalidateMode.onUserInteraction);
                  }
                },
              ),
            ),
            content: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Form(
                    key: formKey,
                    autovalidateMode: autoValidate,
                    child: Column(
                      children: [
                        const Text(
                          "Please write in details the issues you're facing with the renter concerning this rental",
                          maxLines: 2,
                        ),
                        const SizedBox(height: 20),
                        AppInputField(
                          controller: _reasonController,
                          maxLine: 5,
                          validator: (value) {
                            if (value!.isEmpty)
                              return 'You must have a report reason';

                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ).paddingSymmetric(horizontal: kWidthPadding),
            ),
          );
        });
  }
}
