import 'package:aider_mobile_app/core/extensions/widgets/flexible_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/gesture_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/padding_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/text_extension.dart';
import 'package:aider_mobile_app/core/utils/app_dialog_util.dart';
import 'package:aider_mobile_app/src/shared_widgets/common/svg_icon.dart';
import 'package:aider_mobile_app/src/shared_widgets/modals/error_modal_content.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/colors.dart';
import '../../../core/routing/app_navigator.dart';
import '../../../core/routing/app_route.dart';
import '../../../core/utils/app_theme_util.dart';
import '../../../core/utils/helper_util.dart';
import '../../features/explore/presentation/providers/explore_view_provider.dart';
import '../../features/product/domain/models/product/product_model.dart';
import 'h_space.dart';
import 'network_image_view.dart';
import 'v_space.dart';

class ProductGridView extends StatelessWidget {
  const ProductGridView({
    super.key,
    required this.products,
    this.primary,
    this.gridPadding,
  });

  final List<ProductModel> products;
  final bool? primary;
  final EdgeInsetsGeometry? gridPadding;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      primary: primary,
      padding: gridPadding,
      physics: const ClampingScrollPhysics(),
      itemCount: products.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: AppThemeUtil.width(12),
        mainAxisSpacing: AppThemeUtil.height(30.0),
        childAspectRatio: HelperUtil.isIOS ? 0.57 : 0.62,
      ),
      itemBuilder: (context, index) {
        final product = products[index];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              child: product.hasPhotos
                  ? NetworkImageView(
                      imageUrl: product.photos?.first.photoUrl ?? '',
                      height: AppThemeUtil.height(200),
                      width: double.infinity,
                      radius: 12.0,
                    )
                  : SizedBox(
                      height: AppThemeUtil.height(200),
                      width: double.infinity,
                    ),
            ).flexible(),
            const VSpace(height: 12),
            Text(product.name ?? '')
                .textMaxLines(1)
                .medium()
                .fontSize(14)
                .color(kGrey1200)
                .overflowText(TextOverflow.ellipsis)
                .paddingOnly(right: 12.0),
            const VSpace(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    ZSvgIcon(
                      'map_pin.svg',
                      size: AppThemeUtil.radius(14.0),
                      color: kGrey700,
                    ),
                    const HSpace(width: 4),
                    Text(product.address?.originName ?? '')
                        .regular()
                        .fontSize(12)
                        .color(kGrey700)
                        .overflowText(TextOverflow.ellipsis)
                        .flexible(),
                  ],
                ).flexible(),
                const HSpace(width: 8),
                Row(
                  children: [
                    ZSvgIcon(
                      'star.svg',
                      size: AppThemeUtil.radius(14.0),
                      color: kWarning700,
                    ),
                    const HSpace(width: 4.0),
                    Text("${product.rating ?? 0.0}")
                        .regular()
                        .fontSize(12)
                        .color(kGrey700)
                  ],
                ),
              ],
            ).paddingOnly(right: 12.0),
            const VSpace(height: 8.0),
            Text(
              '₦${product.getFirstPrice}/day',
            ).bold().fontSize(14).color(kGrey1200).paddingOnly(right: 12.0),
          ],
        ).onPressed(() async {
          final fetchedProduct = await context
              .read<ExploreViewProvider>()
              .getProductByUserIdAndProductUid(
                  context, product.userId ?? '', product.uid ?? '');

          if (fetchedProduct == null) {
            AppDialogUtil.popUpModal(context,
                modalContent: const ErrorModalContent(
                  errorMessage:
                      'something went wrong while fetching product details',
                  errorTitle: 'Product not found',
                ));
            return;
          }
          AppNavigator.pushNamed(context, AppRoute.productDetailScreen,
              arguments: fetchedProduct);
        });
      },
    );
  }
}
