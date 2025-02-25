import 'package:aider_mobile_app/core/extensions/string_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/padding_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/text_extension.dart';
import 'package:aider_mobile_app/core/services/logger_service.dart';
import 'package:aider_mobile_app/core/utils/app_theme_util.dart';
import 'package:aider_mobile_app/core/providers/user_provider.dart';
import 'package:aider_mobile_app/src/shared_widgets/common/svg_icon.dart';
import 'package:aider_mobile_app/src/shared_widgets/common/v_space.dart';
import 'package:aider_mobile_app/src/shared_widgets/forms/form_label.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../../core/constants/colors.dart';
import '../../../../../core/constants/common.dart';
import '../../../../../core/utils/app_dialog_util.dart';
import '../../../../../core/utils/helper_util.dart';
import '../../../../../core/utils/input_formatter_util.dart';
import '../../../../../core/utils/media_file_util.dart';
import '../../../../../core/utils/permission_util.dart';
import '../../../../../core/providers/base_view.dart';
import '../../../../shared_widgets/common/app_bottom_nav_wrapper.dart';
import '../../../../shared_widgets/base/app_screen_scaffold.dart';
import '../../../../shared_widgets/buttons/app_primary_button.dart';
import '../../../../shared_widgets/common/network_image_view.dart';
import '../../../../shared_widgets/common/zloading.dart';
import '../../../../shared_widgets/forms/app_dropdown_field.dart';
import '../../../../shared_widgets/forms/app_input_field.dart';
import '../../../../shared_widgets/modals/location_modal.dart';

class EditUserProfile extends StatefulWidget {
  const EditUserProfile({super.key});

  @override
  State<EditUserProfile> createState() => _EditUserProfileState();
}

