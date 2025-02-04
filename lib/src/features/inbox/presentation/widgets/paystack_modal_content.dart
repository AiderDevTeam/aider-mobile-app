import 'package:aider_mobile_app/core/constants/colors.dart';
import 'package:aider_mobile_app/core/extensions/widgets/expanded_extension.dart';
import 'package:aider_mobile_app/core/routing/app_navigator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../shared_widgets/base/draggable_bottom_sheet.dart';
import '../../../../shared_widgets/modals/draggable_bottom_sheet_content.dart';

class PayStackModalContent extends StatefulWidget {
  const PayStackModalContent({
    super.key,
    required this.paymentUrl,
    this.onWebResourceError,
    this.confirmationButton,
  });

  final String paymentUrl;
  final ValueSetter<WebResourceError>? onWebResourceError;
  final Widget? confirmationButton;

  @override
  State<PayStackModalContent> createState() => _PayStackModalContentState();
}

class _PayStackModalContentState extends State<PayStackModalContent> {
  final controller = WebViewController();

  final loadingProgress = ValueNotifier<double>(0);

  @override
  void initState() {
    super.initState();
    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            loadingProgress.value = progress / 100;
          },
          onWebResourceError: (WebResourceError error) {
            if (widget.onWebResourceError != null) {
              widget.onWebResourceError!(error);
            }
          },
          onNavigationRequest: (NavigationRequest request) {
            final uri = Uri.parse(request.url);
            if (uri.hasQuery && uri.queryParameters.containsKey('reference')) {
              AppNavigator.pop(context, uri.queryParameters['reference']);
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.paymentUrl));
  }

  @override
  void setState(VoidCallback fn) {
    if (!mounted) return;

    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: DraggableBottomSheet(
        initialChildSize: 1.0,
        minChildSize: 1.0,
        builder: (context, scrollController) {
          return DraggableBottomSheetContent(
            draggableKey: GlobalKey(),
            scrollController: scrollController,
            title: 'Make Payment',
            onClose: () => AppNavigator.pop(context, 'next'),
            content: Column(
              children: [
                ValueListenableBuilder<double>(
                    valueListenable: loadingProgress,
                    builder: (context, loadingProgressValue, child) {
                      if (loadingProgressValue < 1) {
                        return LinearProgressIndicator(
                          value: loadingProgressValue,
                          color: kAider800,
                        );
                      }
                      return const SizedBox.shrink();
                    }),
                WebViewWidget(
                  controller: controller,
                  gestureRecognizers: {Factory(() => EagerGestureRecognizer())},
                ).expanded(),
              ],
            ),
          );
        },
      ),
    );
  }
}
