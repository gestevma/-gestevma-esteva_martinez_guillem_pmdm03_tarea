import 'package:pokemons_app/models/models.dart';
import 'package:pokemons_app/providers/providers.dart';
import 'package:http/http.dart' as http;

class PokemonSpeciesProvider extends ChangeNotifier {
  //Guarda el nombre del pokémon i la seva descripció
  Map<int, String> pokemonsDescriptions = {};

  //Constructor, creida a getOnDisplayPokemonSpecies, que guardarà la descripció dels pokemons
  PokemonSpeciesProvider() {
    getOnDisplayPokemonSpecies();
  }

  //Crida a la api de pokemon-species i guarda la descripció dels pokemons al map
  getOnDisplayPokemonSpecies() async {
    List<dynamic> descriptions;

    //Es fa un loop per crida a la api per tots els pokémons de la primera generació
    for (int pokemonNumber = 1; pokemonNumber <= 151; pokemonNumber++) {
      //Guardem la url
      var url =
          Uri.https('pokeapi.co', '/api/v2/pokemon-species/$pokemonNumber');

      //Cridem a l'api
      var result = await http.get(url);

      //Enmagatzenem la descripció
      descriptions = json.decode(result.body)["flavor_text_entries"];

      //Per totes les descripcions obtenim només la que sigui en espanyol
      for (int i = 0; i < descriptions.length; i++) {
        if (descriptions[i]["language"]["name"] == "es") {
          pokemonsDescriptions[pokemonNumber] =
              descriptions[i]["flavor_text"].replaceAll("\n", " ");
          break;
        }
      }
    }

    //Notifiquem a totes les classes que utilitzen el PokemonSpeciesProvider que la informació del map s'ha actualitzat.
    notifyListeners();
  }
}
