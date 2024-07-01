import 'dart:ffi';

class Membresia {
  final int id;
  final String titulo;
  final String descripcion;
  final String precio;
  final int duracion;
  final int etiqueta;
  final DateTime createdAt;
  final DateTime updatedAt;

  Membresia({
    required this.id,
    required this.titulo,
    required this.descripcion,
    required this.precio,
    required this.duracion,
    required this.etiqueta,
    required this.createdAt,
    required this.updatedAt,
  });

  // Factory constructor to create an instance from JSON
  factory Membresia.fromJson(Map<String, dynamic> json) {
    return Membresia(
      id: json['id'],
      titulo: json['titulo'],
      descripcion: json['descripcion'],
      precio: json['precio'],
      duracion: json['duracion'],
      etiqueta: json['etiqueta'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'titulo': titulo,
      'descripcion': descripcion,
      'precio': precio,
      'duracion': duracion,
      'etiqueta': etiqueta,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
