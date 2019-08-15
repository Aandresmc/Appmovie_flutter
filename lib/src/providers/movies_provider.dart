import 'dart:async';
import 'dart:convert';
import 'package:cinema_flutter/src/models/actors_model.dart';
import 'package:http/http.dart' as http;
import 'package:cinema_flutter/src/models/movie_model.dart';

class PeliculasProvider {
  String _apikey = '0aef5baa91e2a6c172431d3273515ab3';
  String _url = 'api.themoviedb.org';
  String _language = 'es-Es';

  int _popularesPage = 0;
  bool _cargando = false;

  List<Pelicula> _populares = new List();

  final _popularesStreamController =
      StreamController<List<Pelicula>>.broadcast();

  Function(List<Pelicula>) get popularesSink =>
      _popularesStreamController.sink.add; //agregar data
  Stream<List<Pelicula>> get popularesStream =>
      _popularesStreamController.stream; //obtener data

  void disposeStreams() {
    _popularesStreamController?.close();
  }

  Future<List<Pelicula>> _procesarRespuesta(Uri url) async {
    final resp = await http.get(url);
    final decodeData = jsonDecode(resp.body);
    final resultado = Peliculas.fromJsonList(decodeData['results']);

    return resultado.peliculas;
  }

  Future<List<Pelicula>> getEnCines() async {
    // example : https://api.themoviedb.org/3/movie/now_playing?api_key=0aef5baa91e2a6c172431d3273515ab3&language=es-ES&page=1

    final url = Uri.https(_url, '3/movie/now_playing',
        {'api_key': _apikey, 'language': _language});

    return await _procesarRespuesta(url);
  }

  Future<List<Pelicula>> getPopulares() async {
    if (_cargando) return [];

    _cargando = true;

    _popularesPage++;

    // example : https://api.themoviedb.org/3/movie/now_playing?api_key=0aef5baa91e2a6c172431d3273515ab3&language=es-ES&page=1

    final url = Uri.https(_url, '3/movie/popular', {
      'api_key': _apikey,
      'language': _language,
      'page': _popularesPage.toString()
    });

    final resp = await _procesarRespuesta(url);

    _populares.addAll(resp);
    popularesSink(_populares);

    _cargando = false;

    return resp;
  }

  Future<List<Actor>> getCast(String peliId) async {
    final url = Uri.https(_url, '3/movie/$peliId/credits',
        {'api_key': _apikey, 'language': _language});

    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);

    final cast = new Cast.fromJsonList(decodedData['cast']);

    return cast.actores;
  }

  Future<List<Pelicula>> buscarPelicula(String name) async {
    final url = Uri.https(_url, '3/search/movie',
        {'api_key': _apikey, 'language': _language, 'query': name});

      return  await _procesarRespuesta(url);

  }
}
