import 'package:flutter/material.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/screens/payment/paypal_screen.dart';
import 'package:shop_app/models/membrecia.dart';
import 'package:shop_app/Api/membrecia_service.dart';
import 'package:shop_app/Api/token_storage_service.dart';

class MembershipScreen extends StatelessWidget {
  static String routeName = "/membership";

  const MembershipScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Membresías"),
        backgroundColor: kPrimaryColor,
      ),
      body: FutureBuilder<List<Membresia>>(
        future: ApiService().fetchMembresias(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No se encontraron membresías'));
          } else {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: snapshot.data!.map((membresia) {
                  return MembershipOption(
                    title: membresia.titulo,
                    features: [membresia.descripcion],
                    price: '${membresia.precio} USD',
                    color: const Color.fromARGB(255, 132, 171, 134),
                    icon: Icons.star_border,
                    onPressed: () async {
                      String? userId = await TokenStorageService.getUserId();
                      try {
                        print('ID de la membresía antes de navegar: ${membresia.id}');
                        await Navigator.pushNamed(
                          context,
                          CheckoutPage.routeName,
                          arguments: {
                            'membershipType': membresia.titulo,
                            'price': double.parse(membresia.precio),
                            'description': membresia.descripcion,
                            'membresiaId': membresia.id
                          },
                        );
                      } catch (e) {
                        print('Error al navegar: $e');
                        // Puedes mostrar un SnackBar o un diálogo aquí para informar al usuario
                      }
                    },
                  );
                }).toList(),
              ),
            );
          }
        },
      ),
    );
  }
}

class MembershipOption extends StatelessWidget {
  final String title;
  final List<String> features;
  final String price;
  final Color color;
  final IconData icon;
  final VoidCallback onPressed;

  const MembershipOption({
    Key? key,
    required this.title,
    required this.features,
    required this.price,
    required this.color,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 36, color: color),
                SizedBox(width: 10),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            ...features.map((feature) => Text("• $feature")).toList(),
            SizedBox(height: 10),
            Text(
              price,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: color,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: const Text("Adquirir"),
            ),
          ],
        ),
      ),
    );
  }
}
