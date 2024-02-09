import 'package:flutter/material.dart';
import 'package:pokemons_app/providers/pokemon_provider.dart';
import 'package:pokemons_app/screens/screens.dart';
import 'package:pokemons_app/providers/pokedex_provider.dart';
import 'package:pokemons_app/providers/descriptions_provider.dart';

import 'package:provider/provider.dart';

void main() => runApp(AppState());

class AppState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => PokedexProvider(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => PokemonProvider(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => DesciptionsProvider(),
          lazy: false,
        ),
      ],
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final pokedexProvider = Provider.of<PokedexProvider>(context);
    final pokemonProvider = Provider.of<PokemonProvider>(context);
    final descriptionProvider = Provider.of<DesciptionsProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pokémon',
      initialRoute: 'home',
      routes: {
        'home': (BuildContext context) => HomeScreen(
              pokemonEntries: pokedexProvider.onDisplayPokedexEntries,
              pokemonsList: pokemonProvider.pokemonsList,
            ),
        'details': (BuildContext context) => DetailsScreen(
              pokemonEntries: pokedexProvider.onDisplayPokedexEntries,
              pokemonsList: pokemonProvider.pokemonsList,
              descriptionsMap: descriptionProvider.pokemonsDescriptions,
            ),
      },
      theme: ThemeData.light()
          .copyWith(appBarTheme: const AppBarTheme(color: Colors.indigo)),
    );
  }
}
