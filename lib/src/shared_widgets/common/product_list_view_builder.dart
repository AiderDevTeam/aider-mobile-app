import 'package:aider_mobile_app/core/extensions/widgets/align_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/flexible_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/padding_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/text_extension.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/colors.dart';
import '../../../core/routing/app_navigator.dart';
import '../../../core/routing/app_route.dart';
import '../../../core/utils/app_theme_util.dart';
import '../../features/product/domain/models/product/product_model.dart';
import '../buttons/app_primary_button.dart';
import 'h_space.dart';
import 'network_image_view.dart';
import 'svg_icon.dart';
import 'v_space.dart';

class ProductListViewBuilder extends StatelessWidget {
  const ProductListViewBuilder({
    super.key,
    required this.products,
    this.edit = false,
  });

  final List<ProductModel> products;
  final bool edit;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      primary: false,
      padding: EdgeInsets.symmetric(vertical: AppThemeUtil.height(24.0)),
      itemCount: products.length,
      itemBuilder: (context, index){
        final product = products[index];
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            product.hasPhotos?
            NetworkImageView(
              imageUrl: product.hasPhotos? (product.photos?.first.photoUrl?? '') : '',
              height: AppThemeUtil.height(100.0),
              width: AppThemeUtil.height(90.0),
              borderRadius: BorderRadius.circular(AppThemeUtil.radius(20.0)),
            )
                :
            SizedBox(
              height: AppThemeUtil.height(100.0),
              width: AppThemeUtil.height(90.0),
            ),
            const HSpace(width: 17.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(product.name ?? '').medium().fontSize(14.0).color(kGrey1200).overflowText(TextOverflow.ellipsis),
                const VSpace(height: 8.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        ZSvgIcon(
                          'map_pin.svg',
                          size: AppThemeUtil.radius(14.0),
                        ),
                        const HSpace(width: 4.0),
                        Text(product.address?.originName?? '').medium().fontSize(12.0).color(kGrey700).overflowText(TextOverflow.ellipsis).flexible(),
                      ],
                    ).flexible(),
                    const HSpace(width: 8.0),
                    Row(
                      children: [
                        ZSvgIcon(
                          'star.svg',
                          size: AppThemeUtil.radius(14.0),
                        ),
                        const HSpace(width: 4.0),
                        const Text('0.0').regular().fontSize(12.0).color(kGrey700).overflowText(TextOverflow.ellipsis),
                      ],
                    ),
                  ],
                ),
                const VSpace(height: 8.0),
                Text('₦${product.getFirstPrice}/day').bold().fontSize(16.0).color(kGrey1200).overflowText(TextOverflow.ellipsis),
                const VSpace(height: 8.0),
                AppPrimaryButton(
                  onPressed: (){
                    if(!edit){
                      AppNavigator.pushNamed(context, AppRoute.productDetailScreen, arguments: product);
                      return;
                    }

                    AppNavigator.pushNamed(context, AppRoute.editListedProductScreen, arguments: product);
                  },
                  text: !edit ? 'View':'Edit',
                  height: 36.0,
                  minWidth: 64,
                  fontSize: 14.0,
                ).alignCenterRight(),
              ],
            ).flexible(),
          ],
        ).paddingOnly(bottom: 32.0);
      },
    );
  }
}