class _EditUserProfileState extends State<EditUserProfile> {
  final formKey = GlobalKey<FormState>();
  AutovalidateMode autoValidate = AutovalidateMode.disabled;
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final locationController = TextEditingController();
  final displayNameController = TextEditingController();
  final dobFocusNode = FocusNode();
  final dobController = TextEditingController();
  final emailController = TextEditingController();
  final selectedItem = ValueNotifier<String?>(null);
  String uploadedImagePath = '';
  Map<String, dynamic>? location;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<UserProvider>().setDisplayNameAvailable('', true);
      final user = context.read<UserProvider>().getUser;
      firstNameController.text = user.firstName ?? '';
      lastNameController.text = user.lastName ?? '';
      selectedItem.value = (user.gender ?? '').toString().capitalize();
      emailController.text = user.email ?? '';
      dobController.text =
          DateFormat('dd/MM/yyyy').format(DateTime.parse(user.birthday ?? ''));
      locationController.text = user.address?.originName ?? '';
      displayNameController.text = user.displayName ?? '';
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    dobController.dispose();
    locationController.dispose();
    emailController.dispose();
    displayNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScreenScaffold(
      title: "Profile",
      bottomNavigationBar: AppBottomNavWrapper(
        child: AppPrimaryButton(
          onPressed: () async {
            ZLoggerService.logOnInfo(
                "Validate: ${formKey.currentState!.validate()}");
            if (formKey.currentState!.validate()) {
              final userProvider = context.read<UserProvider>();
              if (userProvider.isComponentLoading('verifyDisplayName')) return;

              var user = userProvider.getUser;
              user = user.copyWith(
                firstName: firstNameController.text,
                lastName: lastNameController.text,
                displayName: displayNameController.text,
                gender: selectedItem.value?.toLowerCase(),
                email: emailController.text.toLowerCase(),
                birthday: dobController.text.split('/').reversed.join('-'),
              );
              await userProvider.updateUser(
                context,
                user: user,
                location: location,
              );
            } else {
              setState(() => autoValidate = AutovalidateMode.onUserInteraction);
            }
          },
          text: "Submit",
        ),
      ),
      child: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: AppThemeUtil.width(kWidthPadding),
        ),
        physics: const ClampingScrollPhysics(),
        children: [
          BaseView<UserProvider>(
            builder: (context, userConsumer, child) => GestureDetector(
              onTap: () async {
                if (await PermissionUtil.getStoragePermission()) {
                  String? croppedFile = await MediaFileUtil.getPickedImage();
                  if (croppedFile != null) {
                    if (!mounted) return;
                    await context.read<UserProvider>().addProfilePhoto(
                          context,
                          imageUrl: croppedFile,
                        );
                  }
                }
              },
              child: Center(
                child: Stack(
                  children: [
                    Container(
                      width: AppThemeUtil.radius(150),
                      height: AppThemeUtil.radius(150),
                      padding: EdgeInsets.all(AppThemeUtil.radius(16.0)),
                      // color: Colors.blue,
                      child: !userConsumer.getUser.hasProfilePhoto
                          ? Container(
                              width: AppThemeUtil.radius(100),
                              height: AppThemeUtil.radius(100),
                              decoration: BoxDecoration(
                                image: const DecorationImage(
                                    image: AssetImage(
                                      "$kImagePath/profile_placeholder.png",
                                    ),
                                    fit: BoxFit.cover),
                                borderRadius: BorderRadius.circular(22),
                              ),
                            )
                          : NetworkImageView(
                              imageUrl: (userConsumer.getUser.profilePhotoUrl !=
                                      null)
                                  ? userConsumer.getUser.profilePhotoUrl ?? ''
                                  : userConsumer.getUser.profilePhotoUrl ?? '',
                              width: AppThemeUtil.radius(100),
                              height: AppThemeUtil.radius(100),
                              radius: 45.0,
                            ),
                    ),
                    Positioned(
                      bottom: AppThemeUtil.height(12),
                      right: AppThemeUtil.width(3),
                      child: Container(
                        height: AppThemeUtil.radius(46.0),
                        width: AppThemeUtil.radius(46.0),
                        decoration: BoxDecoration(
                          color: kPrimaryWhite,
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        padding: EdgeInsets.all(AppThemeUtil.radius(6.0)),
                        child: Container(
                          height: AppThemeUtil.radius(36.0),
                          width: AppThemeUtil.radius(36.0),
                          decoration: BoxDecoration(
                            color: kPrimaryBlack,
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: const Icon(
                            Icons.add,
                            color: kPrimaryWhite,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ).paddingOnly(top: 24, bottom: 16),
          ),
          Form(
            key: formKey,
            autovalidateMode: autoValidate,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const FormLabel(text: 'First Name'),
                const VSpace(height: 12.0),
                AppInputField(
                  hintText: "Enter your first name",
                  controller: firstNameController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter your first name';
                    }
                    return null;
                  },
                ),
                const FormLabel(text: 'Last Name'),
                const VSpace(height: 12.0),
                AppInputField(
                  hintText: "Enter your last name",
                  controller: lastNameController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter your last name';
                    }
                    return null;
                  },
                ),
                const FormLabel(text: 'Display Name'),
                const VSpace(height: 12.0),
                BaseView<UserProvider>(builder: (context, userConsumer, child) {
                  return FocusScope(
                    child: Focus(
                      onFocusChange: (focus) async {
                        if (!focus && displayNameController.text.isNotEmpty) {
                          if (userConsumer
                              .isComponentLoading('verifyDisplayName')) return;
                          await context.read<UserProvider>().verifyDisplayName(
                                context,
                                displayName: displayNameController.text,
                              );
                        }
                      },
                      child: AppInputField(
                        hintText: 'Enter display name',
                        controller: displayNameController,
                        validator: (value) {
                          if (value!.isEmpty) return 'Display name is required';
                          return null;
                        },
                        onChanged: (value) {
                          if (value!.isEmpty) {
                            context
                                .read<UserProvider>()
                                .setDisplayNameAvailable('', true);
                          }
                        },
                        suffixIcon: userConsumer
                                .isComponentLoading('verifyDisplayName')
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const ZLoading().paddingOnly(right: 16.0),
                                ],
                              )
                            : userConsumer.displayNameAvailableStatus ==
                                    kAvailable
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.check_circle,
                                        color: kSuccess700,
                                        size: AppThemeUtil.radius(24.0),
                                      ).paddingOnly(right: 16.0),
                                    ],
                                  )
                                : null,
                        customBorderColor: (userConsumer
                                    .displayNameAvailableStatus.isNotEmpty &&
                                userConsumer.displayNameAvailableStatus !=
                                    kAvailable)
                            ? kError600
                            : null,
                        helperText: (userConsumer
                                    .displayNameAvailableStatus.isNotEmpty &&
                                userConsumer.displayNameAvailableStatus !=
                                    kAvailable)
                            ? userConsumer.displayNameAvailableStatus
                            : ' ',
                        helperStyleColor: (userConsumer
                                    .displayNameAvailableStatus.isNotEmpty &&
                                userConsumer.displayNameAvailableStatus !=
                                    kAvailable)
                            ? kError600
                            : null,
                      ),
                    ),
                  );
                }),
                const FormLabel(text: 'Email'),
                const VSpace(height: 12.0),
                AppInputField(
                  hintText: "Enter your email",
                  controller: emailController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter your email';
                    }
                    return null;
                  },
                ),
                const Text(
                  'Additional information',
                ).semiBold().fontSize(12).color(kGrey700),
                const VSpace(height: 16.0),
                const FormLabel(text: 'Date of Birth'),
                const VSpace(height: 12.0),
                AppInputField(
                  hintText: 'Date of birth (DD/MM/YYYY)',
                  controller: dobController,
                  focusNode: dobFocusNode,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter your date of birth';
                    }
                    if (!HelperUtil.isDateDayValid(value)) {
                      return 'Date is invalid';
                    }
                    if (!HelperUtil.isDateMonthValid(value)) {
                      return 'Date is invalid';
                    }
                    if (!HelperUtil.isDateYearValid(value)) {
                      return 'Date is invalid';
                    }
                    if (HelperUtil.isEighteenAndBelow(value)) {
                      return "You must be 18 years and above";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                  inputFormatters:
                      InputFormatterUtil.maskInput(mask: "##/##/####"),
                ),
                const FormLabel(text: 'Gender'),
                const VSpace(height: 12.0),
                AppDropdownField(
                  hintText: 'Select gender',
                  selectedItem: selectedItem.value,
                  listItems: const ['Male', 'Female'],
                  onChanged: (value) {
                    selectedItem.value = value;
                    setState(() {});
                  },
                  validator: (value) {
                    if (value.toString().isEmpty) return 'Please select gender';
                    return null;
                  },
                ),
                const FormLabel(text: 'Location'),
                const VSpace(height: 12.0),
                AppInputField(
                  controller: locationController,
                  hintText: 'Location',
                  keyboardType: TextInputType.text,
                  readOnly: true,
                  suffixIcon: ZSvgIcon(
                    "map_pin.svg",
                    size: AppThemeUtil.radius(14.0),
                    color: kPrimaryBlack,
                  ).paddingAll(16),
                  validator: (value) {
                    if (value!.isEmpty) return 'Enter your location';
                    return null;
                  },
                  onTap: () async {
                    final result =
                        await AppDialogUtil.showScrollableBottomSheet(
                      context: context,
                      builder: (context) => const LocationModal(),
                    );
                    if (result != null) {
                      locationController.text = result['originName'] ?? '';
                      location = result;
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
//   Container(
//                         width: AppThemeUtil.radius(150),
//                         height: AppThemeUtil.radius(150),
//                         padding: EdgeInsets.all(AppThemeUtil.radius(16.0)),
//                         child: userConsumer.getUser.hasProfilePhoto? Container(
//                           width: AppThemeUtil.radius(100),
//                           height: AppThemeUtil.radius(100),
//                           decoration: BoxDecoration(
//                             image: const DecorationImage(
//                                 image: AssetImage("$kImagePath/profile_placeholder.png",),
//                                 fit: BoxFit.cover
//                             ),
//                             borderRadius: BorderRadius.circular(22),
//                           ),
//                         )
//                           :
//                       NetworkImageView(
//                         imageUrl: userConsumer.getUser.profilePhotoUrl?? '',
//                         width: AppThemeUtil.radius(150),
//                         height: AppThemeUtil.radius(150),
//                         radius: 45.0,
//                       ),
//                     ),
}
