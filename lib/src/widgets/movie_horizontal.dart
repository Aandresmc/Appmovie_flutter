import 'package:cinema_flutter/src/models/movie_model.dart';
import 'package:flutter/material.dart';

class MovieHorizontal extends StatelessWidget {
  MovieHorizontal({@required this.peliculas, @required this.siguientePagina});

  final List<Pelicula> peliculas;
  final Function siguientePagina;

  final _pageController = new PageController(
    initialPage: 1,
    viewportFraction: 0.3,
  );

  Widget _tarjeta(Pelicula movie, BuildContext context) {
    movie.uniqueId = '${movie.id}-poster';

    final tarjeta = Container(
      margin: EdgeInsets.only(right: 15),
      child: Column(
        children: <Widget>[
          Hero(
            tag: movie.uniqueId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                image: NetworkImage(movie.getPosterImg()),
                placeholder: AssetImage('assets/images/no_image.jpg'),
                fit: BoxFit.cover,
                height: 160,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Text(
              movie.title,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.caption,
            ),
          )
        ],
      ),
    );

    return GestureDetector(
      child: tarjeta,
      onTap: () => Navigator.pushNamed(context, 'detalle', arguments: movie),
    );
  }

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    _pageController.addListener(() {
      double position = _pageController.position.pixels;
      double maxWidthScroll = _pageController.position.maxScrollExtent - 250;

      if (position >= maxWidthScroll) {
        siguientePagina();
      }
    });
    return Container(
      height: _screenSize.height * 0.3,
      child: PageView.builder(
        itemCount: peliculas.length,
        pageSnapping: false, //free move
        controller: _pageController,
        itemBuilder: (context, i) => _tarjeta(peliculas[i], context),
      ),
    );
  }
}
