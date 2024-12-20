import 'package:flutter/material.dart';


extension PositionExtensions on Widget {
  Positioned position({
    Key? key,
    double? top,
    double? bottom,
    double? left,
    double? right,
    double? width,
    double? height,
  }) =>
      Positioned(
        key: key,
        top: top,
        bottom: bottom,
        left: left,
        right: right,
        width: width,
        height: height,
        child: this,
      );

  Positioned positionTop({
    Key? key,
    double top = 0.0,
    double? width,
    double? height,
  }) =>
      Positioned(
        key: key,
        top: top,
        width: width,
        height: height,
        child: this,
      );

  Positioned positionBottom({
    Key? key,
    double bottom = 0.0,
    double? width,
    double? height,
  }) =>
      Positioned(
        key: key,
        bottom: bottom,
        width: width,
        height: height,
        child: this,
      );

  Positioned positionLeft({
    Key? key,
    double left = 0.0,
    double? width,
    double? height,
  }) =>
      Positioned(
        key: key,
        bottom: left,
        width: width,
        height: height,
        child: this,
      );

  Positioned positionRight({
    Key? key,
    double right = 0.0,
    double? width,
    double? height,
  }) =>
      Positioned(
        key: key,
        bottom: right,
        width: width,
        height: height,
        child: this,
      );

}