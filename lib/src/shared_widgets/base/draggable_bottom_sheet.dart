import 'package:flutter/material.dart';

import '../../../core/utils/helper_util.dart';

class DraggableBottomSheet extends StatefulWidget {
  const DraggableBottomSheet({
    super.key,
    this.initialChildSize = 0.93,
    this.minChildSize = 0.85,
    this.maxChildSize = 1.0,
    this.snap = false,
    this.clearAccountName = false,
    this.draggableScrollableController,
    required this.builder,
  });

  final double initialChildSize;
  final double minChildSize;
  final double maxChildSize;
  final bool snap;
  final bool clearAccountName;
  final DraggableScrollableController? draggableScrollableController;
  final Widget Function(BuildContext, ScrollController) builder;

  @override
  State<DraggableBottomSheet> createState() => _DraggableBottomSheetState();
}

class _DraggableBottomSheetState extends State<DraggableBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        Navigator.pop(context);
      },
      child: GestureDetector(
        onTap: () {},
        child: DraggableScrollableSheet(
          controller: widget.draggableScrollableController,
          initialChildSize: HelperUtil.isIOS ? (widget.initialChildSize - 0.05) : widget.initialChildSize,
          minChildSize: HelperUtil.isIOS ? (widget.minChildSize - 0.05) : widget.minChildSize,
          maxChildSize: HelperUtil.isIOS ? (widget.maxChildSize - 0.05) : widget.maxChildSize,
          snap: widget.snap,
          builder: widget.builder,
        ),
      ),
    );
  }
}
