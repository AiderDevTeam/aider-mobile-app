import 'package:flutter/material.dart';

import '../../../core/routing/app_navigator.dart';
import 'aider_app_bar.dart';

class AppScreenScaffold extends StatelessWidget {
  const AppScreenScaffold({
    super.key,
    required this.child,
    this.title,
    this.onNavigateBack,
    this.resizeToAvoidBottomInset,
    this.scaffoldKey,
    this.appBar = true,
    this.bottomNavigationBar,
    this.bottomSheet,
    this.appBarActions,
    this.hasLeading = true,
    this.floatingActionButton,
    this.hasBottomBorder = true,
    this.backgroundColor,
    this.appBarBackgroundColor,
    this.titleFontSize,
    this.titleWidget,
  });

  final Widget child;
  final String? title;
  final void Function()? onNavigateBack;
  final bool? resizeToAvoidBottomInset;
  final GlobalKey<ScaffoldState>? scaffoldKey;
  final bool appBar;
  final Widget? bottomNavigationBar;
  final Widget? bottomSheet;
  final List<Widget>? appBarActions;
  final bool hasLeading;
  final Widget? floatingActionButton;
  final bool hasBottomBorder;
  final Color? backgroundColor;
  final Color? appBarBackgroundColor;
  final double? titleFontSize;
  final Widget? titleWidget;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      backgroundColor: backgroundColor,
      appBar: appBar
          ? AiderAppBar(
              appBar: AppBar(),
              title: title ?? '',
              hasLeading: hasLeading,
              onPressed: onNavigateBack ??
                  () {
                    AppNavigator.pop(context);
                  },
              actions: appBarActions,
              hasBottomBorder: hasBottomBorder,
              appBarBackgroundColor: appBarBackgroundColor,
              titleFontSize: titleFontSize,
              titleWidget: titleWidget,
            )
          : null,
      body: SafeArea(child: child),
      bottomNavigationBar: bottomNavigationBar,
      bottomSheet: bottomSheet,
      floatingActionButton: floatingActionButton,
    );
  }
}
