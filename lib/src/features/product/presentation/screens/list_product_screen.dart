import 'dart:io';

import 'package:aider_mobile_app/core/constants/colors.dart';
import 'package:aider_mobile_app/core/extensions/widgets/align_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/flexible_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/gesture_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/padding_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/text_extension.dart';
import 'package:aider_mobile_app/core/routing/app_navigator.dart';
import 'package:aider_mobile_app/core/routing/app_route.dart';
import 'package:aider_mobile_app/core/utils/app_dialog_util.dart';
import 'package:aider_mobile_app/core/utils/input_formatter_util.dart';
import 'package:aider_mobile_app/src/features/product/domain/models/product_photo/product_photo_model.dart';
import 'package:aider_mobile_app/src/features/product/domain/models/product_price/price_structure_model.dart';
import 'package:aider_mobile_app/src/features/product/presentation/providers/product_provider.dart';
import 'package:aider_mobile_app/src/features/product/presentation/widgets/product_image_placeholder.dart';
import 'package:aider_mobile_app/src/features/product/presentation/widgets/renting/rental_price_modal.dart';
import 'package:aider_mobile_app/src/shared_widgets/common/app_bottom_nav_wrapper.dart';
import 'package:aider_mobile_app/src/shared_widgets/buttons/app_primary_button.dart';
import 'package:aider_mobile_app/src/shared_widgets/common/app_keyboard_action.dart';
import 'package:aider_mobile_app/src/shared_widgets/forms/app_input_field.dart';
import 'package:aider_mobile_app/src/shared_widgets/forms/form_label.dart';
import 'package:aider_mobile_app/src/shared_widgets/common/h_space.dart';
import 'package:aider_mobile_app/src/shared_widgets/common/svg_icon.dart';
import 'package:aider_mobile_app/src/shared_widgets/modals/error_modal_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:keyboard_actions/keyboard_actions_item.dart';
import 'package:provider/provider.dart';

import '../../../../../core/constants/common.dart';
import '../../../../../core/utils/app_theme_util.dart';
import '../../../../../core/utils/media_file_util.dart';
import '../../../../../core/utils/permission_util.dart';
import '../../../../shared_widgets/base/app_screen_scaffold.dart';
import '../../../../shared_widgets/common/v_space.dart';
import '../../domain/models/category/sub_category_item_model.dart';
import '../../domain/models/product_price/product_price_model.dart';
import '../widgets/product_category_modal.dart';

class ListProductScreen extends StatefulWidget {
  const ListProductScreen({super.key});

  @override
  State<ListProductScreen> createState() => _ListProductScreenState();
}

