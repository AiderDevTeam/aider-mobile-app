
import 'package:aider_mobile_app/core/constants/colors.dart';
import 'package:aider_mobile_app/core/constants/common.dart';
import 'package:aider_mobile_app/core/extensions/widgets/padding_extension.dart';
import 'package:aider_mobile_app/core/utils/app_theme_util.dart';
import 'package:aider_mobile_app/src/shared_widgets/sliders/slider_indicator.dart';
import 'package:aider_mobile_app/src/shared_widgets/sliders/zcarousel.dart';
import 'package:flutter/material.dart';

import '../../../../shared_widgets/common/network_image_view.dart';
import '../../domain/models/product/product_model.dart';

class ProductDetailCarousel extends StatelessWidget {
  ProductDetailCarousel({
    super.key,
    required this.product
  });
  final ProductModel product;

  final currentIndex = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        ZCarousel(
          height: AppThemeUtil.height(413.0),
          viewportFraction: 1.0,
          itemCount: (product.photos?? []).length,
          onPageChanged: (index, reason){
            currentIndex.value = index;
          },
          itemBuilder: (context, index, id){
            if(!product.hasPhotos) return const SizedBox.shrink();
            final image = product.photos![index];
            return NetworkImageView(
              imageUrl: image.photoUrl?? '',
              height: AppThemeUtil.height(413.0),
              width: double.infinity,
              borderRadius: BorderRadius.circular(AppThemeUtil.radius(20.0)),
            ).paddingSymmetric(
              horizontal: kWidthPadding,
            );
          },
        ),

        Container(
          padding: EdgeInsets.symmetric(
            vertical: AppThemeUtil.radius(6.0),
            horizontal: AppThemeUtil.radius(2.0),
          ),
          margin: EdgeInsets.only(bottom: AppThemeUtil.height(21.0)),
          decoration: BoxDecoration(
            color: kPrimaryWhite,
            borderRadius: BorderRadius.circular(100),
            border: Border.all(color: kGrey200),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate((product.photos?? []).length, (index) => ValueListenableBuilder<int>(
                  valueListenable: currentIndex,
                  builder: (context, currentIndexValue, child) {
                  return SliderIndicator(isActive: index == currentIndexValue,);
                }
              ),
            ),
          ),
        ),
      ],
    );
  }
}
