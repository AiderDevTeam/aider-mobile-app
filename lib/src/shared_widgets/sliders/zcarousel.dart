import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class ZCarousel extends StatelessWidget {
  const ZCarousel({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    this.initialPage = 0,
    this.autoPlay = false,
    this.viewportFraction = 0.8,
    this.height,
    this.aspectRatio = 16/9,
    this.enlargeCenterPage = false,
    this.onPageChanged,
    this.onScrolled,
    this.enableInfiniteScroll = true,
    this.autoPlayInterval = const Duration(seconds: 4),
  });

  final int itemCount;
  final Widget Function(BuildContext, int, int) itemBuilder;
  final int initialPage;
  final bool autoPlay;
  final double viewportFraction;
  final double? height;
  final double aspectRatio;
  final bool enlargeCenterPage;
  final Function(int, CarouselPageChangedReason)? onPageChanged;
  final void Function(double?)? onScrolled;
  final bool enableInfiniteScroll;
  final Duration autoPlayInterval;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      options: CarouselOptions(
        height: height,
        autoPlay: autoPlay,
        initialPage: initialPage,
        viewportFraction: viewportFraction,
        aspectRatio: aspectRatio,
        enlargeCenterPage: enlargeCenterPage,
        enableInfiniteScroll: enableInfiniteScroll,
        onPageChanged: onPageChanged,
        onScrolled: onScrolled,
        autoPlayInterval: autoPlayInterval,
      ),
      itemCount: itemCount,
      itemBuilder: itemBuilder,
    );
  }
}
