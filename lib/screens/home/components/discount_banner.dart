// import 'package:flutter/material.dart';
// import 'package:shop_app/screens/membership/membership_screen.dart';

// class DiscountBanner extends StatelessWidget {
//   const DiscountBanner({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.pushNamed(context, MembershipScreen.routeName);
//       },
//       child: Container(
//         width: double.infinity,
//         margin: const EdgeInsets.all(20),
//         padding: const EdgeInsets.symmetric(
//           horizontal: 20,
//           vertical: 16,
//         ),
//         decoration: BoxDecoration(
//           color: const Color(0xFF4A3298),
//           borderRadius: BorderRadius.circular(20),
//         ),
//         child: const Text.rich(
//           TextSpan(
//             style: TextStyle(color: Colors.white),
//             children: [
//               TextSpan(text: "Mejora tus Publicaciones con Membrecías!! \n"),
//               TextSpan(
//                 text: "Accede a Etiquetas y Posicionamiento para tu anuncio!! ",
//                 style: TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
