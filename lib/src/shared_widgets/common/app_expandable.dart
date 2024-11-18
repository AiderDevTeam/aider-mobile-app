
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/colors.dart';
import '../../../core/utils/app_theme_util.dart';

class AppExpandable extends StatelessWidget {
  const AppExpandable({
    super.key,
    this.header,
    required this.collapsed,
    required this.expanded,
  });

  final Widget? header;
  final Widget collapsed;
  final Widget expanded;

  @override
  Widget build(BuildContext context) {
    return ExpandablePanel(
      theme: ExpandableThemeData(
        expandIcon: Icons.add,
        iconColor: kGrey600,
        iconSize: AppThemeUtil.radius(20),
        collapseIcon: Icons.minimize,
        iconPadding: EdgeInsets.only(top: AppThemeUtil.height(18.0)),
      ),
      header: header,
      collapsed: collapsed,
      expanded: expanded,
    );
  }
}
