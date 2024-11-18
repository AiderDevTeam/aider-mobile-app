import 'package:aider_mobile_app/core/constants/colors.dart';
import 'package:aider_mobile_app/core/constants/common.dart';
import 'package:aider_mobile_app/core/extensions/widgets/gesture_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/padding_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/text_extension.dart';
import 'package:aider_mobile_app/core/routing/app_navigator.dart';
import 'package:aider_mobile_app/core/utils/app_theme_util.dart';
import 'package:aider_mobile_app/src/shared_widgets/cards/app_card.dart';
import 'package:aider_mobile_app/src/shared_widgets/common/v_space.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../../core/view_models/base_view.dart';
import '../../../../../shared_widgets/base/draggable_bottom_sheet.dart';
import '../../../../../shared_widgets/modals/draggable_bottom_sheet_content.dart';
import '../../view_models/product_view_model.dart';

class RentalPriceModal extends StatefulWidget {
  const RentalPriceModal({
    super.key,
    required this.prices,
    this.update = false,
    this.updatePrices,
  });

  final List<int> prices;
  final bool update;
  final List<Map<String, dynamic>>? updatePrices;

  @override
  State<RentalPriceModal> createState() => _RentalPriceModalState();
}

class _RentalPriceModalState extends State<RentalPriceModal> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if(mounted) context.read<ProductViewModel>().fetchPriceStructure();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableBottomSheet(
      initialChildSize: 0.60,
      minChildSize: 0.60,
      maxChildSize: 0.72,
      builder: (context, scrollController){
        return DraggableBottomSheetContent(
          draggableKey: GlobalKey(),
          scrollController: scrollController,
          title: 'Rental price (₦) per',
          content: BaseView<ProductViewModel>(
            builder: (context, productConsumer, child) {
              return ListView.builder(
                padding: EdgeInsets.symmetric(vertical: AppThemeUtil.height(20.0)),
                controller: scrollController,
                itemCount: productConsumer.getPriceStructure.length,
                itemBuilder: (context, index){
                  final price = productConsumer.getPriceStructure[index];
                  final selected = widget.update? (widget.updatePrices??[]).any((obj) => obj['startDay'] == price.startDay && obj['endDay'] == price.endDay) : widget.prices.contains(price.id);
                  return AppCard(
                    backgroundColor: selected? kAider100 : kGrey50,
                    padding: EdgeInsets.all(AppThemeUtil.radius(14.0)),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(price.name?? '').medium().fontSize(16.0).color(kGrey1200),
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              height: AppThemeUtil.radius(20.0),
                              width: AppThemeUtil.radius(20.0),
                              decoration: BoxDecoration(
                                color: selected? kAider800 : kPrimaryWhite,
                                shape: BoxShape.circle,
                                border: Border.all(color: selected? kAider800 : const Color(0xFFD0D5DD))
                              ),
                              child: Icon(
                                Icons.check,
                                color: kPrimaryWhite,
                                size: AppThemeUtil.radius(14.0),
                              ),
                            ),
                          ],
                        ),
                        const VSpace(height: 8.0),
                        Text(price.description?? '').regular().fontSize(14.0).color(kGrey1200).height(20.0, 14.0),
                      ],
                    ),
                  ).onPressed((){
                    if(selected) return;
                    if(widget.update){
                      AppNavigator.pop(context, {
                        "priceStructureId": price.id,
                        "startDay": price.startDay,
                        "endDay": price.endDay,
                        "name": price.endDay == null? '${price.startDay}+' : '${price.startDay}-${price.endDay}',
                      });
                      return;
                    }
                    AppNavigator.pop(context, price);
                  }).paddingOnly(bottom: 12);
                },
              );
            }
          ).paddingSymmetric(horizontal: kWidthPadding),
        );
      },
    );
  }
}
