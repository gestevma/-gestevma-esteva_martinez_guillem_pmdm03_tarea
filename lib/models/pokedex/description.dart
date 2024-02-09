import 'package:pokemons_app/models/models.dart';

class Description {
  String description;
  Region language;

  Description({
    required this.description,
    required this.language,
  });

  factory Description.fromRawJson(String str) =>
      Description.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Description.fromJson(Map<String, dynamic> json) => Description(
        description: json["description"],
        language: Region.fromJson(json["language"]),
      );

  Map<String, dynamic> toJson() => {
        "description": description,
        "language": language.toJson(),
      };
}
