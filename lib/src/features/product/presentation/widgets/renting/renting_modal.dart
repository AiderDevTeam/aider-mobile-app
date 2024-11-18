import 'package:aider_mobile_app/src/features/product/presentation/widgets/renting/renting_calendar_modal_content.dart';
import 'package:aider_mobile_app/src/features/product/presentation/widgets/renting/time_location_modal.dart';
import 'package:flutter/material.dart';
import '../../../../../shared_widgets/base/draggable_bottom_sheet.dart';
import '../../../../../shared_widgets/modals/draggable_bottom_sheet_content.dart';
import '../../../domain/models/product/product_model.dart';
import 'renting_summary_modal_content.dart';



class RentingModal extends StatefulWidget {
  const RentingModal({super.key, required this.product,});

  final ProductModel product;

  @override
  State<RentingModal> createState() => _RentingModalState();
}

class _RentingModalState extends State<RentingModal> {
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
      initialChildSize: getInitialChildSize(progress, 0.65, 0.90),
      minChildSize: 0.60,
      builder: (context, scrollController){
        return DraggableBottomSheetContent(
          stopScroll: true,
          draggableKey: GlobalKey(),
          scrollController: scrollController,
          modalHeaderContent: const SizedBox.shrink(),
          hasBottomBorder: false,
          content: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: _pageController,
            children: [
              RentingCalendarModalContent(
                pageController: _pageController,
                product: widget.product,
              ),
              RentingTimeAndLocationModalContent(
                pageController: _pageController,
                product: widget.product,
              ),
              RentingSummaryModalContent(
                pageController: _pageController,
                product: widget.product,
              ),
            ],
          ),
        );
      },
    );
  }


  // double getInitialChildSize(double progress, double init){
  //   if(progress == 0) return init;
  //   return init + (progress/(5.0));
  // }

  double getInitialChildSize(double progress, double init, double max) {
    if (progress == 0) {
      return init;
    } else {
      final newSize = init + (progress / 5.0);
      return newSize.clamp(init, max);
    }
  }
}
