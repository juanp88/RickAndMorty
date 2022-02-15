import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:provider/src/provider.dart';
import 'package:rick_and_morty/model/characters.dart';
import 'package:rick_and_morty/view/characters_list_view.dart';
import 'package:rick_and_morty/viewmodel/character_view_model.dart';
import 'package:rick_and_morty/viewmodel/episodes_view_model.dart';
import 'package:rick_and_morty/viewmodel/locations_view_model.dart';
import 'package:rick_and_morty/widgets/info_card.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int episodes = 0;
  late String maxLocation = '';
  List allCharacters = [];
  List allLocations = [];
  final ScrollController _scrollController = ScrollController();
  int _page = 1;

  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);

    var dataProvider = Provider.of<CharacterViewModel>(context, listen: false);
    dataProvider.getCharacters(_page);

    _scrollController.addListener(() {
      //esto me permite llamar la función de obtener mas paginas cuando el scroll llega al final de la pantalla
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (_page < dataProvider.totalPages) {
          _page += 1;
          dataProvider.getCharacters(_page);
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    EpisodesViewModel episodesViewModel = context.watch<EpisodesViewModel>();
    episodes = episodesViewModel.totalEpisodes;
    LocationsViewModel locationsViewModel = context.watch<LocationsViewModel>();
    allLocations = locationsViewModel.locationListModel;
    var devicePixelRatio = MediaQuery.of(context).devicePixelRatio;

    if (allLocations.isNotEmpty) {
      var maxResidents = 0;
      for (int i = 0; i < allLocations.length; i++) {
        var locationLength = allLocations[i].residents.length;
        if (locationLength > maxResidents) {
          maxResidents = locationLength;
          maxLocation = allLocations[i].name;
        }
      }
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Personajes Rick and Morty '),
        ),
        body: Column(
          children: [
            Expanded(
              flex: 1,
              child: InfoCard(episodes: episodes, maxLocation: maxLocation),
            ),
            Consumer<CharacterViewModel>(
                builder: (context, characterViewModel, child) {
              return Expanded(
                  flex: 4,
                  child: buildCharactersListView(
                      characterViewModel, _scrollController));
            })
          ],
        ),
      ),
    );
  }
}
