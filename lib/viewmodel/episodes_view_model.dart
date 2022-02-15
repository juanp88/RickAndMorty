import 'package:flutter/material.dart';
import 'package:rick_and_morty/model/episodes.dart';
import 'package:rick_and_morty/services/episodes/episodes_service.dart';
import 'package:rick_and_morty/utils/api_status.dart';

class EpisodesViewModel extends ChangeNotifier {
  bool _isLoading = false;
  var _episodesListModel = [];
  int _totalEpisodes = 0;
  int _currentPage = 1;

  bool get isLoading => _isLoading;
  get episodesListModel => _episodesListModel;
  get totalEpisodes => _totalEpisodes;

  EpisodesViewModel() {
    getEpisodes();
  }

  setPage(int page) {
    _currentPage = page;
  }

  setLoading(bool loading) async {
    _isLoading = loading;
    notifyListeners();
  }

  setEpisodesListModel(episodesListModel) {
    _episodesListModel = episodesListModel;
  }

  setTotalEpisodes(int total) {
    _totalEpisodes = total;
  }

  getEpisodes() async {
    setLoading(true);
    var response = await EpisodesService.getAllEpisodes(_currentPage);
    if (response is Success) {
      var list = response.response as EpisodesResult;
      setTotalEpisodes(list.info.count);
      setEpisodesListModel(list.results);
    }
    setLoading(false);
  }
}
