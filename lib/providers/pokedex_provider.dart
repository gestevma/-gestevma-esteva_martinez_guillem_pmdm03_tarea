import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pokemons_app/models/models.dart';
import 'package:pokemons_app/models/pokedex/pokedex_response.dart';
import 'package:pokemons_app/models/pokedex/pokemon_entry.dart';

class PokedexProvider extends ChangeNotifier {
  late List<PokemonEntry> onDisplayPokedexEntries = [];

  PokedexProvider() {
    print("Pokedex provider inicialitzat");
    this.getOnDisplayPokedex();
  }

  getOnDisplayPokedex() async {
    // This example uses the Google Books API to search for books about http.
    // https://developers.google.com/books/docs/overview

    var url = Uri.https('pokeapi.co', '/api/v2/pokedex/2');

    final result = await http.get(url);
    final pokedexresponse = Pokedexresponse.fromRawJson(result.body);
    onDisplayPokedexEntries = pokedexresponse.pokemonEntries;

    notifyListeners();
  }
}
