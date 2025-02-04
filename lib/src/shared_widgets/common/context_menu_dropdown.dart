import 'package:aider_mobile_app/core/extensions/widgets/text_extension.dart';
import 'package:aider_mobile_app/src/shared_widgets/common/svg_icon.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/colors.dart';
import '../../../core/utils/app_theme_util.dart';

class ContextMenuDropdown extends StatelessWidget {
  const ContextMenuDropdown({
    super.key,
    this.onChanged,
    this.offset = const Offset(-134, -10),
    this.dropdownWidth,
    this.items = const [],
  });

  final void Function(String?)? onChanged;
  final Offset offset;
  final double? dropdownWidth;
  final List<Map<String, dynamic>> items;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        customButton: ZSvgIcon(
          'dot_three.svg',
          color: kPrimaryBlack,
          size: AppThemeUtil.radius(24.0),
        ),
        items: items
            .map(
              (obj) => DropdownItem<String>(
                value: obj['value'],
                child: Text(
                  obj['name'] ?? '',
                )
                    .regular()
                    .fontSize(14.0)
                    .color(kAider700)
                    .textScale(TextScaler.noScaling),

                // Row(
                //   children: [
                //     obj['leadingWidget'] == null? ZSvgIcon(
                //       'dot_three.svg',
                //       color: kError700,
                //       size: AppThemeUtil.radius(24.0),
                //     ) : obj['leadingWidget'] as Widget,
                //     const HSpace(width: 12.0),
                //     Text(
                //       obj['name']?? '',
                //     ).regular().fontSize(14.0).color(kPrimaryBlack).textScale(TextScaler.noScaling),
                //   ],
                // ),
              ),
            )
            .toList(),
        onChanged: onChanged,
        dropdownStyleData: DropdownStyleData(
          width: AppThemeUtil.width(dropdownWidth ?? 152.0),
          padding: EdgeInsets.symmetric(vertical: AppThemeUtil.height(6.0)),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppThemeUtil.radius(16.0)),
            color: kPrimaryWhite,
          ),
          offset: offset,
        ),
      ),
    );
  }
}
