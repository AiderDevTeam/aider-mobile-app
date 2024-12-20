import 'dart:io';

import 'package:aider_mobile_app/core/constants/colors.dart';
import 'package:aider_mobile_app/core/extensions/widgets/align_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/flexible_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/gesture_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/padding_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/text_extension.dart';
import 'package:aider_mobile_app/core/routing/app_navigator.dart';
import 'package:aider_mobile_app/core/utils/app_dialog_util.dart';
import 'package:aider_mobile_app/core/utils/input_formatter_util.dart';
import 'package:aider_mobile_app/src/features/product/presentation/view_models/product_view_model.dart';
import 'package:aider_mobile_app/src/features/product/presentation/widgets/product_image_placeholder.dart';
import 'package:aider_mobile_app/src/shared_widgets/common/app_bottom_nav_wrapper.dart';
import 'package:aider_mobile_app/src/shared_widgets/buttons/app_primary_button.dart';
import 'package:aider_mobile_app/src/shared_widgets/forms/app_input_field.dart';
import 'package:aider_mobile_app/src/shared_widgets/forms/form_label.dart';
import 'package:aider_mobile_app/src/shared_widgets/common/h_space.dart';
import 'package:aider_mobile_app/src/shared_widgets/common/svg_icon.dart';
import 'package:aider_mobile_app/src/shared_widgets/modals/question_modal_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:keyboard_actions/keyboard_actions_item.dart';
import 'package:provider/provider.dart';

import '../../../../../core/constants/common.dart';
import '../../../../../core/utils/app_theme_util.dart';
import '../../../../../core/utils/helper_util.dart';
import '../../../../../core/utils/media_file_util.dart';
import '../../../../../core/utils/permission_util.dart';
import '../../../../shared_widgets/base/app_screen_scaffold.dart';
import '../../../../shared_widgets/common/app_keyboard_action.dart';
import '../../../../shared_widgets/common/v_space.dart';
import '../../../../shared_widgets/modals/location_modal.dart';
import '../../domain/models/category/sub_category_item_model.dart';
import '../../domain/models/product/product_model.dart';
import '../../domain/models/product_price/product_price_model.dart';
import '../widgets/product_category_modal.dart';
import '../widgets/renting/rental_price_modal.dart';

