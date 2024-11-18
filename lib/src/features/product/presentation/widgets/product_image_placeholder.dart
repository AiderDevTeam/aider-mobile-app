
import 'dart:io';

import 'package:aider_mobile_app/core/extensions/widgets/gesture_extension.dart';
import 'package:aider_mobile_app/core/utils/cached_network_image_util.dart';
import 'package:flutter/material.dart';

import '../../../../../core/constants/colors.dart';
import '../../../../../core/utils/app_theme_util.dart';
import '../../../../shared_widgets/cards/app_card.dart';
import '../../../../shared_widgets/common/svg_icon.dart';

class ProductImagePlaceholder extends StatelessWidget {
  const ProductImagePlaceholder({
    super.key,
    required this.onTap,
    this.onDelete,
    this.file,
    this.imageUrl,
    this.canDelete = true,
    this.update = false,
  });
  
  final void Function() onTap;
  final void Function()? onDelete;
  final String? file;
  final String? imageUrl;
  final bool canDelete;
  final bool update;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AppCard(
          width: double.infinity,
          height: AppThemeUtil.height(150.0),
          decoration: BoxDecoration(
              color: const Color(0xFFF8F8F8),
              borderRadius: BorderRadius.circular(AppThemeUtil.radius(8.0)),
            image: file == null?
            (imageUrl == null? null : DecorationImage(
              image: CachedNetworkImageUtil.cacheNetworkImageProvider(imageUrl?? ''),
              fit: BoxFit.cover,
            ))
                :
            DecorationImage(
              image: FileImage(File(file!)),
              fit: BoxFit.cover,
            ),
          ),
          child: file == null && imageUrl == null?
          CircleAvatar(
            maxRadius: 16,
            backgroundColor: Colors.transparent,
            child: ZSvgIcon(
              'camera_plus.svg',
              size: AppThemeUtil.radius(32.0),
              color: kGrey500,
            ),
          ) : null,
        ).onPressed(onTap),

        if(file != null && !update) Positioned(
          bottom: AppThemeUtil.height(!update? 4: 30),
          right: AppThemeUtil.width(!update? 4: 14),
          child: CircleAvatar(
            maxRadius: 16,
            backgroundColor: Colors.transparent,
            child: ZSvgIcon(
              'delete.svg',
              size: AppThemeUtil.radius(20.0),
              color: kPrimaryWhite,
            ),
          ).onPressed(onDelete?? (){}),
        ),

        if(imageUrl != null && canDelete) Positioned(
          bottom: AppThemeUtil.height(30),
          right: AppThemeUtil.width(14),
          child: CircleAvatar(
            maxRadius: 16,
            backgroundColor: Colors.transparent,
            child: ZSvgIcon(
              'delete.svg',
              size: AppThemeUtil.radius(20.0),
              color: kPrimaryWhite,
            ),
          ).onPressed(onDelete?? (){}),
        ),
      ],
    );
  }
}
