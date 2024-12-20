
import 'package:aider_mobile_app/core/extensions/widgets/padding_extension.dart';
import 'package:aider_mobile_app/core/routing/app_navigator.dart';
import 'package:aider_mobile_app/core/routing/app_route.dart';
import 'package:aider_mobile_app/src/features/product/presentation/view_models/product_view_model.dart';
import 'package:aider_mobile_app/src/shared_widgets/common/zloading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/constants/common.dart';
import '../../../../../core/view_models/base_view.dart';
import '../../../../shared_widgets/base/app_screen_scaffold.dart';
import '../../../../shared_widgets/common/aider_empty_state.dart';
import '../../../../shared_widgets/common/app_load_more.dart';
import '../../../../shared_widgets/common/error_response_message.dart';
import '../../../../shared_widgets/common/product_list_view_builder.dart';

class ListedProductsScreen extends StatefulWidget {
  const ListedProductsScreen({super.key, this.navigateFromListing = false,});

  final bool navigateFromListing;

  @override
  State<ListedProductsScreen> createState() => _ListedProductsScreenState();
}

class _ListedProductsScreenState extends State<ListedProductsScreen> {
  Future<void> fetchUserProducts([String? nextPage]) async{
    await context.read<ProductViewModel>().fetchUserProducts(
        context,
        loadingComponent: 'fetchProducts',
        nextPage: nextPage,
        queryParam: {
          'pageSize': kProductPerPage,
        }
    );
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async{
      await fetchUserProducts();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: !widget.navigateFromListing,
      child: AppScreenScaffold(
        onNavigateBack: !widget.navigateFromListing ? null : (){
          AppNavigator.pushNamedAndRemoveUntil(context, AppRoute.homeScreen, (p0) => false);
        },
        title: 'Items listed',
        child: BaseView<ProductViewModel>(
          builder: (context, productConsumer, child) {
            if(productConsumer.getComponentLoading('fetchProducts') && productConsumer.getProducts.isEmpty){
              return const Center(
                child: ZLoading(),
              );
            }

            if(productConsumer.isComponentErrorType('fetchProducts')){
              return Center(
                child: ErrorResponseMessage(
                  message: productConsumer.componentErrorType?['error']?? '',
                  onRetry: () async{
                    await fetchUserProducts(productConsumer.getProductMeta?.next);
                  },
                ),
              );
            }

            if(productConsumer.getProducts.isEmpty) {
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

            return RefreshIndicator.adaptive(
              onRefresh: fetchUserProducts,
              child: AppLoadMore(
                isFinish: productConsumer.getProductMeta?.next == null,
                onLoadMore: () => fetchUserProducts(productConsumer.getProductMeta?.next),
                children: [
                  ProductListViewBuilder(
                    products: productConsumer.getProducts,
                    edit: !widget.navigateFromListing,
                  ),
                ],
              ).paddingSymmetric(horizontal: kWidthPadding),
            );
          })
      ),
    );
  }
}
