import 'package:pokemons_app/models/models.dart';
import 'package:pokemons_app/providers/providers.dart';
import 'package:http/http.dart' as http;

//Classe que guarda la informació de tots els pokemons de la primera generacio
class PokedexProvider extends ChangeNotifier {
  late List<PokemonEntry> onDisplayPokedexEntries = [];

  //Constructor, crida al getOnDisplayPokemon, que guarda a la llista onDisplayPokemon tots els registres tornats per l'API
  PokedexProvider() {
    getOnDisplayPokedex();
  }

  //Fa una cridada a l'API pokedex i guarda les entrades amb els nombres dels pokemons de la primera generació
  getOnDisplayPokedex() async {
    //creació de la url
    var url = Uri.https('pokeapi.co', '/api/v2/pokedex/2');

    //Es crida a la API i es guarda la resposta en format json
    final result = await http.get(url);
    final pokedexresponse = Pokedexresponse.fromRawJson(result.body);

    //Es guarda la informació de la resposta a la llista onDisplayPokedexEntries
    onDisplayPokedexEntries = pokedexresponse.pokemonEntries;

    //Es notifica a totes les classes que utilitcen el PokedexProvider per a que carreguin la nova informació
    notifyListeners();
  }
}
