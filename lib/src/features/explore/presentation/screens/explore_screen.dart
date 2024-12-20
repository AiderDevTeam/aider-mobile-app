import 'package:aider_mobile_app/core/extensions/widgets/expanded_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/padding_extension.dart';
import 'package:aider_mobile_app/core/view_models/base_view.dart';
import 'package:aider_mobile_app/src/features/explore/presentation/widgets/sections/explore_section_list_view.dart';
import 'package:aider_mobile_app/src/shared_widgets/base/app_screen_scaffold.dart';
import 'package:aider_mobile_app/src/shared_widgets/common/v_space.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/constants/common.dart';
import '../../../../shared_widgets/common/app_load_more.dart';
import '../../../../shared_widgets/common/error_response_message.dart';
import '../../../inbox/presentation/view_models/inbox_view_model.dart';
import '../view_models/explore_view_model.dart';
import '../widgets/explore_header.dart';
import '../widgets/explore_section_loading_effect.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  AutovalidateMode autoValidate = AutovalidateMode.disabled;
  final scaffoldKey = GlobalKey<ScaffoldState>();


  Future<void> fetchSections([int page = 1]) async {
    if (!mounted) return;
    await context.read<ExploreViewModel>().fetchSections(
      context,
      queryParams: {
        'page': page,
        'dataPerPage': kSectionPerPage,
      },
    );
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async{
      if(!mounted) return;
      await context.read<InboxViewModel>().initState();
      await fetchSections();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppScreenScaffold(
      scaffoldKey: scaffoldKey,
      appBar: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const VSpace(height: 14.0),
          const ExploreHeader(
            hasBorder: false,
            hasSearchBar: true,
          ),

          BaseView<ExploreViewModel>(
            builder: (context, exploreConsumer, child) {
              if(exploreConsumer.getComponentLoading('sections') && exploreConsumer.getSections.isEmpty){
                return const ExploreSectionLoadingEffect();
              }

              if(exploreConsumer.isComponentErrorType('sections')){
                return SizedBox(
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ErrorResponseMessage(
                        message: exploreConsumer.componentErrorType?['error']?? '',
                        onRetry: () async{
                          await fetchSections(exploreConsumer.getSectionCurrentPageNumber);
                        },
                      ),
                    ],
                  ),
                );
              }

              return AppLoadMore(
                isFinish: exploreConsumer.hasNoSectionData,
                onLoadMore: () => fetchSections(exploreConsumer.getSectionCurrentPageNumber),
                isLoaderVisible: !exploreConsumer.getComponentLoading('sections'),
                children: [
                  ExploreSectionListView(
                    sections: exploreConsumer.getSections,
                  ),
                ],
              );
            }
          ).expanded(),
        ],
      ).paddingSymmetric(horizontal: kWidthPadding),
    );
  }
}
