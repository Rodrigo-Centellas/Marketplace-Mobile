// import 'package:flutter/material.dart';
// import 'package:shop_app/constants.dart';
// import 'package:shop_app/screens/payment/payment_screen.dart';

// class MembershipScreen extends StatelessWidget {
//   static String routeName = "/membership";

//   const MembershipScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Membresías"),
//         backgroundColor: kPrimaryColor,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             MembershipOption(
//               title: "Membresía Estándar",
//               features: ["5 anuncios gratis por mes"],
//               price: "Gratis",
//               color: Colors.blueGrey,
//               icon: Icons.star_border,
//               onPressed: () {
//                 // Lógica para adquirir la membresía estándar
//               },
//             ),
//             MembershipOption(
//               title: "Membresía Gold",
//               features: [
//                 "Acceso ilimitado a etiquetas",
//                 "10 anuncios gratis por mes",
//               ],
//               price: "\$9.99/mes",
//               color: Colors.amber,
//               icon: Icons.star,
//               onPressed: () {
//                 Navigator.pushNamed(
//                   context,
//                   PaymentScreen.routeName,
//                   arguments: PaymentScreenArguments(
//                     membershipType: "Gold",
//                     price: "9.99", // Pass the numeric value as a string
//                     userId: 1, // Replace with actual user ID
//                     // Replace with actual anuncio ID
//                   ),
//                 );
//               },
//             ),
//             MembershipOption(
//               title: "Membresía Premium",
//               features: [
//                 "Anuncios ilimitados",
//                 "Acceso ilimitado a etiquetas",
//                 "Acceso ilimitado a Posicionamientos",
//                 "Creación de descuentos",
//               ],
//               price: "\$19.99/mes",
//               color: Colors.orange,
//               icon: Icons.star_purple500_outlined,
//               onPressed: () {
//                 Navigator.pushNamed(
//                   context,
//                   PaymentScreen.routeName,
//                   arguments: PaymentScreenArguments(
//                     membershipType: "Premium",
//                     price: "19.99", // Pass the numeric value as a string
//                     userId: 1, // Replace with actual user ID
//                    // Replace with actual anuncio ID
//                   ),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class MembershipOption extends StatelessWidget {
//   final String title;
//   final List<String> features;
//   final String price;
//   final Color color;
//   final IconData icon;
//   final VoidCallback onPressed;

//   const MembershipOption({
//     Key? key,
//     required this.title,
//     required this.features,
//     required this.price,
//     required this.color,
//     required this.icon,
//     required this.onPressed,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: const EdgeInsets.symmetric(vertical: 10),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(15),
//       ),
//       elevation: 5,
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 Icon(icon, size: 36, color: color),
//                 SizedBox(width: 10),
//                 Text(
//                   title,
//                   style: TextStyle(
//                     fontSize: 22,
//                     fontWeight: FontWeight.bold,
//                     color: color,
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 10),
//             ...features.map((feature) => Text("• $feature")).toList(),
//             SizedBox(height: 10),
//             Text(
//               price,
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//                 color: color,
//               ),
//             ),
//             SizedBox(height: 10),
//             ElevatedButton(
//               onPressed: onPressed,
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: color,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(15),
//                 ),
//               ),
//               child: const Text("Adquirir"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
