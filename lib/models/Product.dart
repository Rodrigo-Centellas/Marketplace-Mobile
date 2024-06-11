import 'package:flutter/material.dart';
import 'package:shop_app/models/AnuncioProduct.dart';
import 'package:shop_app/models/anuncio.dart';

class Product {
  final int id;
  final String title, description;
  final List<String> images;
  final List<Color> colors;
  final double rating, price;
  final bool isFavourite, isPopular;
  final int sellerId;

  Product({
    required this.id,
    required this.images,
    required this.colors,
    this.rating = 0.0,
    this.isFavourite = false,
    this.isPopular = false,
    required this.title,
    required this.price,
    required this.description,
    required this.sellerId,
  });
}

// Actualizar getProductsFromAnuncios para propagar sellerId

List<Product> getProductsFromAnuncios(List<Anuncio> anuncios) {
  return anuncios.map((anuncio) {
    final anuncioProduct = AnuncioProduct.fromAnuncio(anuncio);
    return Product(
      id: anuncioProduct.id,
      images: anuncioProduct.imagenes,
      colors: anuncioProduct.colores,
      title: anuncioProduct.titulo,
      price: anuncioProduct.precio,
      description: anuncioProduct.descripcion,
      rating: anuncioProduct.rating,
      isFavourite: anuncioProduct.isFavourite,
      isPopular: anuncioProduct.isPopular,
      sellerId: anuncioProduct.sellerId,
    );
  }).toList();
}

List<Product> demoProducts = [
  Product(
    id: 1,
    images: [
      "assets/images/ps4_console_white_1.png",
      "assets/images/ps4_console_white_2.png",
      "assets/images/ps4_console_white_3.png",
      "assets/images/ps4_console_white_4.png",
    ],
    colors: [
      const Color(0xFFF6625E),
      const Color(0xFF836DB8),
      const Color(0xFFDECB9C),
      Colors.white,
    ],
    title: "Wireless Controller for PS4™",
    price: 64.99,
    description: 'hola',
    rating: 4.8,
    isFavourite: true,
    isPopular: true,
    sellerId: 1
  ),
];