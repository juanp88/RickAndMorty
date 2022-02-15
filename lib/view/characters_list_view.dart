import 'package:flutter/material.dart';
import 'package:rick_and_morty/model/characters.dart';
import 'package:rick_and_morty/utils/constants.dart';
import 'package:rick_and_morty/viewmodel/character_view_model.dart';
import 'package:rick_and_morty/widgets/character_card.dart';

Widget buildCharactersListView(
    CharacterViewModel characterViewModel, ScrollController scrollController) {
  if (characterViewModel.isLoading) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
  return ListView.separated(
      controller: scrollController,
      itemBuilder: (context, index) {
        var devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
        Character character = characterViewModel.characterListModel[index];
        return Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                height: devicePixelRatio * 50,
                // color: Colors.amber,
                margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
                // padding: EdgeInsets.all(10),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.network(
                      character.image,
                      fit: BoxFit.fill,
                      // height: 100,
                    )),
              ),
            ),
            Expanded(
                flex: 2,
                child: Container(
                  height: devicePixelRatio * 50,
                  color: Colors.grey.shade300,
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Container(
                          padding: const EdgeInsets.fromLTRB(5, 5, 0, 0),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            character.name,
                            style: Constants.titles,
                          )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(5, 10, 0, 0),
                            child: Icon(
                              Icons.circle,
                              size: 10,
                              color: character.status == "Alive"
                                  ? Colors.green
                                  : character.status == "Dead"
                                      ? Colors.red
                                      : Colors.grey,
                            ),
                          ),
                          Container(
                              // margin: EdgeInsets.all(10),
                              padding: const EdgeInsets.fromLTRB(5, 10, 0, 0),
                              child: Text(character.status))
                        ],
                      ),
                      Container(
                          //margin: const EdgeInsets.all(10),
                          padding: const EdgeInsets.fromLTRB(5, 5, 0, 0),
                          alignment: Alignment.centerLeft,
                          child: Text(character.species)),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          width: devicePixelRatio * 31,
                          height: devicePixelRatio * 12,
                          alignment: Alignment.bottomRight,
                          //color: Colors.white,
                          child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => CharacterCard(
                                              episodesNumber:
                                                  character.episode.length,
                                              image: character.image,
                                              location: character.location.name,
                                              gender: character.gender,
                                              name: character.name,
                                              origin: character.origin.name,
                                            )));
                              },
                              child: Text("Detalle")),
                        ),
                      )
                    ],
                  ),
                )),
          ],
        );
      },
      separatorBuilder: (context, index) => Container(
            height: 5,
          ),
      itemCount: characterViewModel.characterListModel.length);
}
