import 'package:aider_mobile_app/core/constants/colors.dart';
import 'package:aider_mobile_app/core/extensions/widgets/align_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/flexible_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/padding_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/text_extension.dart';
import 'package:aider_mobile_app/core/utils/app_dialog_util.dart';
import 'package:aider_mobile_app/core/utils/input_formatter_util.dart';
import 'package:aider_mobile_app/src/features/product/presentation/providers/product_provider.dart';
import 'package:aider_mobile_app/src/shared_widgets/common/app_bottom_nav_wrapper.dart';
import 'package:aider_mobile_app/src/shared_widgets/common/app_keyboard_action.dart';
import 'package:aider_mobile_app/src/shared_widgets/buttons/app_primary_button.dart';
import 'package:aider_mobile_app/src/shared_widgets/forms/app_input_field.dart';
import 'package:aider_mobile_app/src/shared_widgets/forms/form_label.dart';
import 'package:aider_mobile_app/src/shared_widgets/common/h_space.dart';
import 'package:aider_mobile_app/src/shared_widgets/common/svg_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:keyboard_actions/keyboard_actions_item.dart';
import 'package:provider/provider.dart';

import '../../../../../core/constants/common.dart';
import '../../../../../core/utils/app_theme_util.dart';
import '../../../../shared_widgets/base/app_screen_scaffold.dart';
import '../../../../shared_widgets/modals/location_modal.dart';
import '../../../../shared_widgets/common/v_space.dart';

class ProductDescriptionScreen extends StatefulWidget {
  const ProductDescriptionScreen({super.key});

  @override
  State<ProductDescriptionScreen> createState() =>
      _ProductDescriptionScreenState();
}

