import 'package:pokemons_app/models/models.dart';

class PokemonEntry {
  int entryNumber;
  Region pokemonSpecies;

  PokemonEntry({
    required this.entryNumber,
    required this.pokemonSpecies,
  });

  factory PokemonEntry.fromRawJson(String str) =>
      PokemonEntry.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PokemonEntry.fromJson(Map<String, dynamic> json) => PokemonEntry(
        entryNumber: json["entry_number"],
        pokemonSpecies: Region.fromJson(json["pokemon_species"]),
      );

  Map<String, dynamic> toJson() => {
        "entry_number": entryNumber,
        "pokemon_species": pokemonSpecies.toJson(),
      };
}
