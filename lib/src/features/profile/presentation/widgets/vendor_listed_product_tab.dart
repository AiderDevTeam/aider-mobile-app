import 'package:aider_mobile_app/core/extensions/widgets/padding_extension.dart';
import 'package:aider_mobile_app/src/features/product/presentation/providers/product_provider.dart';
import 'package:aider_mobile_app/src/shared_widgets/common/product_list_view_builder.dart';
import 'package:aider_mobile_app/src/shared_widgets/common/zloading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/auth/domain/models/user/user_model.dart';
import '../../../../../core/constants/common.dart';
import '../../../../../core/providers/base_view.dart';
import '../../../../shared_widgets/common/aider_empty_state.dart';
import '../../../../shared_widgets/common/app_load_more.dart';
import '../../../../shared_widgets/common/error_response_message.dart';

class VendorListedProductTab extends StatefulWidget {
  const VendorListedProductTab({
    super.key,
    this.edit = false,
    required this.vendor,
  });

  final bool edit;
  final UserModel vendor;

  @override
  State<VendorListedProductTab> createState() => _VendorListedProductTabState();
}

class _VendorListedProductTabState extends State<VendorListedProductTab> {
  Future<void> fetchVendorProducts([String? nextPage]) async {
    await context.read<ProductProvider>().fetchVendorProducts(context,
        vendor: widget.vendor,
        nextPage: nextPage,
        queryParam: {
          'pageSize': kProductPerPage,
        });
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await fetchVendorProducts();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<ProductProvider>(
        builder: (context, productConsumer, child) {
      if (productConsumer.isComponentLoading('fetchVendorProducts') &&
          productConsumer.getVendorProducts.isEmpty) {
        return const Center(
          child: ZLoading(),
        );
      }

      if (productConsumer.isComponentErrorType('fetchVendorProducts')) {
        return Center(
          child: ErrorResponseMessage(
            message: productConsumer.componentErrorType?['error'] ?? '',
            onRetry: () async {
              await fetchVendorProducts(
                  productConsumer.getVendorProductMeta?.next);
            },
          ),
        );
      }

      if (productConsumer.getVendorProducts.isEmpty) {
        return Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.20,
          ),
          child: const AiderEmptyState(
            title: '',
            subtitle: 'No Items yet',
          ),
        );
      }

      return AppLoadMore(
        isFinish: productConsumer.getVendorProductMeta?.next == null,
        onLoadMore: () =>
            fetchVendorProducts(productConsumer.getVendorProductMeta?.next),
        children: [
          ProductListViewBuilder(
            products: productConsumer.getVendorProducts,
            edit: widget.edit,
          ),
        ],
      ).paddingSymmetric(horizontal: kWidthPadding);
    });
  }
}
