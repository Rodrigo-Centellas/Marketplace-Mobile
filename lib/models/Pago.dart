class Pago {
  final int id;
  final String fechaPago;
  final double monto;
  final int userId;
  final String paypalPaymentId;
  final int membresiaId;

  Pago({
    required this.id,
    required this.fechaPago,
    required this.monto,
    required this.userId,
    required this.paypalPaymentId,
    required this.membresiaId,
  });

  factory Pago.fromJson(Map<String, dynamic> json) {
    return Pago(
      id: json['id'],
      fechaPago: json['fecha_pago'],
      monto: json['monto'].toDouble(),
      userId: json['user_id'],
      paypalPaymentId: json['paypal_payment_id'],
      membresiaId: json['membresia_id'],
    );
  }
}