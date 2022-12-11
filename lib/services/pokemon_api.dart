import 'dart:convert';

import 'package:flutter/foundation.dart';
import '../models/pokemon.dart';
import 'package:http/http.dart' as http;

final Uri url = Uri.parse(
    'https://gist.githubusercontent.com/hungps/0bfdd96d3ab9ee20c2e572e47c6834c7/raw/pokemons.json');

List<Pokemon> parsePokemons(String responseBody) {
  var list = jsonDecode(responseBody) as List<dynamic>;
  List<Pokemon> pokemons =
      list.map((model) => Pokemon.fromJson(model)).toList();
  return pokemons;
}

Future<List<Pokemon>> fetchPokemons() async {
  final response = await http.get(url).timeout(const Duration(seconds: 10));
  if (response.statusCode == 200) {
    return compute(parsePokemons, response.body);
  } else {
    throw Exception('Cannot get Pokemons');
  }
}
