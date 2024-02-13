import 'package:pokemons_app/models/models.dart';

//Classe que permet guardar la ingormació d'un pokemon
class Pokemon {
  int entry = 0;
  String name = "";
  String image = "";
  String imagePixel = "";
  List<String> typesNames = [];
  List<String> typesImages = [];
  int baseStats = 0;

  Pokemon(this.entry, this.name, this.image, this.imagePixel, this.typesNames,
      this.typesImages, this.baseStats);
}
