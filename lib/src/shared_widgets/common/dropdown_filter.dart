import 'package:aider_mobile_app/core/constants/colors.dart';
import 'package:aider_mobile_app/core/extensions/widgets/flexible_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/gesture_extension.dart';
import 'package:aider_mobile_app/core/extensions/widgets/text_extension.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/text_style.dart';
import '../../../core/utils/app_theme_util.dart';
import '../buttons/app_icon_text_button.dart';
import '../buttons/app_text_button.dart';
import 'h_space.dart';

class DropdownFilter extends StatefulWidget {
  const DropdownFilter({
    super.key,
    required this.listItems,
    this.selectedItem,
    this.isSmall = false,
    this.dropDownOffset,
    this.onChanged,
    this.dropdownHeight,
    this.height = 48.0,
    this.width = 294.0,
    this.padding,
    this.backgroundColor,
    this.borderColor,
    this.textStyle,
    this.iconColor,
    this.textButton = false,
    this.scrollableItems = false,
    this.isIconRight = false,
    this.mainAxisSize = MainAxisSize.max,
    this.dropDownExpansionWidth = 30.0,
    this.actionButton,
  });

  final List<String> listItems;
  final String? selectedItem;
  final bool isSmall;
  final Offset? dropDownOffset;
  final void Function(String)? onChanged;
  final double? dropdownHeight;
  final double height;
  final double width;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final Color? borderColor;
  final TextStyle? textStyle;
  final Color? iconColor;
  final bool textButton;
  final bool scrollableItems;
  final bool isIconRight;
  final MainAxisSize mainAxisSize;
  final double dropDownExpansionWidth;
  final Widget? actionButton;

  @override
  State<DropdownFilter> createState() => DropdownFilterState();
}

class DropdownFilterState extends State<DropdownFilter> {
  OverlayEntry? _entry;
  final _layerLink = LayerLink();
  bool _isFilterOpened = false;
  String? _selectedItem;


  @override
  void initState() {
    _selectedItem = widget.selectedItem;
    WidgetsBinding.instance.addPostFrameCallback((_) => hideOverlay());
    super.initState();
  }

  void _showOverlay() {
    final overlay = Overlay.of(context);
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;

    _entry = OverlayEntry(
      builder: (context) => Positioned(
        width: size.width + widget.dropDownExpansionWidth,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(widget.dropDownOffset?.dx?? 0, (size.height+(widget.dropDownOffset?.dy?? 0))),
          child: Material(
            color: AppThemeUtil.getThemeColor(kPrimaryBlack),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppThemeUtil.radius(12.0)),
              side: BorderSide(color: AppThemeUtil.getThemeColor(kPrimaryBlack)),
            ),
            elevation: 1,
            child: SizedBox(
              height: widget.dropdownHeight,
              child: ListView.builder(
                physics: widget.scrollableItems? null : const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.only(
                  top: AppThemeUtil.height(8.0),
                  bottom: AppThemeUtil.height(16.0),
                  left: AppThemeUtil.height(10.0),
                  right: AppThemeUtil.height(10.0),
                ),
                shrinkWrap: true,
                itemCount: widget.listItems.length,
                itemBuilder: (context, index){
                  final text = widget.listItems[index];
                  return AppTextButton(
                    onPressed: (){
                      if(widget.onChanged != null){
                        widget.onChanged?.call(text);
                      }
                      setState(() => _selectedItem = text );
                      hideOverlay();
                    },
                    child: SizedBox(width: double.infinity, child: Text(text).semiBold().fontSize(16.0).color(kPrimaryWhite)),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );

    overlay.insert(_entry!);

    setState(() => _isFilterOpened = true );
  }

  void hideOverlay() {
    _entry?.remove();
    _entry = null;
    setState(() => _isFilterOpened = false );
  }


  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: widget.actionButton == null? widget.textButton ?
      AppTextButton(
        onPressed: (){
          if(_isFilterOpened) {
            hideOverlay();
            return;
          }
          _showOverlay();
        },
        child: Row(
          children: [
            Text(
              _selectedItem?? '',
            ).bold().fontSize(20.0).color(kPrimaryBlack).overflowText(TextOverflow.ellipsis).flexible(),
            const HSpace(width: 8.0),
            Icon(
              Icons.keyboard_arrow_down_outlined,
              size: AppThemeUtil.radius(24.0),
              color: AppThemeUtil.getThemeColor(kPrimaryBlack),
            ),
          ],
        )
      )
      :
      AppIconTextButton(
        onPressed: (){
          if(_isFilterOpened) {
            hideOverlay();
            return;
          }
          _showOverlay();
        },
        isIconRight: widget.isIconRight,
        mainAxisSize: widget.mainAxisSize,
        icon: Icon(
          Icons.keyboard_arrow_down_outlined,
          color: widget.iconColor?? AppThemeUtil.getThemeColor(kPrimaryBlack),
        ),
        color: widget.backgroundColor?? AppThemeUtil.getThemeColor(kPrimaryWhite),
        borderColor: widget.borderColor?? AppThemeUtil.getThemeColor(kPrimaryBlack),
        text: _selectedItem?? '',
        textStyle: widget.textStyle?? kSemiBoldFontStyle.copyWith(
          fontSize: AppThemeUtil.fontSize(16.0),
          color: AppThemeUtil.getThemeColor(kPrimaryBlack),
        ),
        height: AppThemeUtil.height(widget.height),
        minWidth: AppThemeUtil.width(widget.width),
        scaledText: false,
      ) : widget.actionButton!.onPressed((){
        if(_isFilterOpened) {
          hideOverlay();
          return;
        }
        _showOverlay();
      }),
    );
  }
}
