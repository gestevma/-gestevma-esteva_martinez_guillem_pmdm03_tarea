import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:pokemons_app/models/models.dart';
import 'package:pokemons_app/models/pokedex/pokedex_response.dart';

class PokemonProvider extends ChangeNotifier {
  Map<int, Pokemon> pokemonsList = {};
  Map<int, String> pokemonDescription = {};

  PokemonProvider() {
    print("pokemon provider init");

    getOnDisplayPokemon();
  }

  List<int> pokemonLoadOrder() {
    List<int> pokemonsEntryNumbers = List.generate(151, (index) => index + 1);
    List<int> pokemonsLoadOrder = [];

    for (int i = 0; i < pokemonsEntryNumbers.length; i++) {
      int primers = i;
      int darrers = pokemonsEntryNumbers.length - 1 - i;

      pokemonsLoadOrder.add(pokemonsEntryNumbers[primers]);

      if (primers < darrers) {
        pokemonsLoadOrder.add(pokemonsEntryNumbers[darrers]);
      } else {
        break;
      }
    }

    return pokemonsLoadOrder;
  }

  getOnDisplayPokemon() async {
    List<int> pokemonsLoadOrder = pokemonLoadOrder();

    for (int pokemonNumber in pokemonsLoadOrder) {
      var url = Uri.https('pokeapi.co', '/api/v2/pokemon/$pokemonNumber');

      var result = await http.get(url);

      String pokemonName = getPokemonName(result.body);
      String pokemonImage = getPokemonImage(result.body);
      String pokemonImagePixel = getPokemonImagePixel(result.body);
      List<String> typesNames = getPokemonType(result.body);
      List<String> typesImages = getPokemonImageRoute(typesNames);
      int baseStats = getPokemonBaseStats(result.body);

      Pokemon pokemon = Pokemon(pokemonNumber, pokemonName, pokemonImage,
          pokemonImagePixel, typesNames, typesImages, baseStats);

      pokemonsList[pokemonNumber] = pokemon;

      notifyListeners();
    }
  }

  String getPokemonName(String jsonResponse) {
    String name = "";

    name = json.decode(jsonResponse)["forms"][0]["name"].toString();

    return name;
  }

  String getPokemonImage(String jsonResponse) {
    String image = "";

    image = json
        .decode(jsonResponse)["sprites"]["other"]["official-artwork"]
            ["front_default"]
        .toString();

    return image;
  }

  String getPokemonImagePixel(String jsonResponse) {
    String image = "";

    image = json.decode(jsonResponse)["sprites"]["front_default"].toString();

    return image;
  }

  List<String> getPokemonType(String jsonResponse) {
    List<dynamic> typesResponse = [];
    List<String> typesNames = [];

    typesResponse = json.decode(jsonResponse)["types"];

    for (dynamic response in typesResponse) {
      String typeName = response["type"]["name"];

      typesNames.add(typeName);
    }

    return typesNames;
  }

  List<String> getPokemonImageRoute(List<String> typesNames) {
    List<String> pokemonImagesPaths = [];

    for (String typeName in typesNames) {
      String path = "assets/pokemonTypes/${typeName}.png";

      pokemonImagesPaths.add(path);
    }

    return pokemonImagesPaths;
  }

  int getPokemonBaseStats(String jsonResponse) {
    List<dynamic> stats = [];
    int baseStatsTotalValue = 0;

    stats = json.decode(jsonResponse)["stats"];

    for (dynamic stat in stats) {
      int statValue = stat["base_stat"];
      baseStatsTotalValue = baseStatsTotalValue + statValue;
    }

    return baseStatsTotalValue;
  }
}
