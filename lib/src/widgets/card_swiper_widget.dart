import 'package:cinema_flutter/src/models/movie_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class SwiperCards extends StatelessWidget {
  final List<Pelicula> peliculas;
  //array de peliculas

  SwiperCards({@required this.peliculas});
  // obligo con el decorador a que envien peliculas para que
  //  el constructor incialize el array de peliculas

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      child: Swiper(
        itemBuilder: (BuildContext context, int index) => ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              image: NetworkImage(peliculas[index].getPosterImg()),
              placeholder: AssetImage('assets/images/loading-poster.gif'),
              fit: BoxFit.cover,
            )),
        itemCount: peliculas.length,
        itemHeight: _screenSize.height * 0.50, // 0.5 = 50% de la pantalla,
        itemWidth: _screenSize.width * 0.70,
        layout: SwiperLayout.STACK,
        // pagination: SwiperPagination(),
        // control: SwiperControl(),
      ),
    );
  }
}
