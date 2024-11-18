import 'package:aider_mobile_app/core/extensions/widgets/flexible_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/gesture_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/padding_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/text_extension.dart';
import 'package:aider_mobile_app/src/features/explore/presentation/widgets/sections/explore_section_category_view.dart';
import 'package:aider_mobile_app/src/features/explore/presentation/widgets/sections/product_section_grid_view.dart';
import 'package:aider_mobile_app/src/shared_widgets/common/network_image_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../../../../core/constants/colors.dart';
import '../../../../../../core/routing/app_navigator.dart';
import '../../../../../../core/routing/app_route.dart';
import '../../../../../../core/utils/app_theme_util.dart';
import '../../../../../shared_widgets/buttons/app_primary_button.dart';
import '../../../../../shared_widgets/cards/app_card.dart';
import '../../../../../shared_widgets/common/row_text.dart';
import '../../../../../shared_widgets/common/v_space.dart';

class ExploreSectionListView extends StatelessWidget {
  const ExploreSectionListView({
    super.key,
    this.showAmount = true,
    required this.sections,
  });

  final bool showAmount;
  final List sections;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      primary: false,
      itemCount: sections.length,
      itemBuilder: (context, index){
        final section = sections[index];
        return Column(
          children: [
            if(section['type'] != 'productCard') ...[
              const VSpace(height: 12.0),
              RowText(
                leftWidget: Text(section['name']?? '').bold().fontSize(20).letterSpacing(-0.22).overflowText(TextOverflow.ellipsis).flexible(),
                rightWidget: AppCard(
                  borderRadius: 100,
                  backgroundColor: kGrey50,
                  padding: EdgeInsets.symmetric(
                    horizontal: AppThemeUtil.width(8.0),
                    vertical: AppThemeUtil.height(4.0),
                  ),
                  child: Text(section['type'] == 'product'? 'See More' : "See All").bold().fontSize(14.0).color(kGrey1200),
                ).onPressed((){
                  if(section['type'] == 'category'){
                    AppNavigator.pushNamed(context, AppRoute.seeAllCategoriesScreen, arguments: {
                      'type': 'section',
                      'externalId': section['externalId']
                    });
                    return;
                  }
                  if(section['type'] == 'product'){
                    AppNavigator.pushNamed(context, AppRoute.seeAllRentalListeningScreen, arguments: {
                      'type': 'section',
                      'title': section['name'],
                      'externalId': section['externalId']
                    });
                    return;
                  }
                }).paddingOnly(left: 8.0),
              ),
            ],
            if(section['type'] == 'category')...[
              const VSpace(height: 24.0),
              ExploreSectionCategoryView(
                categories: section['data']?? [],
              ),
            ],
            if(section['type'] == 'productCard')...[
              const VSpace(height: 24.0),
              Stack(
                children: [
                  NetworkImageView(
                    imageUrl: section['data']?['imageUrl']?? '',
                    width: double.infinity,
                    height: AppThemeUtil.height(350),
                    radius: 20.0,
                  ),
                  Positioned(
                    bottom: 0,
                    child: Container(
                      height: AppThemeUtil.height(148),
                      width: AppThemeUtil.width(374),
                      decoration: ShapeDecoration(
                        color: const Color(0xB7121315),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(AppThemeUtil.radius(12)),
                            bottomRight: Radius.circular(AppThemeUtil.radius(12)),
                          ),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(section['name']?? '')
                              .semiBold()
                              .fontSize(24)
                              .height(30, 24).color(kPrimaryWhite),
                          const VSpace(height: 12),
                          AppPrimaryButton(
                            text: "See Listings",
                            minWidth: AppThemeUtil.width(111),
                            height: 36.0,
                            onPressed: () {
                              if(section['type'] == 'productCard'){
                                AppNavigator.pushNamed(context, AppRoute.seeAllRentalListeningScreen, arguments: {
                                  'type': 'section',
                                  'title': section['name'],
                                  'externalId': section['externalId']
                                });
                                return;
                              }
                            },
                            color: kPrimaryWhite,
                            textColor: kPrimaryBlack,
                            borderColor: kGrey300,
                            fontSize: 14.0,
                          ),
                        ],
                      ).paddingAll(20.0),
                    ),
                  ),
                ],
              ),
            ],
            if(section['type'] == 'product')...[
              const VSpace(height: 24.0),
              ProductSectionGridView(
                section: section['data']?? [],
              )
            ],
          ],
        ).paddingOnly(bottom: index== sections.length? 0.0: 32.0);
      },
    );
  }
}
