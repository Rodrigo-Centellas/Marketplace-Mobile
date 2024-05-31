// import 'package:flutter/material.dart';

// import '../../../components/product_card.dart';
// import '../../../models/Product.dart';
// import '../../details/details_screen.dart';
// import '../../products/products_screen.dart';
// import 'section_title.dart';

// class PopularProducts extends StatelessWidget {
//   const PopularProducts({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20),
//           child: SectionTitle(
//             title: "Explorar Publicaciones",
//             press: () {
//               Navigator.pushNamed(context, ProductsScreen.routeName);
//             },
//           ),
//         ),
//         SingleChildScrollView(
//           scrollDirection: Axis.horizontal,
//           child: Row(
//             children: [
//               ...List.generate(
//                 demoProducts.length,
//                 (index) {
//                   if (demoProducts[index].isPopular) {
//                     return Padding(
//                       padding: const EdgeInsets.only(left: 20),
//                       child: ProductCard(
//                         product: demoProducts[index],
//                         onPress: () => Navigator.pushNamed(
//                           context,
//                           DetailsScreen.routeName,
//                           arguments: ProductDetailsArguments(
//                               product: demoProducts[index]),
//                         ),
//                       ),
//                     );
//                   }

//                   return const SizedBox
//                       .shrink(); // here by default width and height is 0
//                 },
//               ),
//               const SizedBox(width: 20),
//             ],
//           ),
//         )
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import '../../../components/product_card.dart';
import '../../../models/Product.dart';
import '../../details/details_screen.dart';
import '../../products/products_screen.dart';
import 'section_title.dart';
import 'package:shop_app/Api/AnuncioApi.dart';

class PopularProducts extends StatefulWidget {
  const PopularProducts({super.key});

  @override
  _PopularProductsState createState() => _PopularProductsState();
}

class _PopularProductsState extends State<PopularProducts> {
  late Future<List<Product>> _popularProductsFuture;

  @override
  void initState() {
    super.initState();
    _popularProductsFuture = _fetchPopularProducts();
  }

  Future<List<Product>> _fetchPopularProducts() async {
    final anuncios = await ApiService().fetchAnuncios();
    debugPrint('Anuncios obtenidos: ${anuncios.length}'); // Agrega un debugPrint para verificar si se obtienen los anuncios

    return getProductsFromAnuncios(anuncios);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SectionTitle(
            title: "Explorar Publicaciones",
            press: () {
              Navigator.pushNamed(context, ProductsScreen.routeName);
            },
          ),
        ),
        FutureBuilder<List<Product>>(
          future: _popularProductsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              final popularProducts = snapshot.data!;
              return SizedBox(
                height: 250, // Agrega un alto fijo al SingleChildScrollView
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      ...popularProducts.map(
                        (product) => Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: SizedBox(
                            width: 160, // Agrega un ancho fijo al ProductCard
                            child: ProductCard(
                              product: product,
                              onPress: () => Navigator.pushNamed(
                                context,
                                DetailsScreen.routeName,
                                arguments: ProductDetailsArguments(product: product),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                    ],
                  ),
                ),
              );
            }
          },
        ),
      ],
    );
  }
}