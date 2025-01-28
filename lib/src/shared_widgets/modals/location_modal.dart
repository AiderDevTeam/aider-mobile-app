import 'package:aider_mobile_app/core/extensions/widgets/padding_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/text_extension.dart';
import 'package:aider_mobile_app/core/routing/app_navigator.dart';
import 'package:aider_mobile_app/src/shared_widgets/common/app_list_tile.dart';
import 'package:aider_mobile_app/src/shared_widgets/common/v_space.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../../../core/utils/app_theme_util.dart';
import '../../../core/providers/base_view.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/common.dart';
import '../../../core/providers/location_provider.dart';
import '../base/draggable_bottom_sheet.dart';
import '../forms/app_input_field.dart';
import 'draggable_bottom_sheet_content.dart';

class LocationModal extends StatefulWidget {
  const LocationModal({
    super.key,
  });

  @override
  State<LocationModal> createState() => _LocationModalState();
}

class _LocationModalState extends State<LocationModal> {
  final locationController = TextEditingController();

  @override
  void dispose() {
    locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableBottomSheet(
      initialChildSize: 0.7,
      minChildSize: 0.45,
      maxChildSize: 0.70,
      builder: (context, scrollController) {
        return DraggableBottomSheetContent(
          draggableKey: GlobalKey(),
          scrollController: scrollController,
          modalHeaderContent: AppInputField(
            controller: locationController,
            hintText: 'Search location',
            keyboardType: TextInputType.text,
            autofocus: true,
            helperHeight: 0.5,
            onChanged: (query) {
              if ((query ?? '').isNotEmpty)
                context.read<LocationProvider>().searchLocation(query ?? '');
            },
          ).paddingOnly(left: kWidthPadding, right: kWidthPadding),
          content: BaseView<LocationProvider>(
              builder: (context, locationConsumer, child) {
            if (locationConsumer.getLocationPrediction.isEmpty) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Searching location....')
                      .semiBold()
                      .color(kPrimaryBlack)
                      .fontSize(16.0)
                      .alignText(TextAlign.center),
                  const VSpace(height: 4.0),
                  const Text('No location found yet')
                      .regular()
                      .color(kPrimaryBlack)
                      .fontSize(12.0)
                      .alignText(TextAlign.center),
                ],
              ).paddingSymmetric(vertical: 32, horizontal: 16.0);
            }
            return ListView.builder(
              padding: const EdgeInsets.all(kWidthPadding),
              controller: scrollController,
              shrinkWrap: true,
              itemCount: locationConsumer.getLocationPrediction.length,
              itemBuilder: (context, index) {
                final location = locationConsumer.getLocationPrediction[index];
                return AppListTile(
                  onTap: () {
                    AppNavigator.pop(context, {
                      'city': location.structuredFormatting?['main_text'],
                      "originName": location.description,
                      "placeId": location.placeId,
                    });
                  },
                  leading: Icon(
                    CupertinoIcons.map_pin_ellipse,
                    size: AppThemeUtil.radius(20.0),
                    color: kPrimaryBlack,
                  ),
                  title: Text('${location.description}')
                      .semiBold()
                      .color(kPrimaryBlack)
                      .fontSize(14.0)
                      .textMaxLines(2)
                      .overflowText(TextOverflow.ellipsis),
                );
              },
            );
          }),
        );
      },
    );
  }
}
