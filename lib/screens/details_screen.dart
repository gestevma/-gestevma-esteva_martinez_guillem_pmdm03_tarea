import 'package:flutter/material.dart';
import 'package:pokemons_app/models/models.dart';
import 'package:pokemons_app/providers/providers.dart';

class DetailsScreen extends StatelessWidget {
  final List<PokemonEntry> pokemonEntries;
  final Map<int, Pokemon> pokemonsList;
  final Map<int, String> descriptionsMap;

  const DetailsScreen(
      {Key? key,
      required this.pokemonEntries,
      required this.pokemonsList,
      required this.descriptionsMap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: Canviar després per una instància de Peli
    final int pokemonEntryNumber = ModalRoute.of(context) != null
        ? int.parse(ModalRoute.of(context)!.settings.arguments.toString())
        : 0;
    final pokemon = pokemonsList[pokemonEntryNumber];
    final description = descriptionsMap[pokemonEntryNumber];

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _CustomAppBar(pokemon: pokemon),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                _PosterAndTitile(
                  pokemonEntries: pokemonEntries,
                  pokemon: pokemon,
                ),
                _Overview(
                    pokemonEntries: pokemonEntries,
                    pokemon: pokemon,
                    description: description),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CustomAppBar extends StatelessWidget {
  final Pokemon? pokemon;

  const _CustomAppBar({Key? key, required this.pokemon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Exactament igual que la AppBaer però amb bon comportament davant scroll

    String pokemonName = pokemon != null ? pokemon!.name : "";

    String pokemonImage = pokemon != null
        ? pokemon!.image
        : "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/1.png";

    return SliverAppBar(
      backgroundColor: Colors.blueGrey[400],
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: EdgeInsets.all(0),
        title: Container(
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          color: Colors.black12,
          padding: const EdgeInsets.only(bottom: 10),
          child: Text(
            pokemonName,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        background: FadeInImage(
          placeholder: AssetImage('assets/loading.gif'),
          image: NetworkImage(pokemonImage),
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

class _PosterAndTitile extends StatelessWidget {
  final List<PokemonEntry> pokemonEntries;
  final Pokemon? pokemon;

  const _PosterAndTitile(
      {Key? key, required this.pokemonEntries, required this.pokemon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    String pokemonName = pokemon != null ? pokemon!.name : "";

    String pokemonImagePixel =
        pokemon != null ? pokemon!.imagePixel : "no-available-image";

    List<String> pokemonTypesImages =
        pokemon != null ? pokemon!.typesImages : [];

    int pokemonStatsValue = pokemon != null ? pokemon!.baseStats : 0;

    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              placeholder: AssetImage('assets/loading.gif'),
              image: NetworkImage(pokemonImagePixel),
              height: 150,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Column(
            children: [
              Text(
                pokemonName,
                style: textTheme.headline5,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              Column(children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(
                      18), // Asegúrate de que el borde del contenedor sea menor que el borde de la imagen
                  child: Image.asset(pokemonTypesImages[0]),
                ),
                Container(width: 10, height: 5),
                pokemonTypesImages.length > 1
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(
                            18), // Asegúrate de que el borde del contenedor sea menor que el borde de la imagen
                        child: Image.asset(pokemonTypesImages[1]),
                      )
                    : Text(""),
              ]),
              Container(width: 10, height: 15),
              Row(
                children: [
                  pokemonStatsValue < 400
                      ? Icon(Icons.star, size: 15, color: Colors.brown[400])
                      : pokemonStatsValue > 550
                          ? Icon(Icons.star,
                              size: 15, color: Colors.yellow[400])
                          : Icon(Icons.star, size: 15, color: Colors.grey[300]),
                  const SizedBox(width: 5),
                  Text('Stats base: ${pokemonStatsValue}',
                      style: TextStyle(fontSize: 15)),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}

class _Overview extends StatelessWidget {
  final List<PokemonEntry> pokemonEntries;
  final Pokemon? pokemon;
  final String? description;

  const _Overview(
      {Key? key,
      required this.pokemonEntries,
      required this.pokemon,
      required this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pokemonDescription =
        description != null ? description : "Cargando descripción...";
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Text(
        pokemonDescription!,
        textAlign: TextAlign.justify,
        style: Theme.of(context).textTheme.subtitle1,
      ),
    );
  }
}
