class Planet {
  final String name;
  final String description;
  final String distanceFromSun;


  Planet({
    required this.name,
    required this.description,
    required this.distanceFromSun,
  });

  factory Planet.fromJson(Map<String, dynamic> json) {
    return Planet(
      name: json['name'],
      description: json['description'],
      distanceFromSun: json['distanceFromSun'],
    );
  }
}
