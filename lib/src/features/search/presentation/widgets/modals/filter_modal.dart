import 'package:aider_mobile_app/core/constants/colors.dart';
import 'package:aider_mobile_app/core/extensions/widgets/expanded_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/gesture_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/padding_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/text_extension.dart';
import 'package:aider_mobile_app/src/shared_widgets/buttons/app_primary_button.dart';
import 'package:aider_mobile_app/src/shared_widgets/cards/app_card.dart';
import 'package:aider_mobile_app/src/shared_widgets/common/app_bottom_nav_wrapper.dart';
import 'package:aider_mobile_app/src/shared_widgets/common/h_space.dart';
import 'package:aider_mobile_app/src/shared_widgets/common/row_text.dart';
import 'package:aider_mobile_app/src/shared_widgets/common/svg_icon.dart';
import 'package:aider_mobile_app/src/shared_widgets/common/v_space.dart';
import 'package:aider_mobile_app/src/shared_widgets/forms/app_input_field.dart';
import 'package:aider_mobile_app/src/shared_widgets/modals/location_modal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../../../core/constants/common.dart';
import '../../../../../../core/domain/models/address/address_model.dart';
import '../../../../../../core/utils/app_dialog_util.dart';
import '../../../../../../core/utils/app_theme_util.dart';
import '../../../../../../core/providers/base_view.dart';
import '../../../../../shared_widgets/base/draggable_bottom_sheet.dart';
import '../../../../../shared_widgets/common/app_icon.dart';
import '../../../../../shared_widgets/common/screen_empty_state.dart';
import '../../../../../shared_widgets/modals/draggable_bottom_sheet_content.dart';
import '../../../../explore/presentation/providers/explore_view_provider.dart';
import '../../../../explore/presentation/widgets/suggestion_tag.dart';
import '../../../../product/domain/models/category/sub_category_item_model.dart';
import '../../../../product/presentation/providers/product_provider.dart';
import '../../providers/search_provider.dart';

class FilterModal extends StatefulWidget {
  const FilterModal(
      {super.key, required this.type, required this.categoryExternalId});
  final String type;
  final String categoryExternalId;

  @override
  State<FilterModal> createState() => _FilterModalState();
}

class _FilterModalState extends State<FilterModal> {
  double startValue = 0, endValue = 0.5;
  List<SubCategoryItemModel> appliedFilters = [];
  List<AddressModel> appliedLocations = [];
  final TextEditingController startController =
      TextEditingController(text: '10');
  final TextEditingController endController =
      TextEditingController(text: '100000000');
  final startFocusNode = FocusNode();
  final endFocusNode = FocusNode();
  final locationController = TextEditingController();
  final location = ValueNotifier<Map<String, dynamic>?>(null);

