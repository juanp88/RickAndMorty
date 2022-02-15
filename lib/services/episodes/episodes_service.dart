import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rick_and_morty/model/episodes.dart';
import 'package:rick_and_morty/utils/api_status.dart';
import 'package:rick_and_morty/utils/constants.dart';

class EpisodesService {
  static Future<Object> getAllEpisodes(int page) async {
    try {
      final response = await http.get(
          Uri.parse(
              '${Constants.baseURL}/${Constants.episodeEndpoint}?page=$page'),
          headers: {'Content-Type': 'application/json'});
      if (response.statusCode == 200) {
        //var res = utf8.decode(response.bodyBytes);
        var episodeResponse =
            EpisodesResult.fromJson(json.decode(response.body));
        //debugPrint(characterResponse.results);
        return Success(response: episodeResponse);
      }
      return Failure(code: 100, errorResponse: 'Invalid Response');
    } on HttpException {
      return Failure(code: 101, errorResponse: 'No Internet');
    } catch (e) {
      debugPrint(e.toString());
      return Failure(code: 103, errorResponse: 'Unknown Error');
    }
  }
}