class EditListedProductScreen extends StatefulWidget {
  const EditListedProductScreen({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  State<EditListedProductScreen> createState() => _EditListedProductScreenState();
}

class _EditListedProductScreenState extends State<EditListedProductScreen> {
  final formKey = GlobalKey<FormState>();
  final itemNameController = TextEditingController();
  final categoryController = TextEditingController();
  final locationController = TextEditingController();
  final descriptionController = TextEditingController();
  final descriptionFocusNode = FocusNode();
  final quantityController = TextEditingController();
  final quantityFocusNode = FocusNode();
  final valueController = TextEditingController();
  final valueFocusNode = FocusNode();
  final priceFocusNodes = ValueNotifier<List<FocusNode>>([]);
  final autoValidateMode = ValueNotifier<AutovalidateMode>(AutovalidateMode.disabled);
  final images = ValueNotifier<List<Map<String, dynamic>>>([]);
  final priceControllers = ValueNotifier<List<TextEditingController>>([]);
  final location = ValueNotifier<Map<String, dynamic>?>(null);
  final productPrices = ValueNotifier<List<Map<String, dynamic>>>([]);
  SubCategoryItemModel? subCategoryItem;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await context.read<ProductViewModel>().retrievePriceStructure();

      final product = widget.product;
      itemNameController.text = product.name ?? '';
      descriptionController.text = product.description ?? '';
      subCategoryItem = product.subCategoryItem;
      categoryController.text = product.subCategoryItem?.name ?? '';
      int index = 0;
      images.value = (product.photos ?? []).map((obj) => {'id': obj.id, 'index': index++, 'imageUrl': obj.photoUrl}).toList();
      locationController.text = product.address?.originName ?? '';
      location.value = product.address?.toJson();
      quantityController.text = (product.quantity ?? '').toString();
      valueController.text = (product.value ?? '').toString();
      _setProductPrices(product);
    });
    super.initState();
  }

  @override
  void dispose() {
    itemNameController.dispose();
    descriptionController.dispose();
    categoryController.dispose();
    quantityController.dispose();
    valueController.dispose();
    locationController.dispose();
    for (final controller in priceControllers.value) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    return AppScreenScaffold(
      title: 'Edit item',
      // appBarActions: [
      //   ContextMenuDropdown(
      //     items: [
      //       {
      //         'value': '1',
      //         'name': 'Delete Item',
      //         'leadingWidget':  ZSvgIcon(
      //           'trash.svg',
      //           color: kError700,
      //           size: AppThemeUtil.radius(20.0),
      //         ),
      //       },
      //     ],
      //     onChanged: (value) {
      //       AppDialogUtil.popUpModal(
      //         context,
      //         modalContent: QuestionModalContent(
      //           title: 'Delete from Items',
      //           questionText: 'Are you sure you want to delete this item?',
      //           color: kError700,
      //           borderColor: kError600,
      //           onYesPressed: () async{
      //             AppNavigator.pop(context);
      //             await context.read<ProductViewModel>().deleteProduct(
      //               context,
      //               productExternalId: product.externalId?? '',
      //             );
      //           },
      //           reverseYesNo: true,
      //         ),
      //       );
      //     },
      //   ).paddingOnly(right: kWidthPadding),
      // ],

      bottomNavigationBar: AppBottomNavWrapper(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppPrimaryButton(
              onPressed: () async {
                AppDialogUtil.popUpModal(
                  context,
                  modalContent: QuestionModalContent(
                    title: 'Delete from Items',
                    questionText: 'Are you sure you want to delete this item?',
                    color: kError700,
                    borderColor: kError600,
                    onYesPressed: () async {
                      AppNavigator.pop(context);
                      await context.read<ProductViewModel>().deleteProduct(
                            context,
                            productExternalId: product.externalId ?? '',
                          );
                    },
                    reverseYesNo: true,
                  ),
                );
              },
              text: 'Delete',
              minWidth: double.infinity,
              color: kError700,
              borderColor: kError600,
            ),
            const VSpace(height: 8.0),
            AppPrimaryButton(
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  if (priceControllers.value.isEmpty) {
                    AppDialogUtil.showWarningAlert(context, 'Select rental price');
                    return;
                  }
                  List<Map<String, dynamic>> prices = [];
                  for (int i = 0; i < priceControllers.value.length; i++) {
                    prices.add({
                      "price": priceControllers.value[i].text.replaceAll(",", ""),
                      "productPriceId": productPrices.value[i]['productPriceId'],
                      "priceStructureId": productPrices.value[i]['priceStructureId'],
                    });
                  }

                  await context.read<ProductViewModel>().updateProduct(
                    context,
                    productExternalId: product.externalId ?? '',
                    requestBody: {
                      "subCategoryItemId": subCategoryItem?.id,
                      "name": itemNameController.text,
                      "description": descriptionController.text,
                      "quantity": quantityController.text,
                      "value": valueController.text.replaceAll(",", ""),
                      "prices": prices,
                      "address": location.value,
                    },
                  );
                }
              },
              text: 'Update',
              minWidth: double.infinity,
            ),
          ],
        ),
      ),
      child: ValueListenableBuilder<List<FocusNode>>(
        valueListenable: priceFocusNodes,
        builder: (context, priceFocusNodeValues, child) {
          return AppKeyboardAction(
            actions: [
              KeyboardActionsItem(focusNode: descriptionFocusNode),
              KeyboardActionsItem(focusNode: valueFocusNode),
              KeyboardActionsItem(focusNode: quantityFocusNode),
              ...List.generate(priceFocusNodeValues.length, (index) {
                final focusNode = priceFocusNodeValues[index];
                return KeyboardActionsItem(focusNode: focusNode);
              }),
            ],
            bothPlatform: true,
            child: child!,
          );
        },
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
                      const FormLabel(text: 'Add photos'),
                      const VSpace(height: 8.0),
                      ValueListenableBuilder<List<Map<String, dynamic>>>(
                          valueListenable: images,
                          builder: (context, imageValues, child) {
                            return GridView.count(
                              physics: const NeverScrollableScrollPhysics(),
                              crossAxisCount: 2,
                              crossAxisSpacing: 12.0,
                              mainAxisSpacing: 0,
                              childAspectRatio: 1.08,
                              shrinkWrap: true,
                              primary: false,
                              children: List.generate(
                                4,
                                (index) {
                                  final photo = imageValues.firstWhere((obj) => obj['index'] == index, orElse: () => <String, dynamic>{});
                                  return ProductImagePlaceholder(
                                    file: photo['file'],
                                    imageUrl: photo['imageUrl'],
                                    onTap: () async {
                                      if (photo['index'] == index) return;
                                      await showDialog<File?>(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          title: const Text("Select Image Source"),
                                          surfaceTintColor: kPrimaryWhite,
                                          content: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              ListTile(
                                                leading: const Icon(Icons.camera),
                                                title: const Text('Take a picture'),
                                                onTap: () async {
                                                  if (await PermissionUtil.getCameraPermissions()) {
                                                    final croppedFile = await MediaFileUtil.getPickedSourceImage();
                                                    if (croppedFile != null) {
                                                      images.value = List.from(imageValues)
                                                        ..add({
                                                          'index': index,
                                                          'file': croppedFile,
                                                        });

                                                      if (!mounted) return;
                                                      await Future.delayed(const Duration(milliseconds: 500));

                                                      if (!context.mounted) return;
                                                      AppDialogUtil.popUpModal(
                                                        context,
                                                        modalContent: QuestionModalContent(
                                                          title: 'Item Photo',
                                                          questionText: 'Do you want add photo to this item?',
                                                          onYesPressed: () async {
                                                            AppNavigator.pop(context);
                                                            await context.read<ProductViewModel>().addProductPhoto(
                                                              context,
                                                              productExternalId: product.externalId ?? '',
                                                              requestBody: {
                                                                "photos[]": croppedFile,
                                                              },
                                                            );
                                                            if (!context.mounted) return;
                                                            Navigator.of(context).pop();
                                                          },
                                                          onNoPressed: () {
                                                            AppNavigator.pop(context);
                                                            images.value = List.from(imageValues)..removeWhere((obj) => obj['index'] == index);
                                                          },
                                                        ),
                                                      );
                                                    }
                                                  }
                                                },
                                              ),
                                              ListTile(
                                                leading: const Icon(Icons.photo_library),
                                                title: const Text('Choose from gallery'),
                                                onTap: () async {
                                                  if (await PermissionUtil.getStoragePermission()) {
                                                    final croppedFile = await MediaFileUtil.getPickedImage();
                                                    if (croppedFile != null) {
                                                      images.value = List.from(imageValues)
                                                        ..add({
                                                          'index': index,
                                                          'file': croppedFile,
                                                        });

                                                      if (!mounted) return;
                                                      await Future.delayed(const Duration(milliseconds: 500));

                                                      if (!context.mounted) return;
                                                      AppDialogUtil.popUpModal(
                                                        context,
                                                        modalContent: QuestionModalContent(
                                                          title: 'Item Photo',
                                                          questionText: 'Do you want add photo to this item?',
                                                          onYesPressed: () async {
                                                            AppNavigator.pop(context);
                                                            await context.read<ProductViewModel>().addProductPhoto(
                                                              context,
                                                              productExternalId: product.externalId ?? '',
                                                              requestBody: {
                                                                "photos[]": croppedFile,
                                                              },
                                                            );
                                                            if (!context.mounted) return;
                                                            Navigator.of(context).pop();
                                                          },
                                                          onNoPressed: () {
                                                            AppNavigator.pop(context);
                                                            images.value = List.from(imageValues)..removeWhere((obj) => obj['index'] == index);
                                                          },
                                                        ),
                                                      );
                                                    }
                                                  }
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                    onDelete: () async {
                                      if (photo['imageUrl'] != null) {
                                        AppDialogUtil.popUpModal(
                                          context,
                                          modalContent: QuestionModalContent(
                                            title: 'Delete from Photos',
                                            questionText: 'Are you sure you want to delete this photo?',
                                            color: kError700,
                                            borderColor: kError600,
                                            onYesPressed: () async {
                                              AppNavigator.pop(context);
                                              final result = await context.read<ProductViewModel>().deleteProductPhoto(
                                                context,
                                                productExternalId: product.externalId ?? '',
                                                requestBody: {
                                                  "photoId": photo['id'],
                                                },
                                              );
                                              if (result) {
                                                images.value = List.from(imageValues)..removeWhere((obj) => obj['index'] == index);
                                              }
                                            },
                                            reverseYesNo: true,
                                          ),
                                        );

                                        return;
                                      }
                                      images.value = List.from(imageValues)..removeWhere((obj) => obj['index'] == index);
                                    },
                                    canDelete: imageValues.where((item) => item['imageUrl'] != null).length > 1,
                                    update: true,
                                  );
                                },
                              ),
                            );
                          }),
                      const VSpace(height: 32.0),
                      const FormLabel(text: 'Item name'),
                      const VSpace(height: 8.0),
                      AppInputField(
                        controller: itemNameController,
                        hintText: 'Enter item name',
                        validator: (value) {
                          if (value!.isEmpty) return 'Enter item name';
                          return null;
                        },
                      ),
                      const VSpace(height: 12.0),
                      const FormLabel(text: 'Item Description'),
                      const VSpace(height: 8.0),
                      AppInputField(
                        controller: descriptionController,
                        focusNode: descriptionFocusNode,
                        hintText: 'Enter item description',
                        maxLine: 4,
                        validator: (value) {
                          if (value!.isEmpty) return 'Enter item description';
                          return null;
                        },
                      ),
                      const VSpace(height: 12.0),
                      const FormLabel(text: 'Category'),
                      const VSpace(height: 8.0),
                      AppInputField(
                        controller: categoryController,
                        hintText: 'Choose category',
                        readOnly: true,
                        validator: (value) {
                          if (value!.isEmpty) return 'Choose category';
                          return null;
                        },
                        onTap: () async {
                          context.read<ProductViewModel>().emitPopularCategories();
                          final result = await AppDialogUtil.showScrollableBottomSheet(
                            context: context,
                            builder: (context) => const ProductCategoryModal(),
                          );
                          if (result != null) {
                            categoryController.text = (result as SubCategoryItemModel).name ?? '';
                            subCategoryItem = result;
                          }
                        },
                        suffixIcon: ZSvgIcon(
                          'caret_up_down.svg',
                          size: AppThemeUtil.radius(20.0),
                        ).paddingAll(16.0),
                      ),
                      const VSpace(height: 12.0),
                      const FormLabel(text: 'Rental price'),
                      const VSpace(height: 8.0),
                      ValueListenableBuilder<List<TextEditingController>>(
                          valueListenable: priceControllers,
                          builder: (context, priceControllerValues, child) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: List.generate(priceControllerValues.length, (index) {
                                final controller = priceControllerValues[index];
                                final focusNode = priceFocusNodes.value[index];
                                final price = productPrices.value[index];
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    AppInputField(
                                      controller: controller,
                                      hintText: 'Enter price per day',
                                      validator: (value) {
                                        if (value!.isEmpty) return 'Enter price per day';
                                        return null;
                                      },
                                      focusNode: HelperUtil.isIOS ? focusNode : null,
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
                                      suffixIcon: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text('~${(price['name'] ?? '').toLowerCase()}')
                                              .medium()
                                              .fontSize(14)
                                              .color(kGrey500)
                                              .letterSpacing(-0.15)
                                              .paddingOnly(right: 8.0)
                                              .alignCenterRight(),
                                        ],
                                      ),
                                      keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: false),
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(RegExp(r"^\d{1,3}(,\d{3})*\.?\d{0,2}")),
                                        InputFormatterUtil.thousandsSeparatorInputSeparator,
                                      ],
                                    ).flexible(flex: 9),
                                    Container(
                                      margin: EdgeInsets.only(bottom: AppThemeUtil.height(24.0)),
                                      padding: EdgeInsets.all(AppThemeUtil.radius(16.0)),
                                      decoration: BoxDecoration(
                                        border: Border.all(color: kGrey200),
                                        borderRadius: BorderRadius.circular(AppThemeUtil.radius(12.0)),
                                      ),
                                      child: ZSvgIcon(
                                        'minus.svg',
                                        size: AppThemeUtil.radius(20.0),
                                        color: kGrey1200,
                                      ),
                                    ).onPressed(() async {
                                      if (price['productPriceId'] == null) {
                                        priceControllers.value = List.from(priceControllerValues)..removeAt(index);
                                        productPrices.value = List.from(productPrices.value)..removeAt(index);
                                        priceFocusNodes.value = List.from(priceFocusNodes.value)..removeAt(index);
                                        return;
                                      }

                                      if (priceControllerValues.length == 1) return;

                                      AppDialogUtil.popUpModal(
                                        context,
                                        modalContent: QuestionModalContent(
                                          title: 'Delete Price',
                                          questionText: 'Are you sure you want to delete this price?',
                                          color: kError700,
                                          borderColor: kError600,
                                          onYesPressed: () async {
                                            AppNavigator.pop(context);
                                            final result = await context.read<ProductViewModel>().deleteProductPrice(
                                              context,
                                              productExternalId: product.externalId ?? '',
                                              requestBody: {
                                                "productPriceId": price['productPriceId'],
                                              },
                                            );
                                            if (result) {
                                              priceControllers.value = List.from(priceControllerValues)..removeAt(index);
                                              productPrices.value = List.from(productPrices.value)..removeAt(index);
                                              priceFocusNodes.value = List.from(priceFocusNodes.value)..removeAt(index);
                                              return;
                                            }
                                          },
                                          reverseYesNo: true,
                                        ),
                                      );
                                    }).flexible(flex: 2),
                                  ],
                                ).paddingOnly(bottom: 10);
                              }),
                            );
                          }),
                      ValueListenableBuilder(
                        valueListenable: priceControllers,
                        builder: (context, priceControllerValues, child) {
                          if (priceControllerValues.length >= 3) return const SizedBox.shrink();

                          return Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: AppThemeUtil.width(16.0),
                              vertical: AppThemeUtil.width(8.0),
                            ),
                            decoration: BoxDecoration(
                              color: kGrey50,
                              borderRadius: BorderRadius.circular(AppThemeUtil.radius(30.0)),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text('Add price').semiBold().fontSize(14.0).color(kGrey1200),
                                const HSpace(width: 8.0),
                                Icon(
                                  Icons.add,
                                  size: AppThemeUtil.radius(16.0),
                                  color: kGrey1200,
                                )
                              ],
                            ),
                          ).onPressed(() async {
                            if (priceControllers.value.length == 3) return;

                            context.read<ProductViewModel>().emitPriceStructure();

                            final result = await AppDialogUtil.showScrollableBottomSheet(
                              context: context,
                              builder: (context) => RentalPriceModal(
                                prices: const [],
                                update: true,
                                updatePrices: productPrices.value,
                              ),
                            );
                            if (result != null) {
                              priceControllers.value = List.from(priceControllers.value)..add(TextEditingController());
                              productPrices.value = List.from(productPrices.value)..add(result);
                              priceFocusNodes.value = List.from(priceFocusNodes.value)..add(FocusNode());
                            }
                          });
                        },
                      ),
                      const VSpace(height: 32.0),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const FormLabel(text: 'Item quantity'),
                              const VSpace(height: 8.0),
                              AppInputField(
                                controller: quantityController,
                                focusNode: HelperUtil.isIOS ? quantityFocusNode : null,
                                keyboardType: TextInputType.number,
                                hintText: '0',
                                validator: (value) {
                                  if (value!.isEmpty) return 'Enter quantity';
                                  if (int.parse(value) <= 0) return 'Enter quantity more than 0';
                                  return null;
                                },
                                inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^[1-9][0-9]*$'))],
                              ),
                            ],
                          ).flexible(),
                          const HSpace(width: 12.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const FormLabel(text: 'Item value'),
                              const VSpace(height: 8.0),
                              AppInputField(
                                controller: valueController,
                                focusNode: HelperUtil.isIOS ? valueFocusNode : null,
                                hintText: '0.0',
                                validator: (value) {
                                  if (value!.isEmpty) return 'Enter item value';
                                  if (double.parse(value.replaceAll(",", "")) <= 0) return 'Enter value more than 0';
                                  return null;
                                },
                                keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: false),
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(RegExp(r"^\d{1,3}(,\d{3})*\.?\d{0,2}")),
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
                            ],
                          ).flexible(),
                        ],
                      ),
                      const VSpace(height: 16.0),
                      const FormLabel(text: 'Item location'),
                      const VSpace(height: 8.0),
                      AppInputField(
                        controller: locationController,
                        hintText: 'Search location',
                        readOnly: true,
                        onTap: () async {
                          final result = await AppDialogUtil.showScrollableBottomSheet(
                            context: context,
                            builder: (context) => const LocationModal(),
                          );
                          if (result != null) {
                            locationController.text = result['originName'] ?? '';
                            if (!mounted) return;
                            location.value = result;
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
                          borderRadius: BorderRadius.circular(AppThemeUtil.radius(12.0)),
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
                            const Text('Leave blank if the item is in the same location as the address you set in your profile')
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

  void _setProductPrices(ProductModel product) {
    for (ProductPriceModel price in (product.prices ?? [])) {
      priceControllers.value = List.from(priceControllers.value)..add(TextEditingController(text: (price.price ?? '').toString()));
      priceFocusNodes.value = List.from(priceFocusNodes.value)..add(FocusNode());
      productPrices.value = List.from(productPrices.value)
        ..add({
          "productPriceId": price.id,
          "startDay": price.startDay,
          "endDay": price.endDay,
          "name": price.endDay == null ? '${price.startDay}+' : '${price.startDay}-${price.endDay}',
        });
    }
  }
}
