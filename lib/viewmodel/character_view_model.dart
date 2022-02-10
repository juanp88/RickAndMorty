import 'package:flutter/Material.dart';
import 'package:http/http.dart';
import 'package:rick_and_morty/model/characters.dart';
import 'package:rick_and_morty/services/characters/character_service.dart';
import 'package:rick_and_morty/utils/api_status.dart';

class CharacterViewModel extends ChangeNotifier {
  bool _isLoading = false;
  var _characterListModel = [];
  late Info _info;
  int _currentPage = 1;

  bool get isLoading => _isLoading;
  get characterListModel => _characterListModel;
  get info => _info;

  CharacterViewModel() {
    getCharacters();
  }

  setPage(int page) {
    _currentPage = page;
  }

  setLoading(bool loading) async {
    _isLoading = loading;
    notifyListeners();
  }

  setCharacterListModel(characterListModel) {
    _characterListModel = characterListModel;
  }

  setInfo(Info info) {
    _info = info;
  }

  getCharacters() async {
    setLoading(true);
    var response = await CharacterService.getAllCharacters(_currentPage);
    if (response is Success) {
      var list = response.response as Results;
      setCharacterListModel(list.results);
      setInfo(list.info);
    }
    setLoading(false);
  }
}
