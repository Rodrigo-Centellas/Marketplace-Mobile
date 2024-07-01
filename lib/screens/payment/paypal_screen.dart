import 'package:flutter/material.dart';
import 'package:flutter_paypal_checkout/flutter_paypal_checkout.dart';
import 'package:shop_app/screens/home/home_screen.dart'; // Asegúrate de importar tu HomeScreen
import 'package:shop_app/Api/pago_service.dart';
import '../../models/Pago.dart';
import 'package:shop_app/Api/token_storage_service.dart';

class CheckoutPage extends StatefulWidget {
  static const String routeName = "/checkout";

  const CheckoutPage({Key? key}) : super(key: key);

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final String membershipType = args['membershipType'];
    final double price = args['price'];
    final String description = args['description'];

    return Scaffold(
      appBar: AppBar(
        title: const Text("PayPal Checkout", style: TextStyle(fontSize: 20)),
      ),
      body: Center(
        child: TextButton(
          onPressed: () async {
            final result = await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) => PaypalCheckout(
                  sandboxMode: true,
                  clientId:
                      "AYlfrmtSY-oXDDPr9jL2A0_NSE-DtDLA2oVIZhd-4NiDwIT14PVO-UNZ4PAtzKVHiE2FWmac9tha1-4O",
                  secretKey:
                      "EPqnGtI7fr_FLtcG7AozI5pIHIujXxDEGZn-jyhTe6o0vIzgvfiquwjimK2yoASpHT_dRAZGAjlrOuN5",
                  returnURL: "success.snippetcoder.com",
                  cancelURL: "cancel.snippetcoder.com",
                  transactions: [
                    {
                      "amount": {
                        "total": price.toStringAsFixed(2),
                        "currency": "USD",
                        "details": {
                          "subtotal": price.toStringAsFixed(2),
                          "shipping": '0',
                          "shipping_discount": 0
                        }
                      },
                      "description": description,
                      "item_list": {
                        "items": [
                          {
                            "name": membershipType,
                            "quantity": 1,
                            "price": price.toStringAsFixed(2),
                            "currency": "USD"
                          }
                        ],
                      }
                    }
                  ],
                  note:
                      "Contacta con nosotros para cualquier pregunta sobre tu membresía.",
                  onSuccess: (Map params) async {
                    print("onSuccess: $params");

                    try {
                      
                      String paypalPaymentId = params['data']['id'];
                      
                      int? membresiaId = args['membresiaId'] as int?;
                                          print('Datos antes de registrar el pago:');
                      print('Monto: $price');
                      print('PayPal Payment ID: $paypalPaymentId');
                      print('Membresía ID: $membresiaId');
                      if (membresiaId == null) {
                        throw Exception('El ID de la membresía es nulo');
                      }
  

                      // Registrar el pago en el backend
                      Pago pagoRegistrado = await PagoService().registrarPago(
                        monto: price,
                        paypalPaymentId: paypalPaymentId,
                        membresiaId: args[
                            'membresiaId'], // Asegúrate de pasar este dato desde la pantalla anterior
                      );

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text(
                                '¡Pago exitoso y registrado! Gracias por tu compra.')),
                      );

                      // Esperar un poco para que el usuario vea el mensaje
                      await Future.delayed(Duration(seconds: 2));

                      // Redirigir a HomePage
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        HomeScreen.routeName,
                        (Route<dynamic> route) => false,
                      );
                    } catch (e) {
 

                        ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(
    backgroundColor: Colors.lightBlue, // Color de fondo estilo PayPal
    content: Row(
      children: [
        Icon(Icons.check_circle, color: Colors.white), // Icono de check
        SizedBox(width: 10),
        Expanded(
          child: Text(
            '¡Pago exitoso y registrado! Gracias por tu compra.',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    ),
  ),
);
                    }
                  },
                  onError: (error) {
                    print("onError: $error");
                    Navigator.pop(context);
                  },
                  onCancel: () {
                    print('cancelled:');
                    Navigator.pop(context);
                  },
                ),
              ),
            );

            // Manejar el resultado si es necesario
            if (result != null) {
              print("Resultado del checkout: $result");
            }
          },
          style: TextButton.styleFrom(
            backgroundColor: Colors.teal,
            foregroundColor: Colors.white,
            shape: const BeveledRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(1)),
            ),
          ),
          child: Text('Pagar $membershipType'),
        ),
      ),
    );
  }
}
