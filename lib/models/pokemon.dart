class Pokemon {
  final String name;
  final String url;
  final String descripcion;
  final String imagen;

  Pokemon({
    required this.name,
    required this.url,
    required this.descripcion,
    required this.imagen,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      name: json['name'] ?? '',
      url: json['url'] ?? '',
      descripcion: json['descripcion'] ?? '',
      imagen: json['imagen'] ?? '',
    );
  }
}
