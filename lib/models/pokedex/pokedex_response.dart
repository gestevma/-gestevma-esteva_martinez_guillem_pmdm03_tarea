import 'package:pokemons_app/models/models.dart';

class Pokedexresponse {
  List<Description> descriptions;
  int id;
  bool isMainSeries;
  String name;
  List<Name> names;
  List<PokemonEntry> pokemonEntries;
  Region region;
  List<Region> versionGroups;

  Pokedexresponse({
    required this.descriptions,
    required this.id,
    required this.isMainSeries,
    required this.name,
    required this.names,
    required this.pokemonEntries,
    required this.region,
    required this.versionGroups,
  });

  factory Pokedexresponse.fromRawJson(String str) =>
      Pokedexresponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Pokedexresponse.fromJson(Map<String, dynamic> json) =>
      Pokedexresponse(
        descriptions: List<Description>.from(
            json["descriptions"].map((x) => Description.fromJson(x))),
        id: json["id"],
        isMainSeries: json["is_main_series"],
        name: json["name"],
        names: List<Name>.from(json["names"].map((x) => Name.fromJson(x))),
        pokemonEntries: List<PokemonEntry>.from(
            json["pokemon_entries"].map((x) => PokemonEntry.fromJson(x))),
        region: Region.fromJson(json["region"]),
        versionGroups: List<Region>.from(
            json["version_groups"].map((x) => Region.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "descriptions": List<dynamic>.from(descriptions.map((x) => x.toJson())),
        "id": id,
        "is_main_series": isMainSeries,
        "name": name,
        "names": List<dynamic>.from(names.map((x) => x.toJson())),
        "pokemon_entries":
            List<dynamic>.from(pokemonEntries.map((x) => x.toJson())),
        "region": region.toJson(),
        "version_groups":
            List<dynamic>.from(versionGroups.map((x) => x.toJson())),
      };
}
