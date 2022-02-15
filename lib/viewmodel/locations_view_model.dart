import 'package:flutter/material.dart';
import 'package:rick_and_morty/model/location.dart';
import 'package:rick_and_morty/services/locations/location_service.dart';
import 'package:rick_and_morty/utils/api_status.dart';

class LocationsViewModel extends ChangeNotifier {
  bool _isLoading = false;
  var _locationsListModel = [];
  int _currentPage = 1;

  bool get isLoading => _isLoading;
  get locationListModel => _locationsListModel;

  LocationsViewModel() {
    getLocations();
  }

  setPage(int page) {
    _currentPage = page;
  }

  setLoading(bool loading) async {
    _isLoading = loading;
    notifyListeners();
  }

  setLocationsListModel(locationListModel) {
    _locationsListModel = locationListModel;
  }

  getLocations() async {
    setLoading(true);
    var response = await LocationService.getAllLocations(_currentPage);
    if (response is Success) {
      var list = response.response as LocationResult;
      setLocationsListModel(list.results);
    }
    setLoading(false);
  }
}
