import 'package:flutter/material.dart';

class AppListTile extends StatelessWidget {
  const AppListTile({
    super.key,
    this.leading,
    this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
    this.contentPadding,
    this.minLeadingWidth,
    this.tileColor,
    this.shape,
  });

  final Widget? leading;
  final Widget? title;
  final Widget? subtitle;
  final Widget? trailing;
  final void Function()? onTap;
  final EdgeInsetsGeometry? contentPadding;
  final double? minLeadingWidth;
  final Color? tileColor;
  final ShapeBorder? shape;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: ListTile(
        shape: shape,
        tileColor: tileColor,
        dense: true,
        contentPadding: contentPadding?? EdgeInsets.zero,
        minLeadingWidth: minLeadingWidth?? 12,
        onTap: onTap,
        leading: leading,
        title: title,
        subtitle: subtitle,
        trailing: trailing,
      ),
    );
  }
}
