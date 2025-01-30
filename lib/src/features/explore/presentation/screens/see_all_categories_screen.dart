import 'package:aider_mobile_app/core/constants/common.dart';
import 'package:aider_mobile_app/core/extensions/widgets/center_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/gesture_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/padding_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/text_extension.dart';
import 'package:aider_mobile_app/core/providers/base_view.dart';
import 'package:aider_mobile_app/src/features/explore/presentation/providers/explore_view_provider.dart';
import 'package:aider_mobile_app/src/shared_widgets/base/app_screen_scaffold.dart';
import 'package:aider_mobile_app/src/shared_widgets/common/aider_empty_state.dart';
import 'package:aider_mobile_app/src/shared_widgets/common/app_load_more.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/constants/colors.dart';
import '../../../../../core/routing/app_navigator.dart';
import '../../../../../core/routing/app_route.dart';
import '../../../../../core/utils/app_theme_util.dart';
import '../../../../shared_widgets/common/error_response_message.dart';
import '../../../../shared_widgets/common/network_image_view.dart';
import '../widgets/category_loading_effect.dart';

class SeeAllCategoriesScreen extends StatefulWidget {
  const SeeAllCategoriesScreen({
    super.key,
    required this.param,
  });

  final Map<String, dynamic> param;

  @override
  State<SeeAllCategoriesScreen> createState() => _SeeAllCategoriesScreenState();
}

class _SeeAllCategoriesScreenState extends State<SeeAllCategoriesScreen> {
  Future<void> fetchCategories([int page = 1]) async {
    if (!mounted) return;
    await context.read<ExploreViewProvider>().fetchCategories(
          context,
          sectionExternalId: widget.param['externalId'],
          page: page,
        );
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (widget.param['type'] == 'section') {
        await fetchCategories();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppScreenScaffold(
      title: "Categories",
      child: BaseView<ExploreViewProvider>(
          builder: (context, exploreConsumer, child) {
        if (exploreConsumer.isComponentLoading('categories') &&
            exploreConsumer.getCategories.isEmpty) {
          return const CategoryLoadingEffect();
        }

        if (exploreConsumer.isComponentErrorType('categories')) {
          return Center(
            child: ErrorResponseMessage(
              message: exploreConsumer.componentErrorType?['error'] ?? '',
              onRetry: () async {
                await fetchCategories(exploreConsumer.getCategoriesPageNumber);
              },
            ),
          );
        }

        if (exploreConsumer.getCategories.isEmpty) {
          return const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AiderEmptyState(
                title: '',
                subtitle: 'No categories found yet',
              ),
            ],
          ).paddingOnly(bottom: 40);
        }

        return AppLoadMore(
          isFinish: exploreConsumer.hasNoCategoryData,
          onLoadMore: () =>
              fetchCategories(exploreConsumer.getCategoriesPageNumber),
          isLoaderVisible: !exploreConsumer.isComponentLoading('categories'),
          children: [
            GridView.builder(
              shrinkWrap: true,
              primary: false,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: AppThemeUtil.width(12.0),
                mainAxisSpacing: AppThemeUtil.height(24),
              ),
              padding: EdgeInsets.symmetric(
                horizontal: AppThemeUtil.width(kWidthPadding),
              ),
              itemCount: exploreConsumer.getCategories.length,
              physics: const ClampingScrollPhysics(),
              itemBuilder: (BuildContext context, index) {
                final category = exploreConsumer.getCategories[index];
                return Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: kGrey200,
                        ),
                        // color: kGrey200,
                        borderRadius: BorderRadius.all(
                            Radius.circular(AppThemeUtil.radius(
                          12.0,
                        )))),
                    child: Stack(
                      children: [
                        NetworkImageView(
                          imageUrl: category.imageUrl ?? '',
                          width: AppThemeUtil.width(116),
                          height: AppThemeUtil.height(110),
                          radius: 12.0,
                        ),
                        Positioned(
                          bottom: 0,
                          child: Container(
                            height: AppThemeUtil.height(44),
                            width: AppThemeUtil.width(116),
                            padding: EdgeInsets.symmetric(
                                horizontal: AppThemeUtil.width(12),
                                vertical: AppThemeUtil.height(5)),
                            decoration: BoxDecoration(
                                color: kPrimaryWhite.withOpacity(0.94),
                                borderRadius: BorderRadius.only(
                                  bottomLeft:
                                      Radius.circular(AppThemeUtil.radius(
                                    12.0,
                                  )),
                                  bottomRight:
                                      Radius.circular(AppThemeUtil.radius(
                                    12.0,
                                  )),
                                )),
                            child: Text(
                              category.name ?? '',
                              maxLines: 2,
                            )
                                .medium()
                                .fontSize(12)
                                .color(kPrimaryBlack)
                                .wrapAround(true)
                                .overflowText(TextOverflow.ellipsis)
                                .toCenter(),
                          ),
                        ),
                      ],
                    )).onPressed(() {
                  AppNavigator.pushNamed(
                      context, AppRoute.seeAllRentalListeningScreen,
                      arguments: {
                        'type': 'category',
                        'externalId': category.externalId ?? '',
                        'title': category.name,
                      });
                });
              },
            ),
          ],
        );
      }),
    );
  }
}
