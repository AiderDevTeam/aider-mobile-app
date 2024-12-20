import 'package:aider_mobile_app/core/extensions/widgets/flexible_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/padding_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/text_extension.dart';
import 'package:aider_mobile_app/src/shared_widgets/common/v_space.dart';
import 'package:flutter/material.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/common.dart';
import '../../../core/utils/app_theme_util.dart';
import '../buttons/app_primary_button.dart';
import '../buttons/app_text_button.dart';
import '../common/row_text.dart';
import 'app_card.dart';

class ItemGridView extends StatelessWidget {
  const ItemGridView({
    super.key,
    required this.sections,
  });

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
            // RowText(
            //   leftWidget: Text(section['name']?? '')
            //       .bold()
            //       .fontSize(20)
            //       .letterSpacing(-0.22).overflowText(TextOverflow.ellipsis).flexible(),
            //   rightWidget: AppTextButton(
            //     onPressed: () {
            //       // sl.get<MixpanelService>().trackAuthEvent(
            //       //     'See All ${(section['name']?? '').toString().ucWords}',
            //       //     context.read<UserViewModel>().getUser,
            //       //     section: section as Map<String, dynamic>
            //       // );
            //       // if(section['type'] == 'category'){
            //       //   AppNavigatorUtil.pushNamed(context, AppRoute.seeAllCategoryProductScreen, arguments: section);
            //       // }
            //       // if(section['type'] == 'product'){
            //       //   AppNavigatorUtil.pushNamed(context, AppRoute.seeAllProductScreen, arguments: section);
            //       // }
            //       // if(section['type'] == 'shop'){
            //       //   AppNavigatorUtil.pushNamed(context, AppRoute.seeAllShops, arguments: section);
            //       // }
            //       // if(section['type'] == 'closet'){
            //       //   AppNavigatorUtil.pushNamed(context, AppRoute.seeAllHotClosets, arguments: section);
            //       // }
            //     },
            //     text: "See all",
            //   ).paddingOnly(left: 8.0),
            // ).paddingOnly(left: kWidthPadding, right: 20, bottom: 12),
            RowText(
              leftWidget: const Text('Top categories')
                  .bold()
                  .fontSize(20)
                  .letterSpacing(-0.22).overflowText(TextOverflow.ellipsis).flexible(),
              rightWidget: AppTextButton(
                onPressed: () {
                },
                text: "See all",
              ).paddingOnly(left: 8.0),
            ),
            if(section['type'] == 'top categories')...[
              // const CategoriesCard(subCategories: [],)
              // Wrap(
              //   spacing: 16,
              //   children: List.generate(3, (index){
              //     return AppCard(
              //       width: AppThemeUtil.width(113),
              //       padding: EdgeInsets.only(top: AppThemeUtil.height(66)),
              //       decoration: ShapeDecoration(
              //         image: const DecorationImage(
              //           image: NetworkImage("https://via.placeholder.com/117x110"),
              //           fit: BoxFit.fill,
              //         ),
              //         shape: RoundedRectangleBorder(
              //           side: const BorderSide(
              //             width: 1,
              //             color: kGrey100,
              //           ),
              //           borderRadius: BorderRadius.circular(12),
              //         ),
              //       ),
              //       child: Container(
              //         height: AppThemeUtil.height(44),
              //         color: kPrimaryWhite.withOpacity(0.94),
              //         child: const Text("Electronics").bold().fontSize(12).height(0.8, 12).paddingOnly(
              //           top: AppThemeUtil.height(10),
              //         ).toCenter(),
              //       ),
              //     );
              //   }),
              // ),
            ],

            if(section['type'] == 'banner')...[
              AppCard(
                width: double.infinity,
                height: AppThemeUtil.height(350),
                padding: const EdgeInsets.all(kWidthPadding),
                decoration: ShapeDecoration(
                  image: const DecorationImage(
                    image: NetworkImage("https://via.placeholder.com/374x350"),
                    fit: BoxFit.fill,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text("Party prep and setup").semiBold().fontSize(24).height(30, 24),
                    const VSpace(height: 12),
                    AppPrimaryButton(
                      text: "See Listings",
                      minWidth: AppThemeUtil.width(111),
                      // height: AppThemeUtil.height(36),
                      onPressed: (){},
                      color: kPrimaryWhite,
                      textColor: kPrimaryBlack,
                      borderColor: kGrey700,
                    ),
                  ],
                ),
              ),
            ],
            if(section['type'] == 'shop')...[
              // ShopHorizontalListView(section: section),
            ],
            if(section['type'] == 'product')...[
              // SectionProductGridView(section: section),
            ]
          ],
        ).paddingOnly(bottom: index== sections.length? 0.0: 20.0);
      },
    );
  }
}
