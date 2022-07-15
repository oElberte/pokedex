import 'package:flutter/material.dart';

class Pokemon {
  String? name;
  String? id;
  String? imageurl;
  String? description;
  String? category;
  List<String>? type;

  Pokemon({
    this.name,
    this.id,
    this.imageurl,
    this.description,
    this.category,
    this.type,
  });

  Pokemon.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    imageurl = json['imageurl'];
    description = json['xdescription'];
    category = json['category'];
    type = json['typeofpokemon'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['id'] = id;
    data['imageurl'] = imageurl;
    data['xdescription'] = description;
    data['category'] = category;
    data['typeofpokemon'] = type;
    return data;
  }

  static Color? color({required String type}) {
    switch (type) {
      case 'Normal':
        return Colors.brown[400];
      case 'Fire':
        return Colors.red;
      case 'Water':
        return Colors.blue;
      case 'Grass':
        return Colors.green;
      case 'Electric':
        return Colors.amber;
      case 'Ice':
        return Colors.cyanAccent[400];
      case 'Fighting':
        return Colors.orange;
      case 'Poison':
        return Colors.purpleAccent[100];
      case 'Ground':
        return Colors.orange[300];
      case 'Flying':
        return Colors.indigo[200];
      case 'Psychic':
        return Colors.pink;
      case 'Bug':
        return Colors.lightGreen[500];
      case 'Rock':
        return Colors.grey;
      case 'Ghost':
        return Colors.indigo[400];
      case 'Dark':
        return Colors.brown;
      case 'Dragon':
        return Colors.indigo[800];
      case 'Steel':
        return Colors.blueGrey;
      case 'Fairy':
        return Colors.pinkAccent[100];
      default:
        return Colors.grey;
    }
  }
}
