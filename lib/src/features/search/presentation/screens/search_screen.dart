import 'dart:async';

import 'package:aider_mobile_app/core/extensions/widgets/expanded_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/flexible_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/gesture_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/padding_extension.dart';
import 'package:aider_mobile_app/core/utils/app_theme_util.dart';
import 'package:aider_mobile_app/src/shared_widgets/common/aider_empty_state.dart';
import 'package:aider_mobile_app/src/shared_widgets/common/h_space.dart';
import 'package:aider_mobile_app/src/shared_widgets/common/v_space.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/constants/colors.dart';
import '../../../../../core/constants/common.dart';
import '../../../../../core/routing/app_navigator.dart';
import '../../../../../core/providers/base_view.dart';
import '../../../../shared_widgets/common/app_icon.dart';
import '../../../../shared_widgets/common/app_load_more.dart';
import '../../../../shared_widgets/common/error_response_message.dart';
import '../../../../shared_widgets/common/product_grid_view.dart';
import '../../../../shared_widgets/forms/app_input_field.dart';
import '../../../explore/presentation/widgets/product_loading_effect.dart';
import '../view_model/search_view_model.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final searchController = TextEditingController();
  final searchFocusNode = FocusNode();
  Timer? _debounce;

  Future<void> searchAllProducts([String? nextPage]) async {
    if (!mounted) return;
    await context.read<SearchViewModel>().searchAllProducts(
          context,
          requestBody: {"searchInput": searchController.text},
          nextPage: nextPage,
          queryParam: {
            'pageSize': 10,
          },
        );
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final searchProvider = context.read<SearchViewModel>();
      searchProvider.setSearchCallbackResponse(false, notify: true);
      searchController.text = searchProvider.getPreviousSearchText;
    });
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // const HomeHeader(hasBorder: false,),
            const VSpace(height: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppThemeUtil.radius(16.0),
                    vertical: AppThemeUtil.radius(15.0),
                  ),
                  decoration: ShapeDecoration(
                    color: kGrey100,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const AppIcon(
                    Icons.arrow_back,
                    size: 24,
                    color: kPrimaryBlack,
                  ),
                ).onPressed(() {
                  AppNavigator.pop(context);
                }),
                const HSpace(width: 8),
                BaseView<SearchViewModel>(
                  builder: (context, searchConsumer, child) => AppInputField(
                    hintText: "Find anything",
                    autocorrect: false,
                    enableSuggestions: false,
                    controller: searchController,
                    focusNode: searchFocusNode,
                    textInputAction: TextInputAction.search,
                    onChanged: _onSearchChanged,
                    autofocus: true,
                    // suffixIcon: !searchConsumer.getSearchCallbackResponse ?
                    // AppIcon(
                    //   PoyntIcon.magnifier,
                    //   color: kPoyntBlack,
                    //   size: AppTheme.radius(16.0),
                    // ).onPressed(() async{
                    //   if(searchController.text.isEmpty) return;
                    //   searchFocusNode.unfocus();
                    //   await context.read<SearchViewModel>().searchAll(context, requestBody: {"searchInput": searchController.text});
                    // })
                    //     :
                    // AppIcon(
                    //   Icons.close,
                    //   color: kPoyntBlack,
                    //   size: AppTheme.radius(20.0),
                    // ).onPressed(() {
                    //   sl.get<MixpanelService>().trackAuthEvent('Clear Search Text', userProvider.getUser);
                    //   searchController.clear();
                    //   searchFocusNode.requestFocus();
                    //   context.read<SearchViewModel>().setSearchCallbackResponse(false, notify: true);
                    // }),
                    onFieldSubmitted: (String value) async {
                      if (value.isEmpty) return;
                      await context.read<SearchViewModel>().searchAllProducts(
                        context,
                        requestBody: {"searchInput": value},
                        queryParam: {'pageSize': kProductPerPage},
                      );
                    },
                    helperHeight: 0.1,
                  ).flexible(),
                ),
              ],
            ).paddingSymmetric(horizontal: kWidthPadding),
            const VSpace(height: 8.0),
            const Divider(
              color: kGrey100,
              height: 1,
            ),
            BaseView<SearchViewModel>(
              builder: (context, searchConsumer, child) {
                if (searchConsumer.isComponentLoading('searchAllProducts') &&
                    searchConsumer.getProducts.isEmpty) {
                  return const ProductLoadingEffect();
                }

                if (searchConsumer.errorType != null &&
                    searchConsumer.errorType.toString().toLowerCase().trim() ==
                        'no record found') {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const AiderEmptyState(
                        title: '',
                        subtitle: 'No item found',
                        // iconData: PoyntIcon.bag31,
                      ).paddingOnly(bottom: 80),
                    ],
                  );
                }

                if (searchConsumer.errorType != null) {
                  return Center(
                    child: ErrorResponseMessage(
                      message: searchConsumer.errorType.toString(),
                      onRetry: () async {
                        await searchAllProducts(
                            searchConsumer.getProductMeta?.next);
                      },
                    ),
                  );
                }

                final searchResult = searchConsumer.getProducts;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (searchResult.isNotEmpty) ...[
                      AppLoadMore(
                        isFinish: searchConsumer.getProductMeta?.next == null,
                        onLoadMore: () => searchAllProducts(
                            searchConsumer.getProductMeta?.next),
                        children: [
                          ProductGridView(
                            products: searchConsumer.getProducts,
                            primary: false,
                          ),
                        ],
                      ).paddingSymmetric(horizontal: kWidthPadding).expanded()
                    ],
                  ],
                );
              },
            ).expanded(),
          ],
        ),
      ),
    );
  }

  _onSearchChanged(String? query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    if (query!.isEmpty) {
      context
          .read<SearchViewModel>()
          .setSearchCallbackResponse(false, notify: true);
    }
    _debounce = Timer(const Duration(milliseconds: 500), () async {
      if (query.trim().isEmpty) return;
      await context.read<SearchViewModel>().searchAllProducts(
        context,
        requestBody: {"searchInput": searchController.text},
        queryParam: {
          'pageSize': 10,
        },
      );
    });
  }
}
