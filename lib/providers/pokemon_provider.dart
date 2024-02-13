import 'package:pokemons_app/models/models.dart';
import 'package:pokemons_app/providers/providers.dart';
import 'package:http/http.dart' as http;

//Classe que permet carregar la informació dels pokemons
class PokemonProvider extends ChangeNotifier {
  //El Map guarda el nombre del pokemon i la seva informació. Aquest mapa l'usarem per recuperar la informació del pokemon
  Map<int, Pokemon> pokemonsList = {};

  //Contructor, crida a getOnDisplayPokemon, el que guardarà la informació dels pokemons al Map
  PokemonProvider() {
    getOnDisplayPokemon();
  }

  //Crea una llista d'elements entre el 1 i el 151 ordenats com: [1, 151, 2, 150, 3, 149, ...]
  //La utilitzarem per poder carregar els pokemons en l'ordre que ens interesa, ja que els primers que es mostren són els primers i els darrers
  //Així no haurem d'esperar a que carreguin tots els pokemon per poder veure els darrers
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

  //Guarda la informació dels pokemons al map
  getOnDisplayPokemon() async {
    List<int> pokemonsLoadOrder = pokemonLoadOrder();

    for (int pokemonNumber in pokemonsLoadOrder) {
      //Cridem a la api que dona la informació de cada pokemon
      var url = Uri.https('pokeapi.co', '/api/v2/pokemon/$pokemonNumber');

      //Guardem el resultat
      var result = await http.get(url);

      //Buscarem al json del resultat la informació per poder-la guardar a un objecte Pokemon
      String pokemonName = getPokemonName(result.body);
      String pokemonImage = getPokemonImage(result.body);
      String pokemonImagePixel = getPokemonImagePixel(result.body);
      List<String> typesNames = getPokemonType(result.body);
      List<String> typesImages = getPokemonTypeImageRoute(typesNames);
      int baseStats = getPokemonBaseStats(result.body);

      //Guardem un objecte pokemon amb la informació obtinguda
      Pokemon pokemon = Pokemon(
        pokemonNumber,
        pokemonName,
        pokemonImage,
        pokemonImagePixel,
        typesNames,
        typesImages,
        baseStats,
      );

      //Actualitzem el map
      pokemonsList[pokemonNumber] = pokemon;

      //Notifiquem a totes les classes que utilitzen el PokemonProvider que la informació del map s'ha actualitzat.
      notifyListeners();
    }
  }

  //Retorna el nom del pokemon, s'obté del json retornat per l'api
  String getPokemonName(String jsonResponse) {
    String name = "";

    name = json.decode(jsonResponse)["forms"][0]["name"].toString();

    return name;
  }

  //Retorna la imatge del pokémon, s'obté del json retornat per l'api
  String getPokemonImage(String jsonResponse) {
    String image = "";

    image = json
        .decode(jsonResponse)["sprites"]["other"]["official-artwork"]
            ["front_default"]
        .toString();

    return image;
  }

  //Retorna la imatge en pixel del pokémon, s'obté del json retornat per l'api
  String getPokemonImagePixel(String jsonResponse) {
    String image = "";

    image = json.decode(jsonResponse)["sprites"]["front_default"].toString();

    return image;
  }

  //Retorna els tipus del pokémon, s'obté del json retornat per l'api
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

  //Retorna la ruta de la imatge que indica el tipus del pokémon
  List<String> getPokemonTypeImageRoute(List<String> typesNames) {
    List<String> pokemonImagesPaths = [];

    for (String typeName in typesNames) {
      String path = "assets/pokemonTypes/${typeName}.png";

      pokemonImagesPaths.add(path);
    }

    return pokemonImagesPaths;
  }

  //Obté les estadístiques de totes les habilitats del pokémon, obtingut a partir del json retornat de l'apip
  //Retorna la suma de totes les estadístiques base
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