  Future<void> fetchProductsByCategory([int page = 1]) async {
    if (!mounted) return;
    await context.read<ExploreViewProvider>().fetchProductsByCategory(
          context,
          categoryExternalId: widget.categoryExternalId,
          page: page,
        );
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductProvider>().fetchPopularSubCategoryItems(context);
      context.read<SearchProvider>().fetchPopularLocations();
    });
    super.initState();
  }

  @override
  void dispose() {
    locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableBottomSheet(
      initialChildSize: 0.90,
      minChildSize: 0.70,
      maxChildSize: 0.95,
      builder: (context, scrollController) {
        return DraggableBottomSheetContent(
          bottomNavigationBar: AppBottomNavWrapper(
            child: AppPrimaryButton(
              text: "Filter",
              onPressed: () async {
                List<String?> cities =
                    appliedLocations.map((location) => location.city).toList();
                List<int?> subCategoryItemIds =
                    appliedFilters.map((obj) => obj.id).toList();
                Map<String, dynamic> requestBody = {
                  "categoryExternalId": widget.categoryExternalId,
                  "priceRange": {
                    "min": num.parse(startController.text.replaceAll(',', '')),
                    "max": num.parse(endController.text.replaceAll(',', '')),
                  }
                };

                if (subCategoryItemIds.isNotEmpty) {
                  requestBody["subCategoryItemIds"] = [...subCategoryItemIds];
                }

                if (
                    // cities != &&
                    cities.isNotEmpty) {
                  requestBody["location"] = [...cities];
                }

                if (requestBody["priceRange"] != null &&
                    requestBody["priceRange"] != null) {
                  requestBody["priceRange"] = {
                    "min": num.parse(startController.text.replaceAll(',', '')),
                    "max": num.parse(endController.text.replaceAll(',', '')),
                  };
                }

                await context.read<ExploreViewProvider>().fetchFilteredProducts(
                      context,
                      type: widget.type,
                      loadingComponent: widget.type == 'products'
                          ? "products"
                          : "fetchProductsByCategory",
                      page: 1,
                      requestBody: requestBody,
                    );
              },
            ),
          ),
          draggableKey: GlobalKey(),
          scrollController: scrollController,
          modalHeaderContent: RowText(
            leftWidget: const Text(
              'Filters',
            )
                .bold()
                .fontSize(20)
                .letterSpacing(-0.40)
                .alignText(TextAlign.center)
                .color(kGrey1200),
            rightWidget: AppCard(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: ShapeDecoration(
                color: kError100,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
              child: const Text(
                'Clear Filters',
              )
                  .bold()
                  .fontSize(14)
                  .alignText(TextAlign.center)
                  .color(kError700),
            ).onPressed(() async {
              setState(() {
                appliedFilters.clear();
                appliedLocations.clear();
              });
              await fetchProductsByCategory();
            }),
          ).paddingOnly(left: kWidthPadding, right: kWidthPadding, bottom: 10),
          content: ListView(
            children: [
              const VSpace(height: 20),
              const Text(
                'APPLIED FILTERS',
              )
                  .extraBold()
                  .fontSize(12)
                  .color(kGrey700)
                  .paddingSymmetric(horizontal: kWidthPadding),
              if (appliedFilters.isNotEmpty) ...[
                const VSpace(height: 20),
                Wrap(
                  runSpacing: 12.0,
                  children: List.generate(appliedFilters.length, (index) {
                    final text = appliedFilters[index];
                    return SuggestionTag(
                      text: text.name ?? '',
                      color: kAider700,
                      textColor: kPrimaryWhite,
                      padding: EdgeInsets.symmetric(
                        horizontal: AppThemeUtil.width(12.0),
                        vertical: AppThemeUtil.height(8.0),
                      ),
                      rightWidget: const AppIcon(
                        CupertinoIcons.clear,
                        color: kPrimaryWhite,
                        size: 14,
                      ).onPressed(() {
                        appliedFilters.removeAt(index);
                        setState(() {});
                      }).paddingOnly(left: 4.0),
                    ).paddingOnly(
                      left: 12.0,
                    );
                  }),
                ),
                const VSpace(height: 20),
              ],
              if (appliedLocations.isNotEmpty) ...[
                Wrap(
                  runSpacing: 12.0,
                  children: List.generate(appliedLocations.length, (index) {
                    final text = appliedLocations[index];
                    return SuggestionTag(
                      text: text.city ?? '',
                      color: kAider700,
                      textColor: kPrimaryWhite,
                      padding: EdgeInsets.symmetric(
                        horizontal: AppThemeUtil.width(12.0),
                        vertical: AppThemeUtil.height(8.0),
                      ),
                      rightWidget: const AppIcon(
                        CupertinoIcons.clear,
                        color: kPrimaryWhite,
                        size: 14,
                      ).onPressed(() {
                        appliedLocations.removeAt(index);
                        setState(() {});
                      }).paddingOnly(left: 4.0),
                    ).paddingOnly(
                      left: 12.0,
                    );
                  }),
                ),
                const VSpace(height: 20),
              ],
              Divider(
                color: AppThemeUtil.getThemeColor(kGrey200),
                thickness: 1.0,
              ),
              const VSpace(height: 20),
              const Text(
                'SUB CATEGORIES',
              )
                  .extraBold()
                  .fontSize(12)
                  .color(kGrey700)
                  .paddingSymmetric(horizontal: kWidthPadding),
              const VSpace(height: 20),
              BaseView<ProductProvider>(
                  builder: (context, productConsumer, child) {
                if (productConsumer.getSubCategoryItems.isEmpty) {
                  return const ScreenEmptyState(
                    title: 'Categories',
                    subtitle: 'No popular categories to display',
                  );
                }
                return Wrap(
                  spacing: AppThemeUtil.width(8.0),
                  runSpacing: AppThemeUtil.height(12.0),
                  children: List.generate(
                      productConsumer.getSubCategoryItems.length, (index) {
                    final item = productConsumer.getSubCategoryItems[index];
                    return Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppThemeUtil.width(16),
                        vertical: AppThemeUtil.height(8),
                      ),
                      clipBehavior: Clip.antiAlias,
                      decoration: ShapeDecoration(
                        color: AppThemeUtil.getThemeColor(kGrey50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                      child: Text(
                        '${item.name}',
                      )
                          .medium()
                          .fontSize(14)
                          .height(20, 14)
                          .letterSpacing(-0.15)
                          .alignText(TextAlign.center)
                          .color(kGrey1200),
                    ).onPressed(() {
                      if (appliedFilters.any(
                          (filter) => filter.externalId == item.externalId)) {
                        AppDialogUtil.showWarningAlert(
                            context, 'Already Added this');
                      } else {
                        appliedFilters.add(item);
                        setState(() {});
                      }
                    });
                  }),
                ).paddingSymmetric(horizontal: kWidthPadding);
              }),
              const VSpace(height: 20),
              Divider(
                color: AppThemeUtil.getThemeColor(kGrey200),
                thickness: 1.0,
              ),
              const VSpace(height: 20),
              const Text(
                'PRICE RANGE',
              )
                  .extraBold()
                  .fontSize(12)
                  .color(kGrey700)
                  .paddingSymmetric(horizontal: kWidthPadding),
              const VSpace(height: 20),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppInputField(
                    hintText: 'min',
                    controller: startController,
                    keyboardType: TextInputType.number,
                    focusNode: startFocusNode,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  ).expanded(),
                  const Text('-')
                      .extraBold()
                      .fontSize(16)
                      .color(kPrimaryBlack)
                      .paddingOnly(bottom: 25, left: 8, right: 8),
                  AppInputField(
                    hintText: 'min',
                    controller: endController,
                    keyboardType: TextInputType.number,
                    focusNode: endFocusNode,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  ).expanded(),
                  // AppInputField(),
                ],
              ).paddingSymmetric(horizontal: kWidthPadding),
              RangeSlider(
                min: 0,
                max: 100000,
                values: RangeValues(startValue, endValue),
                activeColor: kAider700,
                inactiveColor: kGrey100,
                onChanged: (RangeValues values) {
                  setState(() {
                    startValue = values.start;
                    endValue = values.end;
                    startController.text = NumberFormat('#,##0.00')
                        .format(values.start); // Format numbers with commas
                    endController.text =
                        NumberFormat('#,##0.00').format(values.end);
                  });
                },
              ),
              const VSpace(height: 20),
              const Text(
                'LOCATION',
              )
                  .extraBold()
                  .fontSize(12)
                  .color(kGrey700)
                  .paddingSymmetric(horizontal: kWidthPadding),
              const VSpace(height: 20),
              BaseView<SearchProvider>(
                  builder: (context, searchConsumer, child) {
                if (searchConsumer.getAddress.isEmpty) {
                  return const ScreenEmptyState(
                    title: 'Address',
                    subtitle: 'No popular address to display',
                  );
                }
                return Wrap(runSpacing: 12.0, children: [
                  ...List.generate(searchConsumer.getAddress.length, (index) {
                    final item = searchConsumer.getAddress[index];
                    return SuggestionTag(
                      text: item.city ?? '',
                      padding: EdgeInsets.symmetric(
                        horizontal: AppThemeUtil.width(12.0),
                        vertical: AppThemeUtil.height(8.0),
                      ),
                    ).paddingOnly(right: 8, left: 12).onPressed(() {
                      if (appliedLocations
                          .any((filter) => filter.id == item.id)) {
                        AppDialogUtil.showWarningAlert(
                            context, 'Already Added this');
                      } else {
                        AddressModel city =
                            AddressModel(city: item.city.toString());
                        appliedLocations.add(city);
                        setState(() {});
                      }
                    });
                  }),
                  if (searchConsumer.getAddress.length > 1)
                    AppCard(
                      width: AppThemeUtil.width(180),
                      height: AppThemeUtil.height(36),
                      decoration: ShapeDecoration(
                        color: kGrey50,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(AppThemeUtil.radius(999)),
                        ),
                      ),
                      child: Row(
                        children: [
                          ZSvgIcon(
                            "MagnifyingGlass.svg",
                            size: AppThemeUtil.radius(16.0),
                            color: kGrey500,
                          ),
                          const HSpace(width: 4),
                          const Text(
                            'Search locations',
                          )
                              .bold()
                              .fontSize(14)
                              .color(kGrey500)
                              .alignText(TextAlign.center)
                        ],
                      ).paddingSymmetric(
                        horizontal: AppThemeUtil.width(16),
                        vertical: AppThemeUtil.height(8),
                      ),
                    ).onPressed(() async {
                      final result =
                          await AppDialogUtil.showScrollableBottomSheet(
                        context: context,
                        builder: (context) => const LocationModal(),
                      );
                      if (result != null) {
                        locationController.text = result['city'] ?? '';
                        String? cityString = result['city'];
                        final city = AddressModel(city: cityString ?? '');
                        appliedLocations.add(city);
                        setState(() {});
                      }
                    })
                ]);
              }),
              Divider(
                color: AppThemeUtil.getThemeColor(kGrey200),
                thickness: 1.0,
              ),
            ],
          ),
        );
      },
    );
  }
}
