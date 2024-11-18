import 'package:aider_mobile_app/core/constants/common.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/view_models/base_view.dart';
import '../../../../shared_widgets/common/aider_empty_state.dart';
import '../../../../shared_widgets/common/app_load_more.dart';
import '../../../../shared_widgets/common/error_response_message.dart';
import '../../../../shared_widgets/common/zloading.dart';
import '../view_model/rental_view_model.dart';
import '../widgets/rented_item_card.dart';

class ItemRentedTabScreen extends StatefulWidget {
  const ItemRentedTabScreen({super.key, required this.type, this.isVendor = false});
  final String type;
  final bool isVendor;

  @override
  State<ItemRentedTabScreen> createState() => _ItemRentedTabScreenState();
}

class _ItemRentedTabScreenState extends State<ItemRentedTabScreen> {
  Future<void> fetchRentedItems([String? nextPage]) async{
    await context.read<RentalViewModel>().fetchRentedItems(
      context,
      nextPage: nextPage,
      queryParams: {
        'pageSize': kProductPerPage,
        'type': widget.type
      }
    );
  }
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async{
      await fetchRentedItems();
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BaseView<RentalViewModel>(
        builder: (context, rentalConsumer, child) {

          if(rentalConsumer.getComponentLoading('fetchRentedItems') && rentalConsumer.getRentalProducts.isEmpty){
            return const Center(
              child: ZLoading(),
            );
          }

          if(rentalConsumer.isComponentErrorType('fetchRentedItems')){
            return Center(
              child: ErrorResponseMessage(
                message: rentalConsumer.componentErrorType?['error']?? '',
                onRetry: () async{
                  await fetchRentedItems(rentalConsumer.getRentalProductMeta?.next);
                },
              ),
            );
          }

          if(rentalConsumer.getRentalProducts.isEmpty) {
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
            onRefresh: fetchRentedItems,
            child: AppLoadMore(
              isFinish: rentalConsumer.getRentalProductMeta?.next == null,
              onLoadMore: () => fetchRentedItems(rentalConsumer.getRentalProductMeta?.next),
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  itemCount: rentalConsumer.getRentalProducts.length,
                  itemBuilder: (context, index) {
                    return RentedItemCard(
                      rentalProduct: rentalConsumer.getRentalProducts[index],
                      isVendor: false,
                      isBookingPaid: true,
                    );
                  },
                ),
              ],
            ),
          );
        },
    );
  }
}
