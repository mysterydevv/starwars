class Stuff {
  late String? id;
  late String name;
  late String activity;
  late String image;
  late String? biography;

  Stuff(this.id, this.name, this.activity, this.image, this.biography);

  

  static Stuff fromJson(Map<String, dynamic> json) {
    return Stuff(
      json['id'],
      json['name'],
      json['activity'],
      json['image'],
      json['biography']
    );
  }

  Object? toJson() {
    return {
      'id': id,
      'name': name,
      'activity': activity,
      'image': image,
      'biography': biography
    };
  }
}
