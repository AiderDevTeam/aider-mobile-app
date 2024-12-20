
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/colors.dart';


class AppThemeUtil {

  static final lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: kPrimaryWhite,
    scaffoldBackgroundColor: kPrimaryWhite,
    colorScheme: const ColorScheme.light(),
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.all(Colors.transparent),
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: kPrimaryWhite,
      elevation: 0,
    ),
  ).copyWith(
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: <TargetPlatform, PageTransitionsBuilder>{
        TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder()
      },
    ),
  );


  static final darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: kPrimaryBlack,
    scaffoldBackgroundColor: kPrimaryBlack,
    colorScheme: const ColorScheme.dark(),
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.all(Colors.transparent),
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: kPrimaryBlack,
      elevation: 0,
    ),
  ).copyWith(
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: <TargetPlatform, PageTransitionsBuilder>{
        TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder()
      },
    ),
  );


  static Color getThemeColor(Color lightColor, [Color? darkColor]){
    // final themeProvider = ThemeProvider();
    // return themeProvider.getThemeMode == ThemeMode.light ? lightColor : darkColor?? lightColor;
    return lightColor;
  }

  static bool isDarkMode(){
    // final themeProvider = ThemeProvider();
    // return themeProvider.getThemeMode == ThemeMode.dark;
    return false;
  }


  static double fontSize(double fontSize) => fontSize.sp;

  static double width(double width) => width.w;

  static double height(double height) => height.h;

  static double radius(double radius) => radius.r;

  static double getLineHeight(double figmaSize, double fontSize) => figmaSize/fontSize.sp;

  static double getLetterSpacing(double figmaSize) => figmaSize/100;


}
