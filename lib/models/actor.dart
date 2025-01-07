import 'dart:convert';

class Actor {
  // Atributos principales de un actor.
  int id;
  String name;
  String biography;
  String birthday;
  String placeOfBirth;
  double popularity;
  String profilePath;

  // Constructor de la clase Actor.
  Actor({
    required this.id,
    required this.name,
    required this.biography,
    required this.birthday,
    required this.placeOfBirth,
    required this.popularity,
    required this.profilePath,
  });
  // Crea una instancia de Actor a partir de un mapa (respuesta de la API).
  factory Actor.fromMap(Map<String, dynamic> map) {
    return Actor (
      id: map['id'],
      name: map['name'],
      biography: map['biography'] ?? '',
      birthday: map['birthday'] ?? '',
      placeOfBirth: map['place_of_birth'] ?? '',
      popularity: map['popularity'].toDouble() ?? 0.0,
      profilePath: map['profile_path'] ?? '',
    );
  }
  // Crea una instancia de Actor desde un JSON decodificado.
  factory Actor.fromJson(String source) => Actor.fromMap(json.decode(source));
}