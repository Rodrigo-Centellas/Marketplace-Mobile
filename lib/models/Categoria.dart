class Categoria {
  final int id;
  final String nombre;
  final String url;
  final String descripcion;
  final int? padreId;
  final DateTime createdAt;
  final DateTime updatedAt;

  Categoria({
    required this.id,
    required this.nombre,
    required this.url,
    required this.descripcion,
    this.padreId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Categoria.fromJson(Map<String, dynamic> json) {
    return Categoria(
      id: json['id'],
      nombre: json['nombre'],
      url: json['url'],
      descripcion: json['descripcion'],
      padreId: json['padre_id'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}
