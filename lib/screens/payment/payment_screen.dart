import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class PaymentScreenArguments {
  final String membershipType;
  final String price;
  final int userId;

  PaymentScreenArguments({
    required this.membershipType,
    required this.price,
    required this.userId,
  });
}

class PaymentScreen extends StatefulWidget {
  static String routeName = "/payment";

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController expiryMonthController = TextEditingController();
  final TextEditingController expiryYearController = TextEditingController();
  final TextEditingController cvvController = TextEditingController();
  final TextEditingController cardHolderNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Stripe.publishableKey = 'pk_test_51PO6ezHwTsOjjUFRDSjNeJHa5wmqQglGILhclU0RWRhliZQGWUoEzWzseiHrFwBit9kTBunMhPqBIxanAxPZLsA400Be6HYaGg';
  }

  @override
  Widget build(BuildContext context) {
    final PaymentScreenArguments args = ModalRoute.of(context)!.settings.arguments as PaymentScreenArguments;

    return Scaffold(
      appBar: AppBar(
        title: Text("Pagar ${args.membershipType}"),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Total a Pagar",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            SizedBox(height: 10),
            Text(
              args.price,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            _buildCardNumberField(),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: _buildExpiryField(
                    controller: expiryMonthController,
                    label: "Mes de Expiración",
                    hintText: "MM",
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: _buildExpiryField(
                    controller: expiryYearController,
                    label: "Año de Expiración",
                    hintText: "AA",
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            _buildTextField(
              controller: cvvController,
              label: "CVV",
              hintText: "XXX",
              icon: Icons.lock,
              keyboardType: TextInputType.number,
              maxLength: 3,
            ),
            SizedBox(height: 20),
            _buildTextField(
              controller: cardHolderNameController,
              label: "Nombre del Titular",
              hintText: "Nombre en la tarjeta",
              icon: Icons.person,
              keyboardType: TextInputType.text,
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                _startPayment(context, args.price, args.userId);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: Text(
                "Pagar",
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCardNumberField() {
    return TextField(
      controller: cardNumberController,
      decoration: InputDecoration(
        labelText: "Número de Tarjeta",
        hintText: "XXXX XXXX XXXX XXXX",
        prefixIcon: Icon(Icons.credit_card),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(16),
        CardNumberInputFormatter(),
      ],
    );
  }

  Widget _buildExpiryField({
    required TextEditingController controller,
    required String label,
    required String hintText,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(2),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hintText,
    required IconData icon,
    required TextInputType keyboardType,
    int? maxLength,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      keyboardType: keyboardType,
      maxLength: maxLength,
    );
  }

  void _startPayment(BuildContext context, String price, int userId) async {
    try {
      // Crear método de pago
      final paymentMethod = await Stripe.instance.createPaymentMethod(PaymentMethodParams.card(
        paymentMethodData: PaymentMethodData(
          billingDetails: BillingDetails(
            name: cardHolderNameController.text,
          ),
        ),
      ));

      // Enviar el payment_method_id al backend
      final response = await http.post(
        Uri.parse('http://192.168.1.106:8001/api/handle-payment'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'amount': (double.parse(price) * 100).toInt(), // Convertir a centavos
          'currency': 'usd',
          'user_id': userId,
          'membresia_id': 2,
          'payment_method_id': paymentMethod.id,
        }),
      );

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);

        // Manejar la acción requerida
        if (result['requires_action']) {
          await Stripe.instance.handleNextAction(result['clientSecret']);
        }

        _showSuccessDialog(context);
      } else {
        _showErrorDialog(context, 'Error en el servidor: ${response.statusCode}');
      }
    } catch (e) {
      _showErrorDialog(context, 'Error: $e');
    }
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Éxito"),
          content: Text("El pago se ha realizado correctamente."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  void _showErrorDialog(BuildContext context, String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Error"),
          content: Text(errorMessage),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }
}

class CardNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final int newTextLength = newValue.text.length;
    int selectionIndex = newValue.selection.end;

    String newText = '';
    for (int i = 0; i < newTextLength; i++) {
      if (i % 4 == 0 && i != 0) {
        newText += ' ';
        selectionIndex++;
      }
      newText += newValue.text[i];
    }

    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}
