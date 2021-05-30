import 'package:flutter/foundation.dart';
import 'package:lezato/data/api/api_service.dart';
import 'package:lezato/data/model/response/response_restaurant.dart';

enum ResultState { Loading, NoData, HasData, Error }

class AppProvider extends ChangeNotifier {
  final ApiService apiService;

  AppProvider({@required this.apiService}) {
    _fetchRestaurants();
  }

  ResponseRestaurant _responseRestaurant;
  ResultState _state;
  String _message;

  ResponseRestaurant get result => _responseRestaurant;
  ResultState get state => _state;
  String get message => _message;

  Future<dynamic> _fetchRestaurants() async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final response = await apiService.getList();
      if (response.restaurants.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'No data';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _responseRestaurant = response;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}
