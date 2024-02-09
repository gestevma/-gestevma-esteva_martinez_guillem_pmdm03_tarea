import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:pokemons_app/models/models.dart';
import 'package:pokemons_app/models/pokedex/pokedex_response.dart';

class DesciptionsProvider extends ChangeNotifier {
  Map<int, String> pokemonsDescriptions = {};

  DesciptionsProvider() {
    getOnDisplayDescription();
  }

  getOnDisplayDescription() async {
    List<dynamic> descriptions;

    for (int pokemonNumber = 1; pokemonNumber <= 151; pokemonNumber++) {
      var url =
          Uri.https('pokeapi.co', '/api/v2/pokemon-species/$pokemonNumber');

      var result = await http.get(url);

      descriptions = json.decode(result.body)["flavor_text_entries"];

      for (int i = 0; i < descriptions.length; i++) {
        if (descriptions[i]["language"]["name"] == "es") {
          pokemonsDescriptions[pokemonNumber] =
              descriptions[i]["flavor_text"].replaceAll("\n", " ");
          break;
        }
      }
    }

    notifyListeners();
  }
}
