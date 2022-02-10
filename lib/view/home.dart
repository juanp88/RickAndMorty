import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:rick_and_morty/model/characters.dart';
import 'package:rick_and_morty/viewmodel/character_view_model.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final int episodes = 1;
  final String maxLocation = '';
  List allCharacters = [];

  @override
  Widget build(BuildContext context) {
    CharacterViewModel characterViewModel = context.watch<CharacterViewModel>();
    allCharacters = characterViewModel.characterListModel;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Rick and Morty Characters'),
      ),
      body: Column(
        children: [
          Expanded(
              flex: 1,
              child: Card(
                child: Column(
                  children: [
                    const Text("La serie en números"),
                    Text("Número de episodios:  $episodes"),
                    Text("Locación con mas Personajes: $maxLocation ")
                  ],
                ),
              )),
          Expanded(
              flex: 4, child: _buildCharactersListView(characterViewModel)),
        ],
      ),
    );
  }

  Widget _buildCharactersListView(CharacterViewModel characterViewModel) {
    if (characterViewModel.isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return ListView.separated(
        itemBuilder: (context, index) {
          Character character = allCharacters[index];
          return GestureDetector(
            child: Card(
              child: Text(character.name),
            ),
          );
        },
        separatorBuilder: (context, index) => Container(
              height: 5,
            ),
        itemCount: allCharacters.length);
  }
}
