import 'package:aider_mobile_app/core/constants/common.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/view_models/base_view.dart';
import '../../../../shared_widgets/common/aider_empty_state.dart';
import '../../../../shared_widgets/common/app_load_more.dart';
import '../../../../shared_widgets/common/error_response_message.dart';
import '../../../../shared_widgets/common/zloading.dart';
import '../view_model/rental_view_model.dart';
import '../widgets/my_items_card.dart';

class MyItemsTabScreen extends StatefulWidget {
  const MyItemsTabScreen({super.key, this.isVendor = true});
  final bool isVendor;


  @override
  State<MyItemsTabScreen> createState() => _MyItemsTabScreenState();
}

class _MyItemsTabScreenState extends State<MyItemsTabScreen> {
  Future<void> fetchMyItems([String? nextPage]) async{
    await context.read<RentalViewModel>().fetchMyItems(
        context,
        nextPage: nextPage,
        queryParams: {
          'pageSize': kProductPerPage,
          'type': 'vendor'
        }
    );
  }
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async{
      await fetchMyItems();
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BaseView<RentalViewModel>(
      builder: (context, rentalConsumer, child) {

        if(rentalConsumer.getComponentLoading('fetchMyItems') && rentalConsumer.getMyItemsProducts.isEmpty){
          return const Center(
            child: ZLoading(),
          );
        }

        if(rentalConsumer.isComponentErrorType('fetchMyItems')){
          return Center(
            child: ErrorResponseMessage(
              message: rentalConsumer.componentErrorType?['error']?? '',
              onRetry: () async{
                await fetchMyItems(rentalConsumer.getMyItemsProductMeta?.next);
              },
            ),
          );
        }

        if(rentalConsumer.getMyItemsProducts.isEmpty) {
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
          onRefresh: fetchMyItems,
          child: AppLoadMore(
            isFinish: rentalConsumer.getMyItemsProductMeta?.next == null,
            onLoadMore: () => fetchMyItems(rentalConsumer.getMyItemsProductMeta?.next),
            children: [
              ListView.builder(
                shrinkWrap: true,
                primary: false,
                itemCount: rentalConsumer.getMyItemsProducts.length,
                itemBuilder: (context, index) {
                  return MyItemCard(
                    rentalProduct: rentalConsumer.getMyItemsProducts[index],
                    isVendor: true,
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
