
import 'dart:collection';

mixin class CanRent{
  Map<String, dynamic> _dates = {};
  Map<String, dynamic> _location = {};
  String _timeOfExchange = '';
  String _placeId = '';
  int _quantity = 1;

  UnmodifiableMapView<String, dynamic> get getDates => UnmodifiableMapView(_dates);
  UnmodifiableMapView<String, dynamic> get getLocation => UnmodifiableMapView(_location);

  get getTimeOfExchange => _timeOfExchange;
  get getPlaceId => _placeId;

  set setDates(Map<String, dynamic> dates){
    _dates = {..._dates, ...dates};
  }

  void removeDates(){
    _dates.clear();
  }

  int get getQuantity => _quantity;

  set setQuantity(int quantity){
    _quantity = quantity;
  }

  set setLocation(Map<String, dynamic> location){
    _location = {..._location, ...location};
  }

  set setTimeOfExchange(String timeOfExchange){
    _timeOfExchange = timeOfExchange;
  }

  set setPlaceId(String placeId){
    _placeId = placeId;
  }

  void removePlaceId(){
    _placeId.replaceAll(_placeId, "");
  }
}