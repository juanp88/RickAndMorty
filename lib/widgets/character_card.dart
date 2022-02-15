import 'package:flutter/material.dart';
import 'package:rick_and_morty/utils/constants.dart';

class CharacterCard extends StatelessWidget {
  String name, gender, origin, location, image;
  int episodesNumber;

  CharacterCard(
      {Key? key,
      required this.name,
      required this.gender,
      required this.origin,
      required this.location,
      required this.episodesNumber,
      required this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
    return Scaffold(
      appBar: AppBar(
          //title: ,
          ),
      body: Center(
        child: Card(
            elevation: 20,
            // shape: RoundedRectangleBorder(
            //     borderRadius: BorderRadius.circular(18.0),
            //     side: BorderSide(color: Colors.blue.shade700)),
            color: Constants.tilesColor,
            child: Container(
              padding: const EdgeInsets.all(30),
              width: devicePixelRatio * 120,
              height: devicePixelRatio * 170,
              child: Column(
                children: [
                  SizedBox(
                      width: devicePixelRatio * 60,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image.network(image))),
                  Spacer(),
                  Text(
                    name,
                    style: Constants.cardTitle,
                  ),
                  Spacer(),
                  Text("Genero: " + gender),
                  Text("Origen: " + origin),
                  Text(location),
                  Text("Numero de episodios: " + episodesNumber.toString()),
                  Spacer(),
                ],
              ),
            )),
      ),
    );
    // throw UnimplementedError();
  }
}


// Widget userCard(String name, String email, String phone) {
//   return Card(
//       margin: const EdgeInsets.fromLTRB(20, 10, 20, 5),
//       child: Column(children: [
//         ListTile(
//           contentPadding: const EdgeInsets.fromLTRB(20, 20, 10, 10),
//           title: Text(
//             name,
//             style: cardTitle,
//           ),
//           subtitle: Column(
//             children: [
//               SizedBox(
//                 height: 40,
//                 child: ListTile(
//                   contentPadding: const EdgeInsets.all(0),
//                   leading: const Icon(
//                     Icons.phone,
//                     color: iconsColors,
//                     size: cardIconSize,
//                   ),
//                   title: Text(
//                     phone,
//                     style: cardSubText,
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 40,
//                 child: ListTile(
//                   //tileColor: Colors.yellow,
//                   contentPadding: const EdgeInsets.all(0),
//                   leading: const Icon(
//                     Icons.mail,
//                     color: iconsColors,
//                     size: cardIconSize,
//                   ),
//                   title: Text(
//                     email,
//                     style: cardSubText,
//                   ),
//                 ),
//               ),
//               Container(
//                   padding: const EdgeInsets.fromLTRB(0, 0, 10, 10),
//                   child: const Align(
//                       alignment: Alignment.bottomRight,
//                       child: Text('Ver publicaciones'))),
//             ],
//           ),
//         )
//       ]));
// }
