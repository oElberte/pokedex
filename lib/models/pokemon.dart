class Pokemon {
  String? name;
  String? id;
  String? imageurl;
  String? xdescription;
  String? category;
  List<String>? typeofpokemon;

  Pokemon({
    this.name,
    this.id,
    this.imageurl,
    this.xdescription,
    this.category,
    this.typeofpokemon,
  });

  Pokemon.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    imageurl = json['imageurl'];
    xdescription = json['xdescription'];
    category = json['category'];
    typeofpokemon = json['typeofpokemon'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['id'] = id;
    data['imageurl'] = imageurl;
    data['xdescription'] = xdescription;
    data['category'] = category;
    data['typeofpokemon'] = typeofpokemon;
    return data;
  }
}
