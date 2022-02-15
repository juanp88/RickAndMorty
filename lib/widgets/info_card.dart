import 'package:flutter/material.dart';
import 'package:rick_and_morty/utils/constants.dart';

class InfoCard extends StatelessWidget {
  const InfoCard({
    Key? key,
    required this.episodes,
    required this.maxLocation,
  }) : super(key: key);

  final int episodes;
  final String maxLocation;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 20,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
          side: BorderSide(color: Colors.blue.shade700)),
      color: Constants.tilesColor,
      child: Container(
        padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
        child: Column(
          children: [
            const Text(
              "La serie en números",
              style: Constants.titles,
            ),
            Container(
              height: 10,
            ),
            episodes == 0
                ? const Text("Número de episodios:  ")
                : Text(
                    "Número de episodios: $episodes ",
                    style: Constants.titles,
                  ),
            Container(
              height: 10,
            ),
            const Text(
              "Locación con mas personajes: ",
              style: Constants.titles,
            ),
            Text(
              maxLocation,
              style: Constants.baseText,
            ),
          ],
        ),
      ),
    );
  }
}
