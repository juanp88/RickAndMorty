import 'package:flutter/material.dart';
import 'package:rick_and_morty/view/home.dart';

Map<String, WidgetBuilder> generateRoutes() {
  return {
    // 'home': (BuildContext context) => Home(),
    'home': (BuildContext context) => HomePage(),
  };
}
