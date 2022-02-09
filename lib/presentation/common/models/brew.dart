class Brew {
  final String name;
  final String sugars;
  final int strength;

  Brew({
    required this.name,
    required this.strength,
    required this.sugars,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'sugars': sugars,
        'strength': strength,
      };

  static Brew fromJson(Map<String, dynamic> json) => Brew(
        name: json['name'],
        strength: json['strength'],
        sugars: json['sugars'],
      );
}
