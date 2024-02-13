import 'package:pokemons_app/screens/screens.dart';
import 'package:pokemons_app/providers/providers.dart';

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
          create: (_) => PokemonSpeciesProvider(),
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
    final pokemonSpeciesProvider = Provider.of<PokemonSpeciesProvider>(context);

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
            descriptionsMap: pokemonSpeciesProvider.pokemonsDescriptions),
      },
      theme: ThemeData.light()
          .copyWith(appBarTheme: const AppBarTheme(color: Colors.indigo)),
    );
  }
}
