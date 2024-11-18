
import 'dart:io';

import '../../src/features/product/domain/models/product_price/product_price_model.dart';
import '../constants/common.dart';
import '../routing/app_navigator.dart';
import '../routing/app_route.dart';
import '../services/git_it_service_locator.dart';
import '../services/local_storage_service.dart';

class HelperUtil{
  static void logOut(){
    sl.get<LocalStorageService>().clearOnLogout();
    AppNavigator.pushNamedAndRemoveUntil(AppNavigator.navigatorKey.currentContext!, AppRoute.onboardingScreen, (route) => false);
  }

  static bool get isIOS => Platform.isIOS;

  static int get timeOutSeconds => 30;

  static String addZeroToSingleInteger(int? time) => (time?? 0).toString().padLeft(2, '0');

  static String get getOSPlatform {
    if (Platform.isAndroid) return 'android';

    if (Platform.isIOS) return 'ios';

    return 'unknown';
  }

  static List<String> getLocalityFromAddressComponents(List addressComponents){
    if(addressComponents.isEmpty) return ['', ''];
    final city = StringBuffer();
    String region = '';
    for(Map address in addressComponents){
      final types = address['types']?? [''];
      if(types.first == 'neighborhood'){
        city.write((address['long_name']?? '').toString().isEmpty? '': '${address['long_name']?? ''} ');
      }
      if(types.first == 'sublocality_level_1'){
        city.write((address['long_name']?? '').toString().isEmpty? '': '${address['long_name']?? ''} ');
      }
      if(types.first == 'locality'){
        city.write((address['long_name']?? '').toString().isEmpty? '': '${address['long_name']?? ''} ');
      }
      if(types.first == 'administrative_area_level_1'){
        region = address['long_name']?? '';
      }
    }

    return [city.toString().trim(), region];
  }

  static bool isDateDayValid(String date){
    String day = date.split('/').first.toString();
    return (int.parse(day) <= 31);
  }

  static bool isDateMonthValid(String date){
    List<String> splitDate = date.split('/');
    if(splitDate.length > 1 && splitDate[1].toString().isNotEmpty) return (int.parse(splitDate[1].toString()) <= 12);
    return false;
  }

  static bool isDateYearValid(String date){
    List<String> splitDate = date.split('/');
    if(splitDate.length > 2 && splitDate.last.toString().isNotEmpty) return (int.parse(splitDate.last.toString()) > 999);
    return false;
  }

  static bool isEighteenAndBelow(String date){
    List<String> splitDate = date.split('/');

    if(splitDate.length > 2 && splitDate.last.toString().isNotEmpty && splitDate.last.toString().length == 4){
      final now = DateTime.now();
      final chosenDate = DateTime.parse(splitDate.reversed.join('-'));
      return ((now.year - 18) < chosenDate.year);
    }
    return false;
  }

  static int countCameraProductImage(List<Map<String, dynamic>> images){
    return images.where((map) => map['id'].toString().startsWith('cam')).length;
  }

  static int countGalleryProductImage(List<Map<String, dynamic>> images){
    return images.where((map) => !map['id'].toString().startsWith('cam')).length;
  }

  static bool isSvgImage(String iconName){
    if(iconName.isEmpty) return false;
    String extension = iconName.substring(iconName.length - 3);
    return extension == 'svg';
  }

  static int getDuration(DateTime startDate, DateTime endDate) => endDate.difference(startDate).inDays;

  static double getDurationPrice(List<ProductPriceModel> prices, int duration) {
    final index = (prices).indexWhere((obj){
      if(obj.endDay == null){
        return duration >= (obj.startDay?? 0);
      }else{
        return duration >= (obj.startDay?? 0) && duration <= (obj.endDay?? 0);
      }
    });

    if(index >= 0) return (prices[index].price?? 0).toDouble();

    return 0;
  }

  static double getTotalDurationPrice(List<ProductPriceModel> prices, int duration){
    return getDurationPrice(prices, duration) * duration;
  }

  static double calculateRatingWidth(int numberOfStars, int vendorReviewsCount){
    return vendorReviewsCount == 0? 0.0 : (numberOfStars / vendorReviewsCount) * kRatingWidth;
  }

}