import 'package:flutter/material.dart';
import 'package:shop_app/Api/AnuncioApi.dart';
import 'package:shop_app/models/anuncio.dart';

class ApiTestView extends StatefulWidget {
  @override
  _ApiTestViewState createState() => _ApiTestViewState();
}

class _ApiTestViewState extends State<ApiTestView> {
  late Future<List<Anuncio>> _futureAnuncios;

  @override
  void initState() {
    super.initState();
    _futureAnuncios = ApiService().fetchAnuncios();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Anuncios'),
      ),
      body: FutureBuilder<List<Anuncio>>(
        future: _futureAnuncios,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final anuncios = snapshot.data!;
            return ListView.builder(
              itemCount: anuncios.length,
              itemBuilder: (context, index) {
                final anuncio = anuncios[index];
                return Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      anuncio.imagen.url.isNotEmpty
                          ? Image.network(anuncio.imagen.fullImageUrl)
                          : Container(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              anuncio.titulo,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                              ),
                            ),
                            SizedBox(height: 4.0),
                            Text(
                              '${anuncio.precio} ${anuncio.moneda.nombre}',
                              style: TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('${snapshot.error}'),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}