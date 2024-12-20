import 'dart:async';
import 'dart:ui';
import 'package:aider_mobile_app/core/extensions/widgets/flexible_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/text_extension.dart';
import 'package:flash/flash_helper.dart';
import 'package:flutter/material.dart';
import '../../src/shared_widgets/common/app_loader.dart';
import '../../src/shared_widgets/common/h_space.dart';
import '../constants/colors.dart';
import 'app_theme_util.dart';
import 'helper_util.dart';

enum DialogAction { yes, abort }

class AppDialogUtil {

  static Future<void> loadingDialog(BuildContext context) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        barrierColor: AppThemeUtil.getThemeColor(kBlack70),
        builder: (BuildContext context) {
          return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
            child: const PopScope(
              canPop: false,
              child: SimpleDialog(
                elevation: 0.0,
                contentPadding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                titlePadding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                backgroundColor: Colors.transparent,
                children: <Widget>[
                  AppLoader(),
                ],
              ),
            ),
          );
        },
    );
  }


  static Future showScrollableBottomSheet( {
    required BuildContext context,
    bool? isDismissible,
    bool useSafeArea = true,
    required Widget Function(BuildContext) builder
  })
  {
    return showModalBottomSheet(
      context: context,
      elevation: 0,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      enableDrag: false,
      useSafeArea: HelperUtil.isIOS? false : useSafeArea,
      isDismissible: isDismissible?? true,
      barrierColor: AppThemeUtil.getThemeColor(kBlack70),
      builder: builder,
    );
  }

  static Future<dynamic> popUpModal(BuildContext context,{
    bool willPop = true,
    bool barrierDismissible = false,
    required Widget modalContent,
  }) async {
    await showDialog(
      barrierDismissible: barrierDismissible,
      barrierColor: AppThemeUtil.getThemeColor(kBlack70),
      context: context,
      builder: (BuildContext context) {
        return  PopScope(
          canPop: willPop,
          child: modalContent,
        );
      },
    );
  }


  static Future<void> showSuccessAlert(BuildContext context, String message, {Alignment? alignment}) async {
    context.showToast(
      Row(
        children: [
          CircleAvatar(
            maxRadius: AppThemeUtil.radius(10.0),
            backgroundColor: kSuccess300,
            child: Icon(
              Icons.check_circle,
              size: AppThemeUtil.radius(20.0),
              color: kSuccessColor,
            ),
          ),
          const HSpace(width: 8.0),
          Text(message).bold().fontSize(14.0).color(kGrey1200).flexible(),
        ],
      ),
      backgroundColor: kSuccess300,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppThemeUtil.radius(4.0)),
      ),
      elevation: 0,
      queue: false,
      alignment: alignment ?? Alignment(0.0, HelperUtil.isIOS? -0.72: -0.77),
      padding: EdgeInsets.symmetric(
        horizontal: AppThemeUtil.width(16.0),
        vertical: AppThemeUtil.height(8.0),
      ),
    );
  }

  static Future<void> showWarningAlert(BuildContext context, String message) async {
    context.showToast(
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              maxRadius: AppThemeUtil.radius(10.0),
              backgroundColor: kOrange200,
              child: Icon(
                Icons.close,
                size: AppThemeUtil.radius(10.0),
                color: kPrimaryWhite,
              ),
            ),
            const HSpace(width: 8.0),
            Text(message).bold().fontSize(14.0).color(kPrimaryWhite).flexible(),
          ],
        ),
        backgroundColor: kOrange,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppThemeUtil.radius(4.0)),
        ),
        elevation: 0,
        queue: false,
        alignment: Alignment(0.0, HelperUtil.isIOS? -0.72: -0.77),
        padding: EdgeInsets.symmetric(
          horizontal: AppThemeUtil.width(16.0),
          vertical: AppThemeUtil.height(8.0),
        ),
    );
  }


}
