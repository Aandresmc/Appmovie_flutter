import 'package:cinema_flutter/src/models/movie_model.dart';
import 'package:flutter/material.dart';

class PeliculaDetalle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Pelicula movie = ModalRoute.of(context).settings.arguments;

    return Scaffold(
        body: CustomScrollView(
      slivers: <Widget>[
        _crearAppbar(movie),
        SliverList(
          delegate: SliverChildListDelegate([
            SizedBox(
              height: 10,
            ),
            _posterTitle(movie, context),
            _description(movie),
            _description(movie),
            _description(movie),
            _description(movie),
            _description(movie),

          ]),
        )
      ],
    ));
  }

  Widget _crearAppbar(movie) {
    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.indigo,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          movie.title,
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        background: FadeInImage(
          image: NetworkImage(movie.getBackgroundImg()),
          placeholder: AssetImage('assets/img/loading.gif'),
          fadeInDuration: Duration(microseconds: 150),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _posterTitle(Pelicula movie, BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image(
              image: NetworkImage(movie.getPosterImg()),
              height: 150,
            ),
          ),
          SizedBox(width: 20),
          Flexible(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(movie.title,
                      style: Theme.of(context).textTheme.title,
                      overflow: TextOverflow.ellipsis),
                  Text(movie.originalTitle,
                      style: Theme.of(context).textTheme.subhead,
                      overflow: TextOverflow.ellipsis),
                  Row(
                    children: <Widget>[
                      Icon(Icons.star_border),
                      Text(
                        movie.voteAverage.toString(),
                        style: Theme.of(context).textTheme.subhead,
                      )
                    ],
                  )
                ]),
          )
        ],
      ),
    );
  }

  Widget _description(Pelicula movie) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: Text(movie.overview,
      textAlign: TextAlign.justify),
    );
  }
}
