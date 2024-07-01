import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shop_app/models/Pago.dart';
import 'package:shop_app/Api/token_storage_service.dart';
import '../const/API_URL.dart';

class PagoService {
  final String apiUrl = '${API_URL.apiUrl}/api/auth/pagos';

  Future<Pago> registrarPago({
    required double monto,
    required String paypalPaymentId,
    required int? membresiaId,  // Cambiado a int? para permitir nulos
  }) async {
    final authToken = await TokenStorageService.getToken();
    final userId = await TokenStorageService.getUserId();

    if (userId == null) {
      throw Exception('No se pudo obtener el ID del usuario');
    }

    if (membresiaId == null) {
      throw Exception('El ID de la membresía es nulo');
    }

    final body = {
      'user_id': userId,
      'monto': monto,
      'paypal_payment_id': paypalPaymentId,
      'membresia_id': membresiaId,
    };

    print('Enviando datos al backend: $body');

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Authorization': 'Bearer $authToken',
        'Content-Type': 'application/json',
      },
      body: json.encode(body),
    );

    print('Respuesta del backend: ${response.body}');

    if (response.statusCode == 201) {
      return Pago.fromJson(json.decode(response.body)['pago']);
    } else {
      throw Exception('Error al registrar el pago: ${response.body}');
    }
  }
}