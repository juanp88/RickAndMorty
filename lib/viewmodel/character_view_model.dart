import 'package:flutter/Material.dart';
import 'package:http/http.dart';
import 'package:rick_and_morty/model/characters.dart';
import 'package:rick_and_morty/services/characters/character_service.dart';
import 'package:rick_and_morty/utils/api_status.dart';

enum LoadMoreStatus { LOADING, STABLE }

class CharacterViewModel extends ChangeNotifier {
  bool _isLoading = false;
  var _characterListModel = [];
  late Info _info;
  int totalPages = 0;

  bool get isLoading => _isLoading;
  get characterListModel => _characterListModel;
  get info => _info;

  LoadMoreStatus _loadMoreStatus = LoadMoreStatus.STABLE;
  getLoadMoreStatus() => _loadMoreStatus;

  // CharacterViewModel() {
  //   getCharacters(_currentPage);
  // }

  setLoadingState(LoadMoreStatus loadMoreStatus) {
    _loadMoreStatus = loadMoreStatus;
    notifyListeners();
  }

  // setPage(int page) {
  //   _currentPage = page;
  // }

  // setLoading(bool loading) async {
  //   _isLoading = loading;
  //   notifyListeners();
  // }

  setCharacterListModel(characterListModel) {
    _characterListModel = characterListModel;
  }

  setInfo(Info info) {
    _info = info;
  }

  getCharacters(_currentPage) async {
    // setLoading(true);
    var response = await CharacterService.getAllCharacters(_currentPage);
    if (response is Success) {
      if (characterListModel.length == 0) {
        var list = response.response as Results;
        setCharacterListModel(list.results);
        setInfo(list.info);
        totalPages = info.pages;
      } else {
        var list = response.response as Results;
        _characterListModel.addAll(list.results);
      }
      setLoadingState(LoadMoreStatus.STABLE);
      notifyListeners();
    }
    if (_currentPage > totalPages) {
      // One load more is done will make it status as stable.
      setLoadingState(LoadMoreStatus.STABLE);
      notifyListeners();
    }

    //setLoading(false);
  }
}
