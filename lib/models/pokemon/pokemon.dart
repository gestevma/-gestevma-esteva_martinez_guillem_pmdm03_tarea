import 'dart:convert' as convert;

class Pokemon {
  int? entry = 0;
  String name = "";
  String image = "";
  String imagePixel = "";
  List<String> typesNames = [];
  List<String> typesImages = [];
  int baseStats = 0;

  Pokemon(this.entry, this.name, this.image, this.imagePixel, this.typesNames,
      this.typesImages, this.baseStats);

  String getPokemonImage() {
    return this.image;
  }
}
