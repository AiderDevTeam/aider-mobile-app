
import 'package:aider_mobile_app/core/constants/colors.dart';
import 'package:aider_mobile_app/src/features/product/presentation/view_models/product_view_model.dart';
import 'package:aider_mobile_app/src/features/product/presentation/widgets/category_modal_content.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../shared_widgets/common/app_bottom_nav_wrapper.dart';
import '../../../../shared_widgets/base/draggable_bottom_sheet.dart';
import '../../../../shared_widgets/buttons/app_primary_button.dart';
import '../../../../shared_widgets/modals/draggable_bottom_sheet_content.dart';
import 'all_category_modal_content.dart';
import 'sub_category_modal_content.dart';

class ProductCategoryModal extends StatefulWidget {
  const ProductCategoryModal({super.key});

  @override
  State<ProductCategoryModal> createState() => _ProductCategoryModalState();
}

class _ProductCategoryModalState extends State<ProductCategoryModal> {
  final _pageController = PageController(initialPage: 0);

  @override
  void initState() {
    _pageController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double progress = _pageController.hasClients ? (_pageController.page ?? 0) : 0;
    return DraggableBottomSheet(
      initialChildSize: getInitialChildSize(progress, 0.70),
      minChildSize: 0.60,
      builder: (context, scrollController){
        return DraggableBottomSheetContent(
          draggableKey: GlobalKey(),
          scrollController: scrollController,
          title: getTitle(progress),
          goBack: progress < 1? null : (){
            _pageController.animateToPage(
              (progress - 1).toInt(),
              duration: const Duration(milliseconds: 400),
              curve: Curves.ease,
            );
          },
          content: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: _pageController,
            children: [
              CategoryModalContent(pageController: _pageController, scrollController: scrollController),
              AllCategoryModalContent(pageController: _pageController,),
              SubCategoryModalContent(pageController: _pageController,),
            ],
          ),
          bottomNavigationBar: progress > 0.3 ? null : AppBottomNavWrapper(
            child: AppPrimaryButton(
              onPressed: (){
                context.read<ProductViewModel>().emitCategories();
                _pageController.animateToPage(
                  1,
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.ease,
                );
              },
              text: 'See all categories',
              color: kPrimaryWhite,
              textColor: kGrey1000,
              borderColor: kGrey700,
            ),
          ),
        );
      },
    );
  }


  double getInitialChildSize(double progress, double init){
    if(progress == 0) return init;
    if(progress > 1) return init + (progress/(6.6*progress));
    return init + (progress/(6.6));
  }

  String getTitle(double progress){
    if(progress > 1.2) return context.read<ProductViewModel>().getCategoryModalTitle;
    return 'Select category';
  }
}
