import 'package:aider_mobile_app/core/extensions/widgets/padding_extension.dart';
import 'package:aider_mobile_app/src/shared_widgets/common/zloading.dart';
import 'package:flutter/material.dart';

class AppLoadMore extends StatefulWidget {
  const AppLoadMore({
    super.key,
    this.isFinish = false,
    required this.onLoadMore,
    required this.children,
    this.isLoaderVisible = true,
  });

  final bool isFinish;
  final Future<void> Function() onLoadMore;
  final List<Widget> children;
  final bool isLoaderVisible;

  @override
  State<AppLoadMore> createState() => _AppLoadMoreState();
}

class _AppLoadMoreState extends State<AppLoadMore> {
  bool canScroll = false;

  void loadMore() async{
    await widget.onLoadMore.call();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener(
      onNotification: (notification){
        if (notification is ScrollUpdateNotification) {
          canScroll = notification.metrics.maxScrollExtent > 0;
          if(mounted){
            setState(() {});
          }
        }

        if (notification is ScrollEndNotification && notification.metrics.pixels == notification.metrics.maxScrollExtent) {
          if(!widget.isFinish && canScroll){
            loadMore();
          }
        }
        return true;
      },
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: widget.children.length+1,
        itemBuilder: (context, index){
          if(index < widget.children.length){
            return widget.children[index];
          }else{
            return widget.isLoaderVisible ?
            Visibility(
              visible: !widget.isFinish && canScroll,
              child: Container(
                alignment: Alignment.center,
                child: const ZLoading().paddingOnly(top: 8.0, bottom: 24),
              ),
            )
            :
            const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
