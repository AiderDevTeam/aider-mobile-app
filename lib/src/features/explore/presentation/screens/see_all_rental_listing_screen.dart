import 'package:aider_mobile_app/core/constants/common.dart';
import 'package:aider_mobile_app/core/extensions/widgets/expanded_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/padding_extension.dart';
import 'package:aider_mobile_app/core/providers/base_view.dart';
import 'package:aider_mobile_app/src/shared_widgets/base/app_screen_scaffold.dart';
import 'package:aider_mobile_app/src/shared_widgets/common/app_load_more.dart';
import 'package:aider_mobile_app/src/shared_widgets/common/product_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:aider_mobile_app/src/shared_widgets/common/v_space.dart';

import '../../../../shared_widgets/common/action_container.dart';
import '../../../../shared_widgets/common/aider_empty_state.dart';
import '../../../../shared_widgets/common/error_response_message.dart';
import '../providers/explore_view_provider.dart';
import '../widgets/product_loading_effect.dart';

class SeeAllRentalListeningScreen extends StatefulWidget {
  const SeeAllRentalListeningScreen({
    super.key,
    required this.param,
  });

  final Map<String, dynamic> param;

  @override
  State<SeeAllRentalListeningScreen> createState() =>
      _SeeAllRentalListeningScreenState();
}

class _SeeAllRentalListeningScreenState
    extends State<SeeAllRentalListeningScreen> {
  Future<void> fetchProducts([int page = 1]) async {
    if (!mounted) return;
    await context.read<ExploreViewProvider>().fetchProducts(
          context,
          sectionExternalId: widget.param['externalId'],
          page: page,
        );
  }

  Future<void> fetchProductsByCategory([int page = 1]) async {
    if (!mounted) return;
    await context.read<ExploreViewProvider>().fetchProductsByCategory(
          context,
          categoryExternalId: widget.param['externalId'],
          page: page,
        );
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      if (widget.param['type'] == 'category') {
        await fetchProductsByCategory();
        return;
      }
      await fetchProducts();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppScreenScaffold(
      title: widget.param['title'] ?? '',
      appBarActions: [
        ProfileActions(
          filterType: widget.param['type'] == 'category'
              ? 'fetchProductsByCategory'
              : 'products',
          categoryExternalId: widget.param['externalId'],
        ),
      ],
      child: (widget.param['type'] == 'category')
          ? BaseView<ExploreViewProvider>(
              builder: (context, exploreConsumer, child) {
              if (exploreConsumer
                      .isComponentLoading('fetchProductsByCategory') &&
                  exploreConsumer.getCategoryProducts.isEmpty) {
                return const ProductLoadingEffect();
              }

              if (exploreConsumer
                  .isComponentErrorType('fetchProductsByCategory')) {
                return Center(
                  child: ErrorResponseMessage(
                    message: exploreConsumer.componentErrorType?['error'] ?? '',
                    onRetry: () async {
                      await fetchProducts(exploreConsumer
                          .getCategoryProductListCurrentPageNumber);
                    },
                  ),
                );
              }

              if (exploreConsumer.getCategoryProducts.isEmpty) {
                return const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AiderEmptyState(
                      title: '',
                      subtitle: 'No products found yet',
                    ),
                  ],
                ).paddingOnly(bottom: 40);
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // const CategoriesCard(subCategories: [''],),
                  const VSpace(height: 32),
                  AppLoadMore(
                    isFinish: exploreConsumer.categoryProductHasNoData,
                    onLoadMore: () => fetchProducts(exploreConsumer
                        .getCategoryProductListCurrentPageNumber),
                    isLoaderVisible: !exploreConsumer
                        .isComponentLoading('fetchProductsByCategory'),
                    children: [
                      ProductGridView(
                        products: exploreConsumer.getCategoryProducts,
                        primary: false,
                      ),
                    ],
                  ).paddingSymmetric(horizontal: kWidthPadding).expanded(),
                ],
              );
            })
          : BaseView<ExploreViewProvider>(
              builder: (context, exploreConsumer, child) {
              if (exploreConsumer.isComponentLoading('products') &&
                  exploreConsumer.getProducts.isEmpty) {
                return const ProductLoadingEffect();
              }

              if (exploreConsumer.isComponentErrorType('products')) {
                return Center(
                  child: ErrorResponseMessage(
                    message: exploreConsumer.componentErrorType?['error'] ?? '',
                    onRetry: () async {
                      await fetchProducts(
                          exploreConsumer.getProductsPageNumber);
                    },
                  ),
                );
              }

              if (exploreConsumer.getProducts.isEmpty) {
                return const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AiderEmptyState(
                      title: '',
                      subtitle: 'No products found yet',
                    ),
                  ],
                ).paddingOnly(bottom: 40);
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // const CategoriesCard(subCategories: [''],),
                  const VSpace(height: 32),
                  AppLoadMore(
                    isFinish: exploreConsumer.hasNoProductData,
                    onLoadMore: () =>
                        fetchProducts(exploreConsumer.getProductsPageNumber),
                    isLoaderVisible:
                        !exploreConsumer.isComponentLoading('products'),
                    children: [
                      ProductGridView(
                        products: exploreConsumer.getProducts,
                        primary: false,
                      ),
                    ],
                  ).paddingSymmetric(horizontal: kWidthPadding).expanded(),
                ],
              );
            }),
    );
  }
}
