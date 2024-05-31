import 'package:flutter/material.dart';
import 'package:shop_app/models/anuncio.dart';

class AnuncioProduct {
  final int id;
  final String titulo, descripcion;
  final List<String> imagenes;
  final List<Color> colores;
  final double rating;
  final double precio;
  final bool isFavourite, isPopular;

  AnuncioProduct({
    required this.id,
    required this.imagenes,
    required this.colores,
    this.rating = 0.0,
    this.isFavourite = false,
    this.isPopular = false,
    required this.titulo,
    required this.precio,
    required this.descripcion,
  });

  factory AnuncioProduct.fromAnuncio(Anuncio anuncio) {
    return AnuncioProduct(
      id: anuncio.id,
      titulo: anuncio.titulo,
      descripcion: anuncio.descripcion,
      precio: anuncio.precio,
      rating: 4.0, // Puedes asignar una calificación predeterminada o calcularla de alguna manera
      imagenes: [anuncio.imagen.fullImageUrl],
      colores: const [
        Color(0xFFF6625E),
        Color(0xFF836DB8),
        Color(0xFFDECB9C),
        Colors.white,
      ],
      isFavourite: false, // Puedes asignar un valor predeterminado o calcularlo de alguna manera
      isPopular: false, // Puedes asignar un valor predeterminado o calcularlo de alguna manera
    );
  }
}