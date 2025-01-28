import 'dart:async';

import 'package:aider_mobile_app/core/constants/colors.dart';
import 'package:aider_mobile_app/core/extensions/widgets/align_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/expanded_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/gesture_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/padding_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/text_extension.dart';
import 'package:aider_mobile_app/core/routing/app_navigator.dart';
import 'package:aider_mobile_app/core/utils/app_theme_util.dart';
import 'package:aider_mobile_app/core/providers/base_view.dart';
import 'package:aider_mobile_app/src/shared_widgets/common/aider_empty_state.dart';
import 'package:aider_mobile_app/src/shared_widgets/common/v_space.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/constants/common.dart';
import '../../../../../core/providers/wallet_provider.dart';
import '../../../../shared_widgets/base/draggable_bottom_sheet.dart';
import '../../../../shared_widgets/forms/app_input_field.dart';
import '../../../../shared_widgets/modals/draggable_bottom_sheet_content.dart';
import '../../../transaction/presentation/providers/transaction_provider.dart';

class SearchBanksModal extends StatefulWidget {
  const SearchBanksModal({super.key});

  @override
  State<SearchBanksModal> createState() => _SearchBanksModalState();
}

class _SearchBanksModalState extends State<SearchBanksModal> {
  final searchController = TextEditingController();
  final searchFocusNode = FocusNode();
  Timer? _debounce;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      context.read<TransactionProvider>().fetchBanks();
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
    return DraggableBottomSheet(
      initialChildSize: 0.80,
      minChildSize: 0.75,
      builder: (context, scrollController) {
        return DraggableBottomSheetContent(
          draggableKey: GlobalKey(),
          scrollController: scrollController,
          title: 'Search bank',
          content: Column(
            children: [
              const VSpace(height: 8),
              AppInputField(
                hintText: 'Search bank',
                controller: searchController,
                focusNode: searchFocusNode,
                onChanged: _onSearchChanged,
                helperHeight: 0.1,
              ).paddingSymmetric(horizontal: kWidthPadding),
              const VSpace(height: 16),
              BaseView<TransactionProvider>(
                  builder: (context, transactionConsumer, child) {
                final filteredBanks =
                    transactionConsumer.getFilteredBanks(searchController.text);
                if (filteredBanks.isEmpty) {
                  return const AiderEmptyState(
                    title: '',
                    subtitle: 'Search for your bank',
                  ).paddingOnly(top: 40);
                }
                return ListView.builder(
                  itemCount: filteredBanks.length,
                  itemBuilder: (context, index) {
                    final bank = filteredBanks[index];
                    return Container(
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(
                          horizontal: AppThemeUtil.width(8.0)),
                      padding: EdgeInsets.symmetric(
                          vertical: AppThemeUtil.height(12.0),
                          horizontal: AppThemeUtil.width(20.0)),
                      color: kGrey50,
                      child: Text(bank.name ?? '')
                          .regular()
                          .fontSize(16)
                          .color(kGrey1200),
                    )
                        .onPressed(() {
                          AppNavigator.pop(context, bank);
                        })
                        .alignCenterLeft()
                        .paddingOnly(bottom: 8);
                  },
                ).expanded();
              }),
            ],
          ),
        );
      },
    );
  }

  _onSearchChanged(String? query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 100), () {
      setState(() {}); // Trigger rebuild to update filtered results
    });
  }
}
