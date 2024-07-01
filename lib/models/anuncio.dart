import 'package:shop_app/Api/AnuncioApi.dart';
import '../const/API_URL.dart';

class Anuncio {
  final int id;
  final String titulo;
  final String descripcion;
  final double precio;
  final String fechaPublicacion;
  final String fechaExpiracion;
  final int visitas;
  final int categoriaId;
  final int condicionId;
  final int monedaId;
  final int userId;
  final int disponible;
  final int habilitado;
  final String createdAt;
  final String updatedAt;
  final Categoria categoria;
  final Condicion condicion;
  final Moneda moneda;
  final Usuario usuario;
  final Imagen imagen;
  final List<dynamic> etiquetas;

  Anuncio({
    required this.id,
    required this.titulo,
    required this.descripcion,
    required this.precio,
    required this.fechaPublicacion,
    required this.fechaExpiracion,
    required this.visitas,
    required this.categoriaId,
    required this.condicionId,
    required this.monedaId,
    required this.userId,
    required this.disponible,
    required this.habilitado,
    required this.createdAt,
    required this.updatedAt,
    required this.categoria,
    required this.condicion,
    required this.moneda,
    required this.usuario,
    required this.imagen,
    required this.etiquetas,
  });

  factory Anuncio.fromJson(Map<String, dynamic> json) {
    return Anuncio(
      id: json['id'],
      titulo: json['titulo'],
      descripcion: json['descripcion'],
      precio: json['precio'].toDouble(),
      fechaPublicacion: json['fecha_publicacion'],
      fechaExpiracion: json['fecha_expiracion'],
      visitas: json['visitas'],
      categoriaId: json['categoria_id'],
      condicionId: json['condicion_id'],
      monedaId: json['moneda_id'],
      userId: json['user_id'],
      disponible: json['disponible'],
      habilitado: json['habilitado'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      categoria: Categoria.fromJson(json['categoria']),
      condicion: Condicion.fromJson(json['condicion']),
      moneda: Moneda.fromJson(json['moneda']),
      usuario: Usuario.fromJson(json['usuario']),
      imagen: Imagen.fromJson(json['imagen']),
      etiquetas: json['etiquetas'] ?? [],
    );
  }
}

class Categoria {
  final int id;
  final String nombre;
  final String? url;
  final String? descripcion;
  final int? padreId;
  final String createdAt;
  final String updatedAt;

  Categoria({
    required this.id,
    required this.nombre,
    this.url,
    this.descripcion,
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
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}

class Condicion {
  final int id;
  final String nombre;
  final String createdAt;
  final String updatedAt;

  Condicion({
    required this.id,
    required this.nombre,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Condicion.fromJson(Map<String, dynamic> json) {
    return Condicion(
      id: json['id'],
      nombre: json['nombre'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}

class Moneda {
  final int id;
  final String nombre;
  final String createdAt;
  final String updatedAt;

  Moneda({
    required this.id,
    required this.nombre,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Moneda.fromJson(Map<String, dynamic> json) {
    return Moneda(
      id: json['id'],
      nombre: json['nombre'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}

class Usuario {
  final int id;
  final String name;
  final String email;
  final String? emailVerifiedAt;
  final String? profilePhotoPath;
  final String createdAt;
  final String updatedAt;

  Usuario({
    required this.id,
    required this.name,
    required this.email,
    this.emailVerifiedAt,
    this.profilePhotoPath,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      emailVerifiedAt: json['email_verified_at'],
      profilePhotoPath: json['profile_photo_path'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
class Imagen {
  final String createdAt;
  final String updatedAt;
  final String url;
  final int imageableId;
  final String imageableType;

  Imagen({
    required this.createdAt,
    required this.updatedAt,
    required this.url,
    required this.imageableId,
    required this.imageableType,
  });

  factory Imagen.fromJson(Map<String, dynamic> json) {
    return Imagen(
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      url: json['url'],
      imageableId: json['imageable_id'],
      imageableType: json['imageable_type'],
    );
  }

  // String get fullImageUrl {
  //   // Reemplaza esta URL base con la URL base de tu servidor
  //   const baseUrl = '${API_URL.apiUrl}';
  //   return '$baseUrl/storage/images/anuncios/${url.split('/').last}';
  // }

    String get fullImageUrl {
    // const baseUrl = 'http://192.168.1.106:8001/api/imagenes';
    // return '$baseUrl/${url.split('/').last}';
     const baseUrl = '${API_URL.apiUrl}/api/imagenes';
    return '$baseUrl/${url.split('/').last}';
  }
}