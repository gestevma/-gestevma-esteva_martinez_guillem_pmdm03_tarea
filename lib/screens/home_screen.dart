import 'package:flutter/material.dart';
import 'package:pokemons_app/models/models.dart';
import 'package:pokemons_app/providers/pokedex_provider.dart';
import 'package:pokemons_app/providers/pokemon_provider.dart';
import 'package:pokemons_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  final List<PokemonEntry> pokemonEntries;
  final Map<int, Pokemon> pokemonsList;

  const HomeScreen(
      {Key? key, required this.pokemonEntries, required this.pokemonsList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokémons Kanto'),
        elevation: 0,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search_outlined))
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              // Targetes principals
              CardSwiper(
                pokemonEntries: pokemonEntries,
                pokemonsList: pokemonsList,
              ),

              // Slider de pel·licules
              PokemonSlider(
                pokemonEntries: pokemonEntries,
                pokemonsList: pokemonsList,
              ),
              // Poodeu fer la prova d'afegir-ne uns quants, veureu com cada llista és independent
              // MovieSlider(),
              // MovieSlider(),
            ],
          ),
        ),
      ),
    );
  }
}