class _ProductDescriptionScreenState extends State<ProductDescriptionScreen> {
  final formKey = GlobalKey<FormState>();
  final descriptionController = TextEditingController();
  final descriptionFocusNode = FocusNode();
  final locationController = TextEditingController();
  final quantityController = TextEditingController();
  final quantityFocusNode = FocusNode();
  final priceController = TextEditingController();
  final priceFocusNode = FocusNode();
  final autoValidateMode =
      ValueNotifier<AutovalidateMode>(AutovalidateMode.disabled);
  final location = ValueNotifier<Map<String, dynamic>?>(null);

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final productDescriptionProvider =
          context.read<ProductProvider>().getProductDescription;
      descriptionController.text =
          productDescriptionProvider['description'] ?? '';
      quantityController.text = productDescriptionProvider['quantity'] ?? '';
      priceController.text = productDescriptionProvider['itemValue'] ?? '';
      if (productDescriptionProvider['location'] != null) {
        locationController.text =
            productDescriptionProvider['location']['originName'] ?? '';
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    descriptionController.dispose();
    locationController.dispose();
    quantityController.dispose();
    priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScreenScaffold(
      title: 'List an item',
      bottomNavigationBar: AppBottomNavWrapper(
        child: AppPrimaryButton(
          onPressed: () async {
            if (formKey.currentState!.validate()) {
              final productProvider = context.read<ProductProvider>();
              await productProvider.listProduct(
                context,
                requestBody: productProvider.getProductRequestBody.copyWith(
                  description: descriptionController.text,
                  quantity: int.parse(quantityController.text),
                  value: double.parse(priceController.text.replaceAll(",", "")),
                ),
                address: location.value ??
                    context
                        .read<ProductProvider>()
                        .getProductDescription['location'],
              );
            }
          },
          text: 'Finish listing',
        ),
      ),
      child: AppKeyboardAction(
        actions: [
          KeyboardActionsItem(focusNode: descriptionFocusNode),
          KeyboardActionsItem(focusNode: quantityFocusNode),
          KeyboardActionsItem(focusNode: priceFocusNode),
        ],
        bothPlatform: true,
        child: SingleChildScrollView(
          child: ValueListenableBuilder<AutovalidateMode>(
              valueListenable: autoValidateMode,
              builder: (context, autoValidateModeValue, child) {
                return Form(
                  key: formKey,
                  autovalidateMode: autoValidateModeValue,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const VSpace(height: 24.0),
                      const FormLabel(text: 'Item description'),
                      const VSpace(height: 8.0),
                      AppInputField(
                        controller: descriptionController,
                        hintText: 'Write descriptions',
                        focusNode: descriptionFocusNode,
                        maxLine: 4,
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.newline,
                        onChanged: (val) {
                          context
                              .read<ProductProvider>()
                              .setProductDescription = {"description": val};
                        },
                        validator: (value) {
                          if (value!.isEmpty) return 'Write descriptions';
                          return null;
                        },
                      ),
                      const VSpace(height: 12.0),
                      const FormLabel(text: 'Item quantity'),
                      const VSpace(height: 8.0),
                      AppInputField(
                        controller: quantityController,
                        focusNode: quantityFocusNode,
                        keyboardType: TextInputType.number,
                        hintText: '0',
                        onChanged: (val) {
                          context
                              .read<ProductProvider>()
                              .setProductDescription = {"quantity": val};
                        },
                        validator: (value) {
                          if (value!.isEmpty) return 'Enter quantity';
                          if (int.parse(value) <= 0)
                            return 'Enter quantity more than 0';
                          return null;
                        },
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'^[1-9][0-9]*$'))
                        ],
                      ),
                      const VSpace(height: 12.0),
                      const FormLabel(text: 'Item value'),
                      const VSpace(height: 8.0),
                      AppInputField(
                        controller: priceController,
                        focusNode: priceFocusNode,
                        hintText: '0.0',
                        onChanged: (val) {
                          print("Item val not change -> $val");
                          print(
                              "Item val changed -> ${val?.replaceAll(",", "")}");
                          context
                              .read<ProductProvider>()
                              .setProductDescription = {
                            "itemValue": val?.replaceAll(",", "")
                          };
                        },
                        validator: (value) {
                          if (value!.isEmpty) return 'Enter item value';
                          if (double.parse(value.replaceAll(",", "")) <= 0)
                            return 'Enter value more than 0';
                          return null;
                        },
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true, signed: false),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r"^\d{1,3}(,\d{3})*\.?\d{0,2}")),
                          InputFormatterUtil.thousandsSeparatorInputSeparator,
                        ],
                        prefixIcon: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text('₦')
                                .medium()
                                .fontSize(14)
                                .color(kGrey1200)
                                .letterSpacing(-0.15)
                                .paddingOnly(left: 16.0)
                                .alignCenterLeft(),
                          ],
                        ),
                      ),
                      DecoratedBox(
                        decoration: BoxDecoration(
                          color: kBlue100,
                          borderRadius:
                              BorderRadius.circular(AppThemeUtil.radius(12.0)),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ZSvgIcon(
                              'info.svg',
                              color: kBlue800,
                              size: AppThemeUtil.radius(20),
                            ),
                            const HSpace(width: 10.0),
                            const Text(
                                    'Enter the price the item is worth in the market')
                                .regular()
                                .color(kGrey800)
                                .fontSize(14.0)
                                .flexible()
                          ],
                        ).paddingAll(14.0),
                      ),
                      const VSpace(height: 32.0),
                      const FormLabel(text: 'Item location'),
                      const VSpace(height: 8.0),
                      AppInputField(
                        controller: locationController,
                        hintText: 'Search location',
                        readOnly: true,
                        onTap: () async {
                          final result =
                              await AppDialogUtil.showScrollableBottomSheet(
                            context: context,
                            builder: (context) => const LocationModal(),
                          );
                          if (result != null) {
                            locationController.text =
                                result['originName'] ?? '';
                            if (!mounted) return;
                            location.value = result;

                            context
                                .read<ProductProvider>()
                                .setProductDescription = {
                              "location": location.value
                            };
                          }
                        },
                        suffixIcon: ZSvgIcon(
                          'map_pin.svg',
                          size: AppThemeUtil.radius(20.0),
                        ).paddingAll(16.0),
                      ),
                      const VSpace(height: 12.0),
                      DecoratedBox(
                        decoration: BoxDecoration(
                          color: kBlue100,
                          borderRadius:
                              BorderRadius.circular(AppThemeUtil.radius(12.0)),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ZSvgIcon(
                              'info.svg',
                              color: kBlue800,
                              size: AppThemeUtil.radius(20),
                            ),
                            const HSpace(width: 10.0),
                            const Text(
                                    'Leave blank if the item is in the same location as the address you set in your profile')
                                .regular()
                                .color(kGrey800)
                                .fontSize(14.0)
                                .flexible()
                          ],
                        ).paddingAll(14.0),
                      ),
                      const VSpace(height: 32.0),
                    ],
                  ).paddingSymmetric(horizontal: kWidthPadding),
                );
              }),
        ),
      ),
    );
  }
}
