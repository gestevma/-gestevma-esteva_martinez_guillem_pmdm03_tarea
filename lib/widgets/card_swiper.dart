import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:pokemons_app/models/models.dart';
import 'package:pokemons_app/providers/pokemon_provider.dart';
import 'package:provider/provider.dart';

class CardSwiper extends StatelessWidget {
  final List<PokemonEntry> pokemonEntries;
  final Map<int, Pokemon> pokemonsList;

  const CardSwiper(
      {Key? key, required this.pokemonEntries, required this.pokemonsList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
        width: double.infinity,
        // Aquest multiplicador estableix el tant per cent de pantalla ocupada 50%
        height: size.height * 0.5,
        // color: Colors.red,
        child: Swiper(
          itemCount: pokemonEntries.length,
          layout: SwiperLayout.STACK,
          itemWidth: size.width * 0.6,
          itemHeight: size.height * 0.4,
          itemBuilder: (BuildContext context, int index) {
            final pokemon = pokemonEntries[index];

            String pokemonImage = pokemonsList[pokemon.entryNumber] != null
                ? pokemonsList[pokemon.entryNumber]!.image
                : "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/1.png";

            return GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, 'details',
                    arguments: pokemon.entryNumber);
              },
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
                  borderRadius: BorderRadius.circular(
                      18), // Asegúrate de que el borde del contenedor sea menor que el borde de la imagen
                  child: FadeInImage(
                    placeholder: AssetImage('assets/no-image.jpg'),
                    image: NetworkImage(pokemonImage),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            );
          },
        ));
  }
}
