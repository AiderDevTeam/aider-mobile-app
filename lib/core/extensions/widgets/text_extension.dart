import 'package:flutter/material.dart';

import '../../utils/app_theme_util.dart';

extension StyledText<T extends Text> on T {
  Text copyWith({
    String? data,
    TextStyle? style,
    StrutStyle? strutStyle,
    TextAlign? textAlign,
    TextDirection? textDirection,
    Locale? locale,
    bool? softWrap,
    TextOverflow? overflow,
    TextScaler? textScaler,
    int? maxLines,
    String? semanticsLabel,
    TextWidthBasis? textWidthBasis,
  }) =>
      Text(
        data ?? this.data ?? "",
        style: style ?? this.style,
        strutStyle: strutStyle ?? this.strutStyle,
        textAlign: textAlign ?? this.textAlign,
        locale: locale ?? this.locale,
        maxLines: maxLines ?? this.maxLines,
        overflow: overflow ?? this.overflow,
        semanticsLabel: semanticsLabel ?? this.semanticsLabel,
        softWrap: softWrap ?? this.softWrap,
        textDirection: textDirection ?? this.textDirection,
        textScaler: textScaler?? this.textScaler,
        textWidthBasis: textWidthBasis ?? this.textWidthBasis,
      );

  T textStyle(TextStyle? style) => copyWith(
    style: (this.style ?? const TextStyle()).copyWith(
      background: style?.background,
      backgroundColor: style?.backgroundColor,
      color: style?.color,
      debugLabel: style?.debugLabel,
      decoration: style?.decoration,
      decorationColor: style?.decorationColor,
      decorationStyle: style?.decorationStyle,
      decorationThickness: style?.decorationThickness,
      fontFamily: style?.fontFamily,
      fontFamilyFallback: style?.fontFamilyFallback,
      fontFeatures: style?.fontFeatures,
      fontSize: style?.fontSize,
      fontStyle: style?.fontStyle,
      fontWeight: style?.fontWeight,
      foreground: style?.foreground,
      height: style?.height,
      inherit: style?.inherit,
      letterSpacing: style?.letterSpacing,
      locale: style?.locale,
      shadows: style?.shadows,
      textBaseline: style?.textBaseline,
      wordSpacing: style?.wordSpacing,
    ),
  ) as T;

  T textScale(TextScaler textScaler) =>
      copyWith(textScaler: textScaler) as T;

  T wrapAround(bool? softWrap) =>
      copyWith(softWrap: softWrap) as T;

  T black() => copyWith(
    style: (style ?? const TextStyle()).copyWith(
      fontFamily: 'Inter-Black',
      fontStyle: FontStyle.normal,
    ),
  ) as T;

  T extraBold() => copyWith(
    style: (style ?? const TextStyle()).copyWith(
      fontFamily: 'Inter-ExtraBold',
      fontStyle: FontStyle.normal,
    ),
  ) as T;

  T bold() => copyWith(
    style: (style ?? const TextStyle()).copyWith(
      fontFamily: 'Inter-Bold',
      fontStyle: FontStyle.normal,
    ),
  ) as T;

  T semiBold() => copyWith(
    style: (style ?? const TextStyle()).copyWith(
      fontFamily: 'Inter-SemiBold',
      fontStyle: FontStyle.normal,
    ),
  ) as T;

  T medium() => copyWith(
    style: (style ?? const TextStyle()).copyWith(
      fontFamily: 'Inter-Medium',
      fontStyle: FontStyle.normal,
    ),
  ) as T;

  T regular() => copyWith(
    style: (style ?? const TextStyle()).copyWith(
      fontFamily: 'Inter-Regular',
      fontStyle: FontStyle.normal,
    ),
  ) as T;

  T italic() => copyWith(
    style: (style ?? const TextStyle()).copyWith(
      fontStyle: FontStyle.italic,
    ),
  ) as T;

  T fontSize(double size) => copyWith(
    style: (style ?? const TextStyle()).copyWith(
      fontSize: AppThemeUtil.fontSize(size),
    ),
  ) as T;

  T letterSpacing(double space) => copyWith(
    style: (style ?? const TextStyle()).copyWith(
      letterSpacing: AppThemeUtil.getLetterSpacing(space),
    ),
  ) as T;

  T height(double figmaSize, double fontSize) => copyWith(
    style: (style ?? const TextStyle()).copyWith(
      height: AppThemeUtil.getLineHeight(figmaSize, fontSize),
    ),
  ) as T;

  T wordSpacing(double space) => copyWith(
    style: (style ?? const TextStyle()).copyWith(
      wordSpacing: space,
    ),
  ) as T;

  T textShadow({
    Color color = const Color(0x34000000),
    double blurRadius = 0.0,
    Offset offset = Offset.zero,
  }) =>
      copyWith(
        style: (style ?? const TextStyle()).copyWith(
          shadows: [
            Shadow(
              color: color,
              blurRadius: blurRadius,
              offset: offset,
            ),
          ],
        ),
      ) as T;

  T color(Color color, [Color? darkModeColor]) => copyWith(
    style: (style ?? const TextStyle()).copyWith(
      color: AppThemeUtil.getThemeColor(color, darkModeColor),
    ),
  ) as T;

  T alignText(TextAlign align) => copyWith(textAlign: align) as T;

  T overflowText(TextOverflow overflow) => copyWith(overflow: overflow) as T;

  T textMaxLines(int? maxLines) => copyWith(maxLines: maxLines) as T;

  T textDirection(TextDirection direction) =>
      copyWith(textDirection: direction) as T;

  T textBaseline(TextBaseline textBaseline) => copyWith(
    style: (style ?? const TextStyle()).copyWith(
      textBaseline: textBaseline,
    ),
  ) as T;

  T textWidthBasis(TextWidthBasis textWidthBasis) =>
      copyWith(textWidthBasis: textWidthBasis) as T;

  T withUnderLine() => copyWith(
      style: (style ?? const TextStyle())
          .copyWith(decoration: TextDecoration.underline)) as T;

  T lineThrough(Color? color, [double? thickness]) => copyWith(
      style: (style ?? const TextStyle())
          .copyWith(decoration: TextDecoration.lineThrough, decorationColor: color, decorationThickness: thickness,)) as T;
}