import 'package:cinema_flutter/src/models/movie_model.dart';
import 'package:cinema_flutter/src/providers/movies_provider.dart';
import 'package:flutter/material.dart';

class DataSearch extends SearchDelegate {
  final _peliculasProvider = new PeliculasProvider();

  String seleccion = '';
  final peliculas = [
    'Spiderman',
    'Aquaman',
    'guason',
    'broma asesina',
    'los vengadores',
    'iron man',
    'gotham'
  ];

  final peliculasRecientes = ['Spiderman', 'Batman', 'capitan america'];

  @override
  List<Widget> buildActions(BuildContext context) {
    // Las acciones de nuetro AppBar
    return [
      IconButton(
        icon: AnimatedIcon(
            icon: AnimatedIcons.menu_close, progress: transitionAnimation),
        onPressed: () => query = '',
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Iconos de comienzo  (la izquierda) atras, search etc
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // crea los resultados que vamos a mostrar
    return Center(
      child: Container(
        height: 100,
        width: 200,
        color: Colors.lightBlueAccent,
        child: Text(seleccion),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // sugerencias que parecen cuando la persona escribe
    if (query.isEmpty) return Container();

    return FutureBuilder(
      future: _peliculasProvider.buscarPelicula(query),
      builder: (BuildContext context, AsyncSnapshot<List<Pelicula>> snapshot) {
        if (snapshot.hasData) {
          final peliculas = snapshot.data;

          return ListView(
            children: peliculas.map((pelicula) {
              return ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.vertical(
                       top: new Radius.circular(12),
                      bottom: new Radius.circular(12)
                  ),
                  child: FadeInImage(
                    image: NetworkImage(pelicula.getPosterImg()),
                    placeholder: AssetImage('assets/images/no_image.jpg'),
                    width: 50,
                    fit: BoxFit.contain,
                  ),
                ),
                title: Text(pelicula.title),
                subtitle: Text(pelicula.originalTitle),
                onTap: () {
                  close(context, null);
                  pelicula.uniqueId = '';
                  Navigator.pushNamed(context, 'detalle',arguments: pelicula);
                },
              );
            }).toList(),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  // @override
  // Widget buildSuggestions(BuildContext context) {
  //   // sugerencias que parecen cuando la persona escribe

  //   final listaSugerida = (query.isEmpty)
  //       ? peliculasRecientes
  //       : peliculas
  //           .where((p) => p.toLowerCase().startsWith(query.toLowerCase()))
  //           .toList();

  //   return ListView.builder(
  //     itemCount: listaSugerida.length,
  //     itemBuilder: (context, i) {
  //       return ListTile(
  //         leading: Icon(Icons.movie),
  //         title: Text(listaSugerida[i]),
  //         onTap: () {
  //            seleccion = listaSugerida[i];
  //            showResults(context);
  //         },
  //       );
  //     },
  //   );
  // }
}
