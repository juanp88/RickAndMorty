import 'package:flutter/material.dart';
import 'package:rick_and_morty/routes.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty/viewmodel/character_view_model.dart';
import 'package:rick_and_morty/viewmodel/episodes_view_model.dart';
import 'package:rick_and_morty/viewmodel/locations_view_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return (MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => EpisodesViewModel()),
        ChangeNotifierProvider(create: (_) => LocationsViewModel()),
        ChangeNotifierProvider(create: (_) => CharacterViewModel())
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: 'home',
        routes: generateRoutes(),
        debugShowCheckedModeBanner: false,
      ),
    ));
  }
}