class _ListProductScreenState extends State<ListProductScreen> {
  final formKey = GlobalKey<FormState>();
  final itemNameController = TextEditingController();
  final categoryController = TextEditingController();
  final autoValidateMode =
      ValueNotifier<AutovalidateMode>(AutovalidateMode.disabled);
  final images = ValueNotifier<List<Map<String, dynamic>>>([]);
  final priceControllers = ValueNotifier<List<TextEditingController>>([]);
  final priceFocusNodes = ValueNotifier<List<FocusNode>>([]);
  final priceStructure = ValueNotifier<List<PriceStructureModel>>([]);
  SubCategoryItemModel? subCategoryItem;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await context.read<ProductProvider>().retrievePriceStructure();
    });
    super.initState();
  }

  @override
  void dispose() {
    itemNameController.dispose();
    categoryController.dispose();
    for (final controller in priceControllers.value) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScreenScaffold(
      title: 'List an item',
      bottomNavigationBar: AppBottomNavWrapper(
        child: AppPrimaryButton(
          onPressed: () {
            if (images.value.isEmpty) {
              AppDialogUtil.showWarningAlert(context, 'Add photos of item');
              return;
            }

            if (formKey.currentState!.validate()) {
              if (priceControllers.value.isEmpty) {
                AppDialogUtil.showWarningAlert(context, 'Select rental price');
                return;
              }
              List<ProductPriceModel> prices = [];
              for (int i = 0; i < priceControllers.value.length; i++) {
                prices.add(
                  ProductPriceModel(
                    price: num.parse(
                        priceControllers.value[i].text.replaceAll(",", "")),
                    startDay: priceStructure.value[i].startDay,
                    endDay: priceStructure.value[i].endDay,
                  ),
                );
              }
              if (prices.length < 3) {
                AppDialogUtil.popUpModal(
                  context,
                  modalContent: const ErrorModalContent(
                    errorMessage:
                        "Provide prices for all ranges (Daily, 7+ Days, 30+ Days)",
                  ),
                );
                return;
              }

              final productProvider = context.read<ProductProvider>();

              productProvider.setProductRequestBody =
                  productProvider.getProductRequestBody.copyWith(
                name: itemNameController.text,
                subCategoryItemId: subCategoryItem?.externalId,
                prices: prices,
                photos: images.value
                    .map((obj) => ProductPhotoModel(photoUrl: obj['file']))
                    .toList(),
              );
              AppNavigator.pushNamed(
                  context, AppRoute.productDescriptionScreen);
            }
          },
          text: 'Proceed',
        ),
      ),
      child: ValueListenableBuilder<List<FocusNode>>(
        valueListenable: priceFocusNodes,
        builder: (context, priceFocusNodeValues, child) {
          return AppKeyboardAction(
            actions: List.generate(priceFocusNodeValues.length, (index) {
              final focusNode = priceFocusNodeValues[index];
              return KeyboardActionsItem(focusNode: focusNode);
            }),
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
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ProductImagePlaceholder(
                                  file: imageValues.firstWhere(
                                      (obj) => obj['id'] == 1,
                                      orElse: () =>
                                          <String, dynamic>{})['file'],
                                  onTap: () async {
                                    await showDialog<File?>(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title:
                                            const Text("Select Image Source"),
                                        surfaceTintColor: kPrimaryWhite,
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            ListTile(
                                              leading: const Icon(Icons.camera),
                                              title:
                                                  const Text('Take a picture'),
                                              onTap: () async {
                                                Navigator.of(context).pop();
                                                if (await PermissionUtil
                                                    .getCameraPermissions()) {
                                                  final croppedFile =
                                                      await MediaFileUtil
                                                          .getPickedSourceImage(
                                                              cameraFront:
                                                                  true);
                                                  if (croppedFile != null) {
                                                    images.value =
                                                        List.from(imageValues)
                                                          ..add({
                                                            'id': 1,
                                                            'file': croppedFile,
                                                          });
                                                  }
                                                }
                                              },
                                            ),
                                            ListTile(
                                              leading: const Icon(
                                                  Icons.photo_library),
                                              title: const Text(
                                                  'Choose from gallery'),
                                              onTap: () async {
                                                Navigator.of(context).pop();
                                                if (await PermissionUtil
                                                    .getStoragePermission()) {
                                                  String? croppedFile =
                                                      await MediaFileUtil
                                                          .getPickedImage();
                                                  if (croppedFile != null) {
                                                    images.value =
                                                        List.from(imageValues)
                                                          ..add({
                                                            'id': 1,
                                                            'file': croppedFile,
                                                          });
                                                  }
                                                }
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                  onDelete: () {
                                    images.value = List.from(imageValues)
                                      ..removeWhere((obj) => obj['id'] == 1);
                                  },
                                ).flexible(flex: 5),
                                const HSpace(width: 12.0),
                                ProductImagePlaceholder(
                                  file: imageValues.firstWhere(
                                      (obj) => obj['id'] == 2,
                                      orElse: () =>
                                          <String, dynamic>{})['file'],
                                  onTap: () async {
                                    await showDialog<File?>(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title:
                                            const Text("Select Image Source"),
                                        surfaceTintColor: kPrimaryWhite,
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            ListTile(
                                              leading: const Icon(Icons.camera),
                                              title:
                                                  const Text('Take a picture'),
                                              onTap: () async {
                                                Navigator.of(context).pop();
                                                if (await PermissionUtil
                                                    .getCameraPermissions()) {
                                                  final croppedFile =
                                                      await MediaFileUtil
                                                          .getPickedSourceImage(
                                                              cameraFront:
                                                                  true);
                                                  if (croppedFile != null) {
                                                    images.value =
                                                        List.from(imageValues)
                                                          ..add({
                                                            'id': 2,
                                                            'file': croppedFile,
                                                          });
                                                  }
                                                }
                                              },
                                            ),
                                            ListTile(
                                              leading: const Icon(
                                                  Icons.photo_library),
                                              title: const Text(
                                                  'Choose from gallery'),
                                              onTap: () async {
                                                Navigator.of(context).pop();
                                                if (await PermissionUtil
                                                    .getStoragePermission()) {
                                                  String? croppedFile =
                                                      await MediaFileUtil
                                                          .getPickedImage();
                                                  if (croppedFile != null) {
                                                    images.value =
                                                        List.from(imageValues)
                                                          ..add({
                                                            'id': 2,
                                                            'file': croppedFile,
                                                          });
                                                  }
                                                }
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                  onDelete: () {
                                    images.value = List.from(imageValues)
                                      ..removeWhere((obj) => obj['id'] == 2);
                                  },
                                ).flexible(flex: 5),
                              ],
                            );
                          }),
                      const VSpace(height: 12.0),
                      ValueListenableBuilder<List<Map<String, dynamic>>>(
                          valueListenable: images,
                          builder: (context, imageValues, child) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ProductImagePlaceholder(
                                  file: imageValues.firstWhere(
                                      (obj) => obj['id'] == 3,
                                      orElse: () =>
                                          <String, dynamic>{})['file'],
                                  onTap: () async {
                                    await showDialog<File?>(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title:
                                            const Text("Select Image Source"),
                                        surfaceTintColor: kPrimaryWhite,
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            ListTile(
                                              leading: const Icon(Icons.camera),
                                              title:
                                                  const Text('Take a picture'),
                                              onTap: () async {
                                                Navigator.of(context).pop();
                                                if (await PermissionUtil
                                                    .getCameraPermissions()) {
                                                  final croppedFile =
                                                      await MediaFileUtil
                                                          .getPickedSourceImage(
                                                              cameraFront:
                                                                  true);
                                                  if (croppedFile != null) {
                                                    images.value =
                                                        List.from(imageValues)
                                                          ..add({
                                                            'id': 3,
                                                            'file': croppedFile,
                                                          });
                                                  }
                                                }
                                              },
                                            ),
                                            ListTile(
                                              leading: const Icon(
                                                  Icons.photo_library),
                                              title: const Text(
                                                  'Choose from gallery'),
                                              onTap: () async {
                                                Navigator.of(context).pop();
                                                if (await PermissionUtil
                                                    .getStoragePermission()) {
                                                  String? croppedFile =
                                                      await MediaFileUtil
                                                          .getPickedImage();
                                                  if (croppedFile != null) {
                                                    images.value =
                                                        List.from(imageValues)
                                                          ..add({
                                                            'id': 3,
                                                            'file': croppedFile,
                                                          });
                                                  }
                                                }
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                  onDelete: () {
                                    images.value = List.from(imageValues)
                                      ..removeWhere((obj) => obj['id'] == 3);
                                  },
                                ).flexible(flex: 5),
                                const HSpace(width: 12.0),
                                ProductImagePlaceholder(
                                  file: imageValues.firstWhere(
                                      (obj) => obj['id'] == 4,
                                      orElse: () =>
                                          <String, dynamic>{})['file'],
                                  onTap: () async {
                                    await showDialog<File?>(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title:
                                            const Text("Select Image Source"),
                                        surfaceTintColor: kPrimaryWhite,
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            ListTile(
                                              leading: const Icon(Icons.camera),
                                              title:
                                                  const Text('Take a picture'),
                                              onTap: () async {
                                                Navigator.of(context).pop();
                                                if (await PermissionUtil
                                                    .getCameraPermissions()) {
                                                  final croppedFile =
                                                      await MediaFileUtil
                                                          .getPickedSourceImage(
                                                              cameraFront:
                                                                  true);
                                                  if (croppedFile != null) {
                                                    images.value =
                                                        List.from(imageValues)
                                                          ..add({
                                                            'id': 4,
                                                            'file': croppedFile,
                                                          });
                                                  }
                                                }
                                              },
                                            ),
                                            ListTile(
                                              leading: const Icon(
                                                  Icons.photo_library),
                                              title: const Text(
                                                  'Choose from gallery'),
                                              onTap: () async {
                                                Navigator.of(context).pop();
                                                if (await PermissionUtil
                                                    .getStoragePermission()) {
                                                  String? croppedFile =
                                                      await MediaFileUtil
                                                          .getPickedImage();
                                                  if (croppedFile != null) {
                                                    images.value =
                                                        List.from(imageValues)
                                                          ..add({
                                                            'id': 4,
                                                            'file': croppedFile,
                                                          });
                                                  }
                                                }
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                  onDelete: () {
                                    images.value = List.from(imageValues)
                                      ..removeWhere((obj) => obj['id'] == 4);
                                  },
                                ).flexible(flex: 5),
                              ],
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
                          context
                              .read<ProductProvider>()
                              .fetchPopularSubCategoryItems(context);
                          final result =
                              await AppDialogUtil.showScrollableBottomSheet(
                            context: context,
                            builder: (context) => const ProductCategoryModal(),
                          );
                          if (result != null) {
                            categoryController.text =
                                (result as SubCategoryItemModel).name ?? '';
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
                              children: List.generate(
                                  priceControllerValues.length, (index) {
                                final controller = priceControllerValues[index];
                                final focusNode = priceFocusNodes.value[index];
                                final price = priceStructure.value[index];
                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    AppInputField(
                                      controller: controller,
                                      hintText: 'Enter price per day',
                                      validator: (value) {
                                        if (value!.isEmpty)
                                          return 'Enter price per day';
                                        return null;
                                      },
                                      focusNode: focusNode,
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
                                          Text('~${(price.name ?? '').toLowerCase()}')
                                              .medium()
                                              .fontSize(14)
                                              .color(kGrey500)
                                              .letterSpacing(-0.15)
                                              .paddingOnly(right: 8.0)
                                              .alignCenterRight(),
                                        ],
                                      ),
                                      keyboardType:
                                          const TextInputType.numberWithOptions(
                                              decimal: true, signed: false),
                                      inputFormatters: [
                                        // FilteringTextInputFormatter.allow(RegExp(r"^\d+\.?\d{0,2}")),
                                        FilteringTextInputFormatter.allow(RegExp(
                                            r"^\d{1,3}(,\d{3})*\.?\d{0,2}")),
                                        InputFormatterUtil
                                            .thousandsSeparatorInputSeparator,
                                      ],
                                    ).flexible(flex: 9),
                                    Container(
                                      margin: EdgeInsets.only(
                                          bottom: AppThemeUtil.height(24.0)),
                                      padding: EdgeInsets.all(
                                          AppThemeUtil.radius(16.0)),
                                      decoration: BoxDecoration(
                                        border: Border.all(color: kGrey200),
                                        borderRadius: BorderRadius.circular(
                                            AppThemeUtil.radius(12.0)),
                                      ),
                                      child: ZSvgIcon(
                                        'minus.svg',
                                        size: AppThemeUtil.radius(20.0),
                                        color: kGrey1200,
                                      ),
                                    ).onPressed(() {
                                      priceControllers.value =
                                          List.from(priceControllerValues)
                                            ..removeAt(index);
                                      priceStructure.value =
                                          List.from(priceStructure.value)
                                            ..removeAt(index);
                                      priceFocusNodes.value =
                                          List.from(priceFocusNodes.value)
                                            ..removeAt(index);
                                    }).flexible(flex: 2),
                                  ],
                                ).paddingOnly(bottom: 10);
                              }),
                            );
                          }),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppThemeUtil.width(16.0),
                          vertical: AppThemeUtil.width(8.0),
                        ),
                        decoration: BoxDecoration(
                          color: kGrey50,
                          borderRadius:
                              BorderRadius.circular(AppThemeUtil.radius(30.0)),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text('Add price')
                                .semiBold()
                                .fontSize(14.0)
                                .color(kGrey1200),
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

                        final result =
                            await AppDialogUtil.showScrollableBottomSheet(
                          context: context,
                          builder: (context) => RentalPriceModal(
                              prices: priceStructure.value
                                  .map((e) => e.id ?? 0)
                                  .toList()
                                ..remove(0)),
                        );
                        if (result != null) {
                          priceControllers.value =
                              List.from(priceControllers.value)
                                ..add(TextEditingController());
                          priceStructure.value = List.from(priceStructure.value)
                            ..add(result as PriceStructureModel);
                          priceFocusNodes.value =
                              List.from(priceFocusNodes.value)
                                ..add(FocusNode());
                        }
                      }),
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
