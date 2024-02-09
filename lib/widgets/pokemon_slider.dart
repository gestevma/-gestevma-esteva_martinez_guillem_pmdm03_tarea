import 'package:flutter/material.dart';
import 'dart:math';
import 'package:pokemons_app/models/models.dart';
import 'package:pokemons_app/providers/pokemon_provider.dart';

final List<int> pokemonsRandomList = getRandomPokemon();

List<int> getRandomPokemon() {
  List<int> pkmList = [];
  Random random = Random();
  int pokemonNumber;

  while (pkmList.length < 20) {
    pokemonNumber = random.nextInt(151) + 1;

    if (!pkmList.contains(pokemonNumber)) {
      pkmList.add(pokemonNumber);
    }
  }
  return pkmList;
}

class PokemonSlider extends StatelessWidget {
  final List<PokemonEntry> pokemonEntries;
  final Map<int, Pokemon> pokemonsList;

  const PokemonSlider(
      {Key? key, required this.pokemonEntries, required this.pokemonsList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 260,
      // color: Colors.red,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text('Pokémons del moment',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ),
          SizedBox(
            height: 5,
          ),
          Expanded(
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 20,
                itemBuilder: (_, int index) => _PokemonSprite(
                    index: index,
                    pokemonEntries: pokemonEntries,
                    pokemonsList: pokemonsList)),
          )
        ],
      ),
    );
  }
}

class _PokemonSprite extends StatelessWidget {
  final List<PokemonEntry> pokemonEntries;
  final Map<int, Pokemon> pokemonsList;
  final int index;

  const _PokemonSprite(
      {Key? key,
      required this.index,
      required this.pokemonEntries,
      required this.pokemonsList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final showPokemonNumber = pokemonsRandomList[index];
    final pokemonImage = pokemonsList[showPokemonNumber] != null
        ? pokemonsList[showPokemonNumber]!.image
        : "https://usagif.com/wp-content/uploads/loading-11.gif";

    String pokemonName = pokemonsList[showPokemonNumber] != null
        ? pokemonsList[showPokemonNumber]!.name
        : "";

    return Container(
      width: 130,
      height: 190,
      // color: Colors.green,
      margin: const EdgeInsets.symmetric(horizontal: 10),

      child: Column(
        children: [
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, 'details',
                arguments: showPokemonNumber),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.black, // Color del borde
                  width: 2.0, // Ancho del borde
                ),
                color: Colors.grey[350],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FadeInImage(
                  placeholder: AssetImage('assets/no-image.jpg'),
                  image: NetworkImage(pokemonImage),
                  width: 230,
                  height: 190,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            pokemonName,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
